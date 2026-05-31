-- =============================================
-- 参赛学生专属菜单初始化脚本
-- 版本：1.0
-- 日期：2026-05-31
-- =============================================
-- 
-- !!! 执行前请核对 !!!
-- 本脚本假设参赛学生角色的 role_id = 100
-- 请先执行以下查询确认实际的 role_id：
--   SELECT role_id, role_name, role_key FROM sys_role WHERE role_key = 'student';
-- 如果查询结果 role_id 不是 100，请替换脚本末尾 sys_role_menu 中的 100
-- =============================================

-- 竞赛系统扩展：为 sys_user 表增加参赛学生专属字段（首次执行需运行，已执行可跳过）
ALTER TABLE `sys_user` ADD COLUMN `student_no` varchar(20) DEFAULT NULL COMMENT '学号' AFTER `pwd_update_date`;
ALTER TABLE `sys_user` ADD COLUMN `grade` varchar(10) DEFAULT NULL COMMENT '年级' AFTER `student_no`;
ALTER TABLE `sys_user` ADD COLUMN `skill_tags` varchar(100) DEFAULT NULL COMMENT '技能标签' AFTER `grade`;

-- 先清理旧的竞赛管理菜单（菜单ID 2 及其子项）
DELETE FROM sys_role_menu WHERE menu_id IN (2, 200, 201, 202, 2103, 2000, 2001, 2002, 2003, 2010, 2011, 2012, 2020, 2021, 2022);
DELETE FROM sys_menu WHERE menu_id IN (2, 200, 201, 202, 2103, 2000, 2001, 2002, 2003, 2010, 2011, 2012, 2020, 2021, 2022);

-- 先清理学生菜单旧数据（防止重复执行报错）
DELETE FROM sys_role_menu WHERE menu_id BETWEEN 3000 AND 3036;
DELETE FROM sys_menu WHERE menu_id BETWEEN 3000 AND 3036;

-- =============================================
-- 一、菜单数据：sys_menu
-- =============================================

-- 竞赛大厅（顶级目录）
INSERT INTO `sys_menu` VALUES (3000, '竞赛大厅', 0, 1, 'hall', NULL, '', '', 1, 0, 'M', '0', '0', '', 'star', 'admin', sysdate(), '', NULL, '参赛学生竞赛大厅目录');

-- 竞赛大厅 > 竞赛列表（页面）
INSERT INTO `sys_menu` VALUES (3001, '竞赛列表', 3000, 1, 'list', 'student/hall/index', '', 'StudentHall', 1, 0, 'C', '0', '0', 'student:hall:list', 'list', 'admin', sysdate(), '', NULL, '竞赛大厅-竞赛列表页面');

-- 竞赛列表 > 竞赛查询（按钮权限）
INSERT INTO `sys_menu` VALUES (3002, '竞赛查询', 3001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:hall:query', '#', 'admin', sysdate(), '', NULL, '');

-- 组队匹配中心（顶级目录）
INSERT INTO `sys_menu` VALUES (3010, '组队匹配中心', 0, 2, 'match', NULL, '', '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', sysdate(), '', NULL, '参赛学生组队匹配目录');

-- 组队匹配中心 > 匹配大厅（页面）
INSERT INTO `sys_menu` VALUES (3011, '匹配大厅', 3010, 1, 'index', 'student/match/index', '', 'StudentMatch', 1, 0, 'C', '0', '0', 'student:match:list', 'search', 'admin', sysdate(), '', NULL, '组队匹配-匹配大厅页面');

-- 匹配大厅 > 匹配查询（按钮权限）
INSERT INTO `sys_menu` VALUES (3012, '匹配查询', 3011, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:match:query', '#', 'admin', sysdate(), '', NULL, '');

-- 匹配大厅 > 创建队伍（按钮权限）
INSERT INTO `sys_menu` VALUES (3013, '创建队伍', 3011, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'student:match:create', '#', 'admin', sysdate(), '', NULL, '');

-- 薪火相传（顶级目录）
INSERT INTO `sys_menu` VALUES (3020, '薪火相传', 0, 3, 'knowledge', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', NULL, '参赛学生知识库目录');

-- 薪火相传 > 知识库（页面）
INSERT INTO `sys_menu` VALUES (3021, '知识库', 3020, 1, 'index', 'student/knowledge/index', '', 'StudentKnowledge', 1, 0, 'C', '0', '0', 'student:knowledge:list', 'documentation', 'admin', sysdate(), '', NULL, '薪火相传-知识库页面');

-- 知识库 > 知识库查询（按钮权限）
INSERT INTO `sys_menu` VALUES (3022, '知识库查询', 3021, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:knowledge:query', '#', 'admin', sysdate(), '', NULL, '');

-- 我的赛程（顶级目录）
INSERT INTO `sys_menu` VALUES (3030, '我的赛程', 0, 4, 'myrace', NULL, '', '', 1, 0, 'M', '0', '0', '', 'time-range', 'admin', sysdate(), '', NULL, '参赛学生我的赛程目录');

-- 我的赛程 > 我的竞赛（页面）
INSERT INTO `sys_menu` VALUES (3031, '我的竞赛', 3030, 1, 'race', 'student/race/index', '', 'StudentRace', 1, 0, 'C', '0', '0', 'student:race:list', 'chart', 'admin', sysdate(), '', NULL, '我的赛程-我的竞赛页面');

-- 我的竞赛 > 赛程查询（按钮权限）
INSERT INTO `sys_menu` VALUES (3032, '赛程查询', 3031, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:race:query', '#', 'admin', sysdate(), '', NULL, '');

-- 我的赛程 > 我的竞赛 > 上传凭证（按钮权限）
INSERT INTO `sys_menu` VALUES (3033, '上传凭证', 3031, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'student:race:upload', '#', 'admin', sysdate(), '', NULL, '');


-- =============================================
-- 二、角色-菜单授权：sys_role_menu
-- =============================================
-- 
-- !!! 再次提醒：请确认参赛学生角色的 role_id
-- 如果 role_id 不是 100，请将下面所有 100 替换为实际的 role_id
-- 
-- =============================================

-- 竞赛大厅及其子菜单
INSERT INTO `sys_role_menu` VALUES (100, 3000);
INSERT INTO `sys_role_menu` VALUES (100, 3001);
INSERT INTO `sys_role_menu` VALUES (100, 3002);

-- 组队匹配中心及其子菜单
INSERT INTO `sys_role_menu` VALUES (100, 3010);
INSERT INTO `sys_role_menu` VALUES (100, 3011);
INSERT INTO `sys_role_menu` VALUES (100, 3012);
INSERT INTO `sys_role_menu` VALUES (100, 3013);

-- 薪火相传及其子菜单
INSERT INTO `sys_role_menu` VALUES (100, 3020);
INSERT INTO `sys_role_menu` VALUES (100, 3021);
INSERT INTO `sys_role_menu` VALUES (100, 3022);

-- 我的赛程及其子菜单
INSERT INTO `sys_role_menu` VALUES (100, 3030);
INSERT INTO `sys_role_menu` VALUES (100, 3031);
INSERT INTO `sys_role_menu` VALUES (100, 3032);
INSERT INTO `sys_role_menu` VALUES (100, 3033);
