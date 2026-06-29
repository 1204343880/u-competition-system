-- 为团队赛增加独立的单队人数上限，不再复用 max_participants（竞赛总报名人数上限）
ALTER TABLE `competition`
    ADD COLUMN `team_max_members` int NULL DEFAULT NULL COMMENT '团队赛单队人数上限' AFTER `max_participants`;

