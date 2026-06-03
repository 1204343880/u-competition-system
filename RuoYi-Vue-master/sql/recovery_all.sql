-- ============================================
-- 一键恢复所有缺失数据（菜单 + 角色 + 字典）
-- 可重复执行，全部用 INSERT IGNORE
-- ============================================

-- 用户 → 角色（两人都要）
INSERT IGNORE INTO sys_user_role VALUES (3, 100);
INSERT IGNORE INTO sys_user_role VALUES (100, 100);

-- 组队匹配中心
INSERT IGNORE INTO sys_menu VALUES (3010, '组队匹配中心', 0, 1, 'match', NULL, '', '', 1, 0, 'M', '0', '0', '', 'team', 'admin', NOW(), '', NULL, '');

-- 组队广场 + 人才市场
INSERT IGNORE INTO sys_menu VALUES (3040, '组队广场', 3010, 1, 'team-square', 'student/hall/team-square', '', 'StudentTeamSquare', 1, 0, 'C', '0', '0', 'student:team:square:list', 'peoples', 'admin', NOW(), '', NULL, '');
INSERT IGNORE INTO sys_menu VALUES (3050, '人才市场', 3010, 2, 'market', 'student/hall/market', '', 'StudentMarket', 1, 0, 'C', '0', '0', 'student:market:list', 'people', 'admin', NOW(), '', NULL, '');

-- 竞赛状态：待开赛
INSERT IGNORE INTO sys_dict_data VALUES (28, 4, '待开赛', '3', 'competition_status', 'info', '', 'N', '0', 'admin', NOW(), '', NULL, '');

-- 队伍状态字典
INSERT IGNORE INTO sys_dict_type VALUES (8, '队伍状态', 'team_status', '0', 'admin', NOW(), '', NULL, '');
INSERT IGNORE INTO sys_dict_data VALUES (25, 1, '组队中', '0', 'team_status', 'info', '', 'Y', '0', 'admin', NOW(), '', NULL, '');
INSERT IGNORE INTO sys_dict_data VALUES (26, 2, '已提交', '1', 'team_status', 'warning', '', 'N', '0', 'admin', NOW(), '', NULL, '');
INSERT IGNORE INTO sys_dict_data VALUES (27, 3, '审核通过', '2', 'team_status', 'success', '', 'N', '0', 'admin', NOW(), '', NULL, '');

-- 角色 → 菜单权限
INSERT IGNORE INTO sys_role_menu VALUES (100, 3010);
INSERT IGNORE INTO sys_role_menu VALUES (100, 3040);
INSERT IGNORE INTO sys_role_menu VALUES (100, 3050);
