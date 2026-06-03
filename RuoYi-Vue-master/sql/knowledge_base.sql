-- ============================================
-- 薪火相传 - 知识库模块（完整版）
-- ============================================
-- 【注意】表结构创建请只执行一次！
--        菜单和权限部分可重复执行。
-- ============================================

-- ----------------------------
-- Part 1: 建表（首次执行，已存在则跳过）
-- ----------------------------
CREATE TABLE IF NOT EXISTS `competition_retrospect`  (
  `retrospect_id` bigint NOT NULL AUTO_INCREMENT COMMENT '复盘ID',
  `comp_id` bigint NULL DEFAULT NULL COMMENT '关联竞赛ID(关联competition表)',
  `competition_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '竞赛名称(冗余展示)',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `award_level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '获奖级别(国家级/省级/市级/校级)',
  `leader_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '团队负责人',
  `year` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参赛年份',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '复盘内容(富文本HTML)',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审核状态(0待审核 1已通过 2已驳回)',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`retrospect_id`) USING BTREE,
  INDEX `idx_comp_id`(`comp_id` ASC) USING BTREE,
  INDEX `idx_audit_status`(`audit_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '往届项目复盘表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `competition_experience`  (
  `experience_id` bigint NOT NULL AUTO_INCREMENT COMMENT '经验帖ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '作者(冗余展示)',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '分类(备赛心得/团队协作/时间管理等)',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正文内容(富文本HTML)',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览次数',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审核状态(0待审核 1已通过 2已驳回)',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`experience_id`) USING BTREE,
  INDEX `idx_audit_status`(`audit_status` ASC) USING BTREE,
  INDEX `idx_author`(`author` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学长学姐经验帖表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `team_teacher_invitation`  (
  `invitation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '邀请ID',
  `team_id` bigint NOT NULL COMMENT '队伍ID',
  `competition_id` bigint NOT NULL COMMENT '竞赛ID',
  `teacher_id` bigint NOT NULL COMMENT '教师用户ID',
  `teacher_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '教师姓名',
  `student_id` bigint NOT NULL COMMENT '发起邀请的学生ID',
  `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '学生姓名',
  `team_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '队名(冗余)',
  `competition_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '竞赛名称(冗余)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0待确认 1已接受 2已拒绝 3已撤销)',
  `reply_message` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '教师回复信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '邀请时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`invitation_id`) USING BTREE,
  INDEX `idx_team_id`(`team_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_student_id`(`student_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师邀请表' ROW_FORMAT = Dynamic;


-- ============================================
-- Part 2: 菜单和权限（可重复执行）
-- ============================================

-- ----------------------------
-- 知识库审核（管理员+教师）
-- ----------------------------
REPLACE INTO `sys_menu` VALUES (3060, '知识库审核', 0, 99, 'knowledgeaudit', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', NULL, '管理员知识库审核目录');
REPLACE INTO `sys_menu` VALUES (3061, '复盘审核', 3060, 1, 'retrospect', 'system/knowledgeaudit/retrospect/index', '', 'KnowledgeAuditRetrospect', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', sysdate(), '', NULL, '管理员-项目复盘审核页');
REPLACE INTO `sys_menu` VALUES (3062, '经验帖审核', 3060, 2, 'experience', 'system/knowledgeaudit/experience/index', '', 'KnowledgeAuditExperience', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', sysdate(), '', NULL, '管理员-经验帖审核页');

DELETE FROM `sys_role_menu` WHERE role_id IN (1, 2) AND menu_id IN (3060, 3061, 3062);
INSERT INTO `sys_role_menu` VALUES (1, 3060);
INSERT INTO `sys_role_menu` VALUES (1, 3061);
INSERT INTO `sys_role_menu` VALUES (1, 3062);
INSERT INTO `sys_role_menu` VALUES (2, 3060);
INSERT INTO `sys_role_menu` VALUES (2, 3061);
INSERT INTO `sys_role_menu` VALUES (2, 3062);

-- ----------------------------
-- 教师角色读取权限（竞赛大厅 + 知识库）
-- ----------------------------
DELETE FROM `sys_role_menu` WHERE role_id = 2 AND menu_id IN (3000, 3001, 3020, 3021);
INSERT INTO `sys_role_menu` VALUES (2, 3000);
INSERT INTO `sys_role_menu` VALUES (2, 3001);
INSERT INTO `sys_role_menu` VALUES (2, 3020);
INSERT INTO `sys_role_menu` VALUES (2, 3021);

-- ----------------------------
-- 教师端新菜单（指导工作台）
-- ----------------------------
REPLACE INTO `sys_menu` VALUES (3070, '指导工作台', 0, 5, 'teacher', NULL, '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', sysdate(), '', NULL, '指导教师工作台目录');
REPLACE INTO `sys_menu` VALUES (3071, '待办邀请', 3070, 1, 'invitation', 'teacher/invitation/index', '', 'TeacherInvitation', 1, 0, 'C', '0', '0', 'teacher:invitation:list', 'bell', 'admin', sysdate(), '', NULL, '教师-待办邀请页');
REPLACE INTO `sys_menu` VALUES (3072, '指导团队', 3070, 2, 'team', 'teacher/team/index', '', 'TeacherTeam', 1, 0, 'C', '0', '0', 'teacher:team:list', 'peoples', 'admin', sysdate(), '', NULL, '教师-指导团队页');

DELETE FROM `sys_role_menu` WHERE role_id IN (1, 2) AND menu_id IN (3070, 3071, 3072);
INSERT INTO `sys_role_menu` VALUES (1, 3070);
INSERT INTO `sys_role_menu` VALUES (1, 3071);
INSERT INTO `sys_role_menu` VALUES (1, 3072);
INSERT INTO `sys_role_menu` VALUES (2, 3070);
INSERT INTO `sys_role_menu` VALUES (2, 3071);
INSERT INTO `sys_role_menu` VALUES (2, 3072);

-- ----------------------------
-- 菜单重命名（如果存在「学生端/教师端业务模块」）
-- ----------------------------
UPDATE `sys_menu` SET `menu_name` = '参赛中心' WHERE `menu_name` = '学生端业务模块' AND `parent_id` = 0;
UPDATE `sys_menu` SET `menu_name` = '指导工作台' WHERE `menu_name` = '教师端业务模块' AND `parent_id` = 0;

-- ----------------------------
-- Admin「指导老师选择」→「导师库管理」
-- ----------------------------
UPDATE `sys_menu` SET `menu_name` = '导师库管理' WHERE `menu_name` = '指导老师选择' AND `parent_id` = 3000;
