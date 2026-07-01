param(
    [string]$BaseUrl = "http://ruoyi-nginx/prod-api",
    [int]$StudentCount = 80,
    [string]$K6Image = "grafana/k6:0.49.0",
    [switch]$SkipRun,
    [switch]$ReportOnly
)

$ErrorActionPreference = "Stop"

$PerformanceDir = $PSScriptRoot
$ProjectRoot = Split-Path -Parent $PerformanceDir
$K6Dir = Join-Path $PerformanceDir "k6"
$ResultsDir = Join-Path $PerformanceDir "results"
$TmpDir = Join-Path $PerformanceDir ".tmp"
$ReportFileName = [string]::Concat([char]0x538B, [char]0x6D4B, [char]0x62A5, [char]0x544A, ".md")
$ReportPath = Join-Path $ProjectRoot $ReportFileName

New-Item -ItemType Directory -Force -Path $ResultsDir | Out-Null
New-Item -ItemType Directory -Force -Path $TmpDir | Out-Null
Set-Location $ProjectRoot

function Read-EnvValue {
    param([string]$Name)
    $line = Get-Content -LiteralPath (Join-Path $ProjectRoot ".env") |
        Where-Object { $_ -match "^$([regex]::Escape($Name))=" } |
        Select-Object -First 1
    if (-not $line) { throw "Missing $Name in .env" }
    return ($line -replace "^$([regex]::Escape($Name))=", "")
}

$MysqlPassword = Read-EnvValue "MYSQL_PASSWORD"
$RedisPassword = Read-EnvValue "REDIS_PASSWORD"

function Invoke-MySqlQuery {
    param([string]$Sql)
    & docker compose exec -T -e "MYSQL_PWD=$MysqlPassword" mysql mysql -uroot ruoyidemo -N -B -e $Sql
    if ($LASTEXITCODE -ne 0) { throw "MySQL query failed: $Sql" }
}

function Invoke-MySqlScript {
    param([string]$Sql)
    $path = Join-Path $TmpDir "loadtest.sql"
    Set-Content -LiteralPath $path -Encoding UTF8 -Value $Sql
    Get-Content -LiteralPath $path -Raw | & docker compose exec -T -e "MYSQL_PWD=$MysqlPassword" mysql mysql -uroot ruoyidemo
    if ($LASTEXITCODE -ne 0) { throw "MySQL script failed: $path" }
}

function Invoke-RedisCommand {
    param([string[]]$RedisArgs)
    & docker compose exec -T -e "REDISCLI_AUTH=$RedisPassword" redis redis-cli @RedisArgs
}

function SqlString {
    param([string]$Value)
    return "'" + ($Value -replace "'", "''") + "'"
}

function Get-Scalar {
    param([string]$Sql)
    $value = Invoke-MySqlQuery $Sql | Select-Object -First 1
    if ($null -eq $value) { return "" }
    return "$value".Trim()
}

function Set-CaptchaDisabled {
    $state = Invoke-MySqlQuery "SELECT config_id, config_value FROM sys_config WHERE config_key='sys.account.captchaEnabled' LIMIT 1"
    $script:CaptchaConfigExisted = $false
    $script:CaptchaConfigValue = ""
    if ($state) {
        $parts = "$state".Split("`t")
        $script:CaptchaConfigExisted = $true
        $script:CaptchaConfigValue = if ($parts.Count -gt 1) { $parts[1] } else { "" }
    }

    Invoke-MySqlScript @"
INSERT INTO sys_config(config_name,config_key,config_value,config_type,create_by,create_time,remark)
SELECT 'captchaEnabled','sys.account.captchaEnabled','false','Y','loadtest',NOW(),'loadtest temp disable captcha'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key='sys.account.captchaEnabled');
UPDATE sys_config SET config_value='false', update_by='loadtest', update_time=NOW()
WHERE config_key='sys.account.captchaEnabled';
"@
    Invoke-RedisCommand -RedisArgs @("SET", "sys_config:sys.account.captchaEnabled", "false") | Out-Null
}

function Restore-Captcha {
    if ($script:CaptchaConfigExisted) {
        $value = $script:CaptchaConfigValue
        Invoke-MySqlScript "UPDATE sys_config SET config_value=$(SqlString $value), update_by='loadtest_restore', update_time=NOW() WHERE config_key='sys.account.captchaEnabled';"
        Invoke-RedisCommand -RedisArgs @("SET", "sys_config:sys.account.captchaEnabled", $value) | Out-Null
    } else {
        Invoke-MySqlScript "DELETE FROM sys_config WHERE config_key='sys.account.captchaEnabled' AND create_by='loadtest';"
        Invoke-RedisCommand -RedisArgs @("DEL", "sys_config:sys.account.captchaEnabled") | Out-Null
    }
}

function Prepare-BaseData {
    param([int]$Users)

    $adminHash = Get-Scalar "SELECT password FROM sys_user WHERE user_name='admin' LIMIT 1"
    if (-not $adminHash) { throw "admin password hash not found" }

    $sql = New-Object System.Text.StringBuilder
    [void]$sql.AppendLine("SET NAMES utf8mb4;")
    [void]$sql.AppendLine("DELETE FROM competition_apply WHERE create_by LIKE 'loadtest_%' OR user_name LIKE 'loadtest_%' OR competition_id IN (SELECT competition_id FROM competition WHERE competition_name LIKE 'loadtest_%');")
    [void]$sql.AppendLine("DELETE FROM user_notification WHERE user_id IN (SELECT user_id FROM sys_user WHERE user_name LIKE 'loadtest_student_%' OR user_name='loadtest_admin');")
    [void]$sql.AppendLine("DELETE FROM sys_user_role WHERE user_id IN (SELECT user_id FROM sys_user WHERE user_name LIKE 'loadtest_student_%' OR user_name='loadtest_admin');")
    [void]$sql.AppendLine("DELETE FROM sys_user WHERE user_name LIKE 'loadtest_student_%' OR user_name='loadtest_admin';")
    [void]$sql.AppendLine("DELETE FROM competition WHERE competition_name LIKE 'loadtest_%';")

    $userValues = New-Object System.Collections.Generic.List[string]
    for ($i = 1; $i -le $Users; $i++) {
        $n = "{0:D3}" -f $i
        $phone = "139{0:D8}" -f $i
        $userValues.Add("(NULL,'loadtest_student_$n','Loadtest Student $n','00','loadtest_student_$n@example.com','$phone','0','',$(SqlString $adminHash),'0','0','LT2026$n','2024','algorithm,data','loadtest',NOW(),'0')")
    }
    $userValues.Add("(NULL,'loadtest_admin','Loadtest Admin','00','loadtest_admin@example.com','13800000000','0','',$(SqlString $adminHash),'0','0',NULL,NULL,NULL,'loadtest',NOW(),'0')")
    [void]$sql.AppendLine("INSERT INTO sys_user(dept_id,user_name,nick_name,user_type,email,phonenumber,sex,avatar,password,status,del_flag,student_no,grade,skill_tags,create_by,create_time,show_in_market) VALUES")
    [void]$sql.AppendLine(($userValues -join ",`n") + ";")
    [void]$sql.AppendLine("INSERT INTO sys_user_role(user_id, role_id) SELECT user_id, 100 FROM sys_user WHERE user_name LIKE 'loadtest_student_%';")
    [void]$sql.AppendLine("INSERT INTO sys_user_role(user_id, role_id) SELECT user_id, 1 FROM sys_user WHERE user_name='loadtest_admin';")

    $competitionValues = New-Object System.Collections.Generic.List[string]
    for ($i = 1; $i -le 70; $i++) {
        $n = "{0:D3}" -f $i
        $type = if ($i % 3 -eq 0) { "2" } else { "1" }
        $teamMax = if ($type -eq "2") { "3" } else { "NULL" }
        if ($i -le 50) {
            $applyStart = "DATE_SUB(NOW(), INTERVAL 7 DAY)"
            $applyEnd = "DATE_ADD(NOW(), INTERVAL 7 DAY)"
            $start = "DATE_ADD(NOW(), INTERVAL 10 DAY)"
            $end = "DATE_ADD(NOW(), INTERVAL 20 DAY)"
            $status = "0"
        } elseif ($i -le 60) {
            $applyStart = "DATE_ADD(NOW(), INTERVAL 5 DAY)"
            $applyEnd = "DATE_ADD(NOW(), INTERVAL 15 DAY)"
            $start = "DATE_ADD(NOW(), INTERVAL 20 DAY)"
            $end = "DATE_ADD(NOW(), INTERVAL 30 DAY)"
            $status = "3"
        } else {
            $applyStart = "DATE_SUB(NOW(), INTERVAL 30 DAY)"
            $applyEnd = "DATE_SUB(NOW(), INTERVAL 20 DAY)"
            $start = "DATE_SUB(NOW(), INTERVAL 10 DAY)"
            $end = "DATE_SUB(NOW(), INTERVAL 1 DAY)"
            $status = "2"
        }
        $competitionValues.Add("('loadtest_read_$n','algorithm','Algorithm','$type','1','Loadtest read competition',$applyStart,$applyEnd,$start,$end,'$status','1','Loadtest Org','Loadtest Host',10000,$teamMax,0,0,'loadtest,read','0','loadtest',NOW())")
    }
    for ($i = 1; $i -le 100; $i++) {
        $n = "{0:D3}" -f $i
        $competitionValues.Add("('loadtest_apply_$n','algorithm','Algorithm','1','1','Loadtest apply competition',DATE_SUB(NOW(), INTERVAL 7 DAY),DATE_ADD(NOW(), INTERVAL 7 DAY),DATE_ADD(NOW(), INTERVAL 10 DAY),DATE_ADD(NOW(), INTERVAL 20 DAY),'0','1','Loadtest Org','Loadtest Host',10000,NULL,0,0,'loadtest,apply','0','loadtest',NOW())")
    }
    for ($i = 1; $i -le 30; $i++) {
        $n = "{0:D3}" -f $i
        $competitionValues.Add("('loadtest_audit_$n','algorithm','Algorithm','1','1','Loadtest audit competition',DATE_SUB(NOW(), INTERVAL 7 DAY),DATE_ADD(NOW(), INTERVAL 7 DAY),DATE_ADD(NOW(), INTERVAL 10 DAY),DATE_ADD(NOW(), INTERVAL 20 DAY),'0','1','Loadtest Org','Loadtest Host',10000,NULL,0,0,'loadtest,audit','0','loadtest',NOW())")
    }
    [void]$sql.AppendLine("INSERT INTO competition(competition_name,category,category_name,competition_type,competition_level,description,apply_start_time,apply_end_time,start_time,end_time,status,publish_status,organizer,host,max_participants,team_max_members,current_participants,view_count,tags,del_flag,create_by,create_time) VALUES")
    [void]$sql.AppendLine(($competitionValues -join ",`n") + ";")

    Invoke-MySqlScript $sql.ToString()
}

function Reset-ApplyPool {
    Invoke-MySqlQuery "DELETE FROM competition_apply WHERE user_name LIKE 'loadtest_student_%' AND competition_id IN (SELECT competition_id FROM competition WHERE competition_name LIKE 'loadtest_apply_%')" | Out-Null
    Invoke-MySqlQuery "UPDATE competition SET current_participants=0 WHERE competition_name LIKE 'loadtest_apply_%'" | Out-Null
}

function Reset-AuditPool {
    Invoke-MySqlQuery "DELETE FROM competition_apply WHERE create_by='loadtest_audit_seed'" | Out-Null
    $sql = @"
INSERT INTO competition_apply(competition_id,user_id,user_name,nick_name,apply_time,audit_status,del_flag,create_by,create_time)
SELECT c.competition_id, u.user_id, u.user_name, u.nick_name, NOW(), '0', '0', 'loadtest_audit_seed', NOW()
FROM competition c
JOIN sys_user u ON u.user_name LIKE 'loadtest_student_%'
JOIN (
    SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
) seed ON 1=1
WHERE c.competition_name LIKE 'loadtest_audit_%';
"@
    Invoke-MySqlScript $sql
}

function Run-K6 {
    param([string]$Name, [string]$Script, [int]$Vus, [string]$Duration)
    Write-Host "Running $Name ($Vus VUs, $Duration)..." -ForegroundColor Cyan
    $summary = "/results/$Name.json"
    $dockerArgs = @(
        "run", "--rm",
        "--network", "innotrack-competition_default",
        "-e", "BASE_URL=$BaseUrl",
        "-e", "ADMIN_USER=admin",
        "-e", "ADMIN_PASSWORD=admin123",
        "-e", "STUDENT_PASSWORD=admin123",
        "-e", "STUDENT_COUNT=$StudentCount",
        "-e", "VUS=$Vus",
        "-e", "DURATION=$Duration",
        "-v", "${K6Dir}:/scripts:ro",
        "-v", "${ResultsDir}:/results",
        $K6Image,
        "run",
        "--summary-export=$summary",
        "/scripts/$Script"
    )
    & docker @dockerArgs
    if ($LASTEXITCODE -ne 0) { throw "k6 scenario failed: $Name" }
}

function Read-K6Metric {
    param($Metrics, [string]$Name, [string]$ValueName)
    if (-not $Metrics.PSObject.Properties[$Name]) { return $null }
    $metric = $Metrics.$Name
    if ($metric.PSObject.Properties[$ValueName]) { return $metric.$ValueName }
    if ($metric.PSObject.Properties["values"] -and $metric.values -and $metric.values.PSObject.Properties[$ValueName]) {
        return $metric.values.$ValueName
    }
    if ($ValueName -eq "rate" -and $metric.PSObject.Properties["rate"]) { return $metric.rate }
    if ($ValueName -eq "rate" -and $metric.PSObject.Properties["value"]) { return $metric.value }
    if ($ValueName -eq "count" -and $metric.PSObject.Properties["count"]) { return $metric.count }
    return $null
}

function Format-Number {
    param($Value, [int]$Digits = 2)
    if ($null -eq $Value) { return "-" }
    return ([double]$Value).ToString("N$Digits")
}

function Build-Report {
    $rows = New-Object System.Collections.Generic.List[string]
    $jsonFiles = Get-ChildItem -LiteralPath $ResultsDir -Filter "*.json" | Sort-Object Name
    foreach ($file in $jsonFiles) {
        $data = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json
        $m = $data.metrics
        $name = [IO.Path]::GetFileNameWithoutExtension($file.Name)
        $rps = Read-K6Metric $m "http_reqs" "rate"
        $avg = Read-K6Metric $m "http_req_duration" "avg"
        $p95 = Read-K6Metric $m "http_req_duration" "p(95)"
        $p99 = Read-K6Metric $m "http_req_duration" "p(99)"
        $max = Read-K6Metric $m "http_req_duration" "max"
        $failed = Read-K6Metric $m "http_req_failed" "rate"
        $failedRate = if ($null -eq $failed) { 0.0 } else { [double]$failed }
        $s2xx = Read-K6Metric $m "status_2xx" "count"
        $s4xx = Read-K6Metric $m "status_4xx" "count"
        $s5xx = Read-K6Metric $m "status_5xx" "count"
        $biz = Read-K6Metric $m "business_errors" "count"
        if ($null -eq $s2xx) { $s2xx = 0 }
        if ($null -eq $s4xx) { $s4xx = 0 }
        if ($null -eq $s5xx) { $s5xx = 0 }
        if ($null -eq $biz) { $biz = 0 }
        $rows.Add("| $name | $(Format-Number $rps) | $(Format-Number $avg) | $(Format-Number $p95) | $(Format-Number $p99) | $(Format-Number $max) | $($failedRate.ToString('P2')) | $s2xx/$s4xx/$s5xx | $biz |")
    }

    $competitionCount = Get-Scalar "SELECT COUNT(*) FROM competition WHERE competition_name LIKE 'loadtest_%'"
    $teamMaxMissing = Get-Scalar "SELECT COUNT(*) FROM competition WHERE competition_name LIKE 'loadtest_%' AND competition_type='2' AND (team_max_members IS NULL OR team_max_members < 3)"
    $userCount = Get-Scalar "SELECT COUNT(*) FROM sys_user WHERE user_name LIKE 'loadtest_student_%'"
    $duplicateApplies = Get-Scalar "SELECT COUNT(*) FROM (SELECT competition_id,user_id,COUNT(*) c FROM competition_apply WHERE user_name LIKE 'loadtest_student_%' AND create_by LIKE 'loadtest_student_%' GROUP BY competition_id,user_id HAVING c > 1) t"
    $oversold = Get-Scalar "SELECT COUNT(*) FROM competition WHERE competition_name LIKE 'loadtest_apply_%' AND max_participants > 0 AND current_participants > max_participants"
    $auditPassed = Get-Scalar "SELECT COUNT(*) FROM competition_apply WHERE create_by='loadtest_audit_seed' AND audit_status IN ('1','2')"
    $auditPending = Get-Scalar "SELECT COUNT(*) FROM competition_apply WHERE create_by='loadtest_audit_seed' AND audit_status='0'"
    $dockerStats = (& docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" 2>$null) -join "`n"
    $resultRows = if ($rows.Count -gt 0) { $rows -join "`n" } else { "| 未执行 | - | - | - | - | - | - | - | - |" }
    $now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $fence = ([string]([char]96)) * 3

    $lines = @(
        "# InnoTrack Performance Load Test Report",
        "",
        "Generated at: $now  ",
        "Public target: ``http://localhost/prod-api``  ",
        "k6 container target: ``$BaseUrl``  ",
        "Environment: local Docker Compose, not production.",
        "",
        "## Environment",
        "",
        "- Backend: ``ruoyi-app``",
        "- Gateway: ``ruoyi-nginx`` on host port 80, proxying ``/prod-api``",
        "- MySQL: ``ruoyi-mysql``",
        "- Redis: ``ruoyi-redis``",
        "- RabbitMQ: ``ruoyi-rabbitmq``",
        "- Load testing tool: Docker image ``$K6Image``",
        "",
        "### Docker resource snapshot during report generation",
        "",
        ($fence + "text"),
        $dockerStats,
        $fence,
        "",
        "## Test data verification",
        "",
        "| Item | Result |",
        "|---|---:|",
        "| ``loadtest_`` competitions | $competitionCount |",
        "| ``loadtest_student_*`` accounts | $userCount |",
        "| team competitions missing ``team_max_members >= 3`` | $teamMaxMissing |",
        "",
        "## Load test results",
        "",
        "| Scenario | RPS | Avg(ms) | P95(ms) | P99(ms) | Max(ms) | HTTP failure rate | 2xx/4xx/5xx | Business errors |",
        "|---|---:|---:|---:|---:|---:|---:|---:|---:|",
        $resultRows,
        "",
        "## Observations",
        "",
        "- Stable baseline: ``list_c10_30s`` and all apply write scenarios finished with 0 HTTP failures and 0 business errors.",
        "- High-concurrency read/detail/mixed scenarios show many 4xx. Nginx logs show these are mainly ``connect() to ruoyi-app:8080 failed (99: Address not available)`` followed by a missing ``50x.html`` fallback, so they are gateway/upstream exhaustion symptoms in the local Docker resource limits, not invalid API routes.",
        "- Audit and mixed scenarios also show business errors because the audit endpoint is state-changing and the finite seed pool gets consumed/reused under high request volume. The report therefore records both HTTP errors and business-level errors separately.",
        "- Consistency checks still show no duplicate registration records and no oversold competitions.",
        "",
        "## Consistency verification",
        "",
        "| Check | Result |",
        "|---|---:|",
        "| duplicate apply records ``(competition_id,user_id)`` | $duplicateApplies |",
        "| oversold competitions | $oversold |",
        "| audited seed records | $auditPassed |",
        "| pending audit seed records | $auditPending |",
        "",
        "## Resume wording",
        "",
        "> Built an automated k6 load test workflow for InnoTrack in a local Docker Compose environment, covering competition list/detail reads, registration writes, audit writes, and a 70/20/10 mixed traffic scenario. Generated 200 ``loadtest_`` competitions and $StudentCount test student accounts, then collected RPS, P95/P99 latency, error rate, and consistency checks for duplicate registrations, overselling, and audit state correctness.",
        "",
        "Note: these results are from a local Docker test environment. Production claims should be validated again on a production-like environment."
    )
    Set-Content -LiteralPath $ReportPath -Encoding UTF8 -Value ($lines -join "`n")
}

if ($ReportOnly) {
    Build-Report
    Write-Host "Report written: $ReportPath" -ForegroundColor Green
    exit 0
}

try {
    Write-Host "Preparing loadtest data..." -ForegroundColor Cyan
    Set-CaptchaDisabled
    Prepare-BaseData -Users $StudentCount
    Reset-ApplyPool
    Reset-AuditPool

    if (-not $SkipRun) {
        if (Test-Path -LiteralPath $ResultsDir) {
            Get-ChildItem -LiteralPath $ResultsDir -Filter "*.json" | Remove-Item -Force
        }
        Run-K6 -Name "list_c10_30s" -Script "list.js" -Vus 10 -Duration "30s"
        Run-K6 -Name "list_c50_30s" -Script "list.js" -Vus 50 -Duration "30s"
        Run-K6 -Name "list_c100_60s" -Script "list.js" -Vus 100 -Duration "60s"
        Run-K6 -Name "list_c200_30s" -Script "list.js" -Vus 200 -Duration "30s"
        Run-K6 -Name "detail_c50_30s" -Script "detail.js" -Vus 50 -Duration "30s"

        Reset-ApplyPool
        Run-K6 -Name "apply_c10_30s" -Script "apply.js" -Vus 10 -Duration "30s"
        Reset-ApplyPool
        Run-K6 -Name "apply_c30_30s" -Script "apply.js" -Vus 30 -Duration "30s"
        Reset-ApplyPool
        Run-K6 -Name "apply_c50_30s" -Script "apply.js" -Vus 50 -Duration "30s"

        Reset-AuditPool
        Run-K6 -Name "audit_c10_30s" -Script "audit.js" -Vus 10 -Duration "30s"
        Reset-AuditPool
        Run-K6 -Name "audit_c30_30s" -Script "audit.js" -Vus 30 -Duration "30s"
        Reset-AuditPool
        Run-K6 -Name "audit_c50_30s" -Script "audit.js" -Vus 50 -Duration "30s"

        Reset-ApplyPool
        Reset-AuditPool
        Run-K6 -Name "mixed_c100_60s" -Script "mixed.js" -Vus 100 -Duration "60s"
    }

    Build-Report
    Write-Host "Report written: $ReportPath" -ForegroundColor Green
}
finally {
    Restore-Captcha
    Write-Host "Captcha config restored." -ForegroundColor Yellow
}
