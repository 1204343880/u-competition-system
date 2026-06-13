-- ================================================================
-- RuoYi 学科竞赛管理系统 - v6.5 功能增强脚本
-- 包含：
--   1. 新建 team_invitation_record 队伍邀请记录表
--   2. 新建 user_notification_read_count Redis 缓存表（可选）
--   3. competition_experience 增加 reject_reason 驳回原因字段
--   4. competition_retrospect 增加 reject_reason 驳回原因字段
-- 执行前请备份数据库
-- ================================================================

-- ---------------------------------------------------------------
-- 1. 新建 team_invitation_record 队伍邀请记录表
--    队长在人才市场向用户发出邀请，被邀请人可同意/拒绝
-- ---------------------------------------------------------------
CREATE TABLE team_invitation_record (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '邀请记录ID',
    team_id     BIGINT       NOT NULL                COMMENT '队伍ID',
    inviter_id  BIGINT       NOT NULL                COMMENT '邀请人（队长）用户ID',
    invitee_id  BIGINT       NOT NULL                COMMENT '被邀请人用户ID',
    status      CHAR(1)      DEFAULT '0'             COMMENT '状态（0待处理 1已同意 2已拒绝 3已撤销）',
    create_time DATETIME     NOT NULL                COMMENT '邀请时间',
    update_time DATETIME     DEFAULT NULL            COMMENT '处理时间',
    PRIMARY KEY (id),
    INDEX idx_invitee (invitee_id, status),
    INDEX idx_team (team_id),
    INDEX idx_inviter (inviter_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='队伍邀请记录表';

-- ---------------------------------------------------------------
-- 2. competition_experience 增加 reject_reason 驳回原因字段
-- ---------------------------------------------------------------
ALTER TABLE competition_experience
    ADD COLUMN reject_reason VARCHAR(500) DEFAULT NULL COMMENT '驳回原因' AFTER audit_status;

-- ---------------------------------------------------------------
-- 3. competition_retrospect 增加 reject_reason 驳回原因字段
-- ---------------------------------------------------------------
ALTER TABLE competition_retrospect
    ADD COLUMN reject_reason VARCHAR(500) DEFAULT NULL COMMENT '驳回原因' AFTER audit_status;
