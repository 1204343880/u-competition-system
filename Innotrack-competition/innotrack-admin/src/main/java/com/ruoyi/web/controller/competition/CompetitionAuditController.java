package com.ruoyi.web.controller.competition;

import java.util.Date;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.mq.RabbitMqProducer;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompetitionApply;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.ICompTeamService;
import com.ruoyi.system.service.ICompetitionApplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "竞赛审核管理（管理员）")
@PreAuthorize("@ss.hasPermi('system:competition:audit')")
@RestController
@RequestMapping("/system/competition/audit")
public class CompetitionAuditController extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(CompetitionAuditController.class);

    @Autowired
    private ICompetitionApplyService applyService;

    @Autowired
    private ICompTeamService teamService;

    @Autowired
    private RabbitMqProducer rabbitMqProducer;

    @Operation(summary = "分页查询报名审核列表")
    @GetMapping("/apply/list")
    public TableDataInfo applyAuditList(
            @Parameter(description = "审核状态（0待审核 1通过 2拒绝）")
            @RequestParam(required = false) String auditStatus,
            @Parameter(description = "姓名（模糊查询）")
            @RequestParam(required = false) String userName,
            @Parameter(description = "竞赛名称（模糊查询）")
            @RequestParam(required = false) String competitionName)
    {
        CompetitionApply apply = new CompetitionApply();
        apply.setAuditStatus(auditStatus);
        apply.setUserName(userName);
        apply.setCompetitionName(competitionName);
        startPage();
        List<CompetitionApply> list = applyService.selectApplyAuditList(apply);
        return getDataTable(list);
    }

    @Operation(summary = "审核报名（通过/拒绝）")
    @PutMapping("/apply")
    public AjaxResult auditApply(
            @RequestBody CompetitionApply apply)
    {
        CompetitionApply exist = applyService.selectApplyByIdRaw(apply.getApplyId());
        if (exist == null)
        {
            return error("报名记录不存在");
        }
        CompetitionApply update = new CompetitionApply();
        update.setApplyId(apply.getApplyId());
        update.setAuditStatus(apply.getAuditStatus());
        update.setAuditRemark(apply.getAuditRemark());
        update.setAuditBy(SecurityUtils.getUsername());
        update.setAuditTime(new Date());
        applyService.auditApply(update);

        sendApplyNotification(exist, apply.getAuditStatus());
        return success("审核完成");
    }

    @Operation(summary = "分页查询队伍审核列表")
    @GetMapping("/team/list")
    public TableDataInfo teamAuditList(
            @Parameter(description = "队伍状态（0组队中 1已提交 2审核通过）")
            @RequestParam(required = false) String status,
            @Parameter(description = "队伍名称（模糊查询）")
            @RequestParam(required = false) String teamName,
            @Parameter(description = "竞赛名称（模糊查询）")
            @RequestParam(required = false) String competitionName)
    {
        CompTeam team = new CompTeam();
        team.setStatus(status);
        team.setTeamName(teamName);
        team.setCompetitionName(competitionName);
        startPage();
        List<CompTeam> list = teamService.selectTeamAuditList(team);
        return getDataTable(list);
    }

    @Operation(summary = "审核队伍（通过/拒绝）")
    @PutMapping("/team")
    public AjaxResult auditTeam(
            @RequestBody CompTeam team)
    {
        CompTeam exist = teamService.getTeamById(team.getTeamId());
        if (exist == null)
        {
            return error("队伍不存在");
        }
        teamService.auditTeam(team);

        sendTeamNotification(exist, team.getStatus());
        return success("审核完成");
    }

    @Operation(summary = "查询队伍详情（管理员）")
    @GetMapping("/team/{teamId}")
    public AjaxResult teamDetail(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId)
    {
        return success(teamService.getTeamMembers(teamId));
    }

    private void sendApplyNotification(CompetitionApply apply, String auditStatus)
    {
        UserNotification notification = new UserNotification();
        notification.setUserId(apply.getUserId());
        notification.setBizType("apply");
        notification.setBizId(apply.getApplyId());
        if ("1".equals(auditStatus))
        {
            notification.setTitle("报名审核通过");
            notification.setContent("你报名的【" + apply.getCompetitionName() + "】已通过审核");
        }
        else
        {
            notification.setTitle("报名审核被拒绝");
            notification.setContent("你报名的【" + apply.getCompetitionName() + "】审核被拒绝");
        }
        sendNotificationSafely(notification);
    }

    private void sendTeamNotification(CompTeam team, String auditStatus)
    {
        UserNotification notification = new UserNotification();
        notification.setUserId(team.getLeaderId());
        notification.setBizType("team");
        notification.setBizId(team.getTeamId());
        if ("2".equals(auditStatus))
        {
            notification.setTitle("队伍审核通过");
            notification.setContent("你的队伍【" + team.getTeamName() + "】已通过审核，获得参赛资格");
        }
        else
        {
            notification.setTitle("队伍审核被驳回");
            notification.setContent("你的队伍【" + team.getTeamName() + "】审核被驳回，请修改后重新提交");
        }
        sendNotificationSafely(notification);
    }

    /**
     * Notifications are auxiliary. A temporary MQ outage must not turn an
     * already completed audit into a failed HTTP response.
     */
    private void sendNotificationSafely(UserNotification notification)
    {
        try
        {
            rabbitMqProducer.sendNotification(notification);
        }
        catch (Exception ex)
        {
            log.warn("Audit succeeded but notification delivery failed: bizType={}, bizId={}",
                    notification.getBizType(), notification.getBizId(), ex);
        }
    }
}
