-- ================================================================
-- RuoYi 学科竞赛管理系统 - 业务闭环优化脚本 (v6.4)
-- 幂等脚本，可重复执行，已存在的字段/表会自动跳过
-- ================================================================

-- ---------------------------------------------------------------
-- 1. comp_team 表：增加指导教师字段（单导师制）
-- ---------------------------------------------------------------
SET @col_tid = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'comp_team' AND COLUMN_NAME = 'teacher_id');

SET @sql_add_tid = IF(@col_tid = 0,
    'ALTER TABLE comp_team ADD COLUMN teacher_id BIGINT DEFAULT NULL COMMENT ''指导教师用户ID'' AFTER leader_name',
    'SELECT ''comp_team.teacher_id 已存在，跳过'' AS msg');
PREPARE stmt FROM @sql_add_tid;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql_add_tname = IF(@col_tid = 0,
    'ALTER TABLE comp_team ADD COLUMN teacher_name VARCHAR(30) DEFAULT NULL COMMENT ''指导教师姓名'' AFTER teacher_id',
    'SELECT ''comp_team.teacher_name 已存在，跳过'' AS msg');
PREPARE stmt FROM @sql_add_tname;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 回填历史数据
UPDATE comp_team t
INNER JOIN team_teacher_invitation inv
    ON t.team_id = inv.team_id AND inv.status = '1'
SET t.teacher_id = inv.teacher_id, t.teacher_name = inv.teacher_name
WHERE t.teacher_id IS NULL;

-- 兼容索引
SET @idx_exists = (SELECT COUNT(*) FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'comp_team' AND INDEX_NAME = 'idx_comp_team_teacher');

SET @sql_idx = IF(@idx_exists = 0,
    'CREATE INDEX idx_comp_team_teacher ON comp_team(teacher_id)',
    'SELECT ''idx_comp_team_teacher 已存在，跳过'' AS msg');
PREPARE stmt FROM @sql_idx;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ---------------------------------------------------------------
-- 2. competition_result 竞赛成绩记录表
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS competition_result (
    result_id        BIGINT        NOT NULL AUTO_INCREMENT  COMMENT '成绩记录ID',
    competition_id   BIGINT        NOT NULL                 COMMENT '竞赛ID',
    team_id          BIGINT        DEFAULT NULL             COMMENT '队伍ID（团队赛时关联comp_team）',
    user_id          BIGINT        DEFAULT NULL             COMMENT '用户ID（个人赛时关联sys_user）',
    project_name     VARCHAR(100)  DEFAULT NULL             COMMENT '参赛项目名称',
    award_level      VARCHAR(50)   NOT NULL                 COMMENT '获奖级别',
    ranking          INT           DEFAULT NULL             COMMENT '排名',
    score            DECIMAL(10,2) DEFAULT NULL             COMMENT '分数',
    certificate_url  VARCHAR(500)  DEFAULT NULL             COMMENT '证书URL',
    certificate_hash VARCHAR(64)   DEFAULT NULL             COMMENT '证书SHA256',
    result_status    CHAR(1)       DEFAULT '0'              COMMENT '0待审核 1已确认 2已作废',
    create_by        VARCHAR(64)   NOT NULL                 COMMENT '录入人',
    create_time      DATETIME      NOT NULL                 COMMENT '录入时间',
    audit_by         VARCHAR(64)   DEFAULT NULL             COMMENT '审核人',
    audit_time       DATETIME      DEFAULT NULL             COMMENT '审核时间',
    update_by        VARCHAR(64)   DEFAULT NULL             COMMENT '修改人',
    update_time      DATETIME      DEFAULT NULL             COMMENT '修改时间',
    remark           VARCHAR(500)  DEFAULT NULL             COMMENT '备注',
    del_flag         CHAR(1)       DEFAULT '0'              COMMENT '删除标志',
    PRIMARY KEY (result_id),
    INDEX idx_result_competition (competition_id),
    INDEX idx_result_team (team_id),
    INDEX idx_result_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='竞赛成绩记录表';

-- ---------------------------------------------------------------
-- 3. competition_audit_log 审核审计日志表
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS competition_audit_log (
    log_id       BIGINT       NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    biz_type     VARCHAR(30)  NOT NULL                COMMENT '业务类型',
    biz_id       BIGINT       NOT NULL                COMMENT '业务记录ID',
    from_status  CHAR(1)      DEFAULT NULL            COMMENT '审核前状态',
    to_status    CHAR(1)      NOT NULL                COMMENT '审核后状态',
    audit_by     VARCHAR(64)  NOT NULL                COMMENT '审核人',
    audit_time   DATETIME     NOT NULL                COMMENT '审核时间',
    remark       VARCHAR(500) DEFAULT NULL            COMMENT '审核意见',
    PRIMARY KEY (log_id),
    INDEX idx_audit_log_biz (biz_type, biz_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='审核审计日志表';

-- ---------------------------------------------------------------
-- 4. competition_apply 表：增加 audit_by 字段
-- ---------------------------------------------------------------
SET @col_audit_by = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'competition_apply' AND COLUMN_NAME = 'audit_by');

SET @sql_apply = IF(@col_audit_by = 0,
    'ALTER TABLE competition_apply ADD COLUMN audit_by VARCHAR(64) DEFAULT NULL COMMENT ''审核人'' AFTER audit_remark',
    'SELECT ''competition_apply.audit_by 已存在，跳过'' AS msg');
PREPARE stmt FROM @sql_apply;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ---------------------------------------------------------------
-- 5. user_notification 用户通知表
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_notification (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '通知ID',
    user_id     BIGINT       NOT NULL                COMMENT '用户ID',
    biz_type    VARCHAR(30)  NOT NULL                COMMENT '业务类型',
    biz_id      BIGINT       DEFAULT NULL            COMMENT '关联业务ID',
    title       VARCHAR(200) NOT NULL                COMMENT '标题',
    content     VARCHAR(500) DEFAULT NULL            COMMENT '内容',
    is_read     CHAR(1)      DEFAULT '0'             COMMENT '0未读 1已读',
    create_time DATETIME     NOT NULL                COMMENT '通知时间',
    PRIMARY KEY (id),
    INDEX idx_notification_user (user_id, is_read, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户通知表';
