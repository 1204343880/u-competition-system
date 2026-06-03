/*
 Navicat Premium Data Transfer

 Source Server         : Bite_demo
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : ruoyidemo

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 04/06/2026 03:29:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bus_competition
-- ----------------------------
DROP TABLE IF EXISTS `bus_competition`;
CREATE TABLE `bus_competition`  (
  `comp_id` bigint NOT NULL AUTO_INCREMENT COMMENT '竞赛ID',
  `comp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '竞赛名称',
  `comp_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '竞赛类型（如：算法、建模、创新）',
  `enroll_deadline` datetime NULL DEFAULT NULL COMMENT '报名截止时间',
  `comp_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '竞赛详情描述',
  `contact_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人联系方式',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0招募中 1已结束）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`comp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bus_competition
-- ----------------------------

-- ----------------------------
-- Table structure for comp_team
-- ----------------------------
DROP TABLE IF EXISTS `comp_team`;
CREATE TABLE `comp_team`  (
  `team_id` bigint NOT NULL AUTO_INCREMENT COMMENT '队伍ID',
  `competition_id` bigint NOT NULL COMMENT '竞赛ID',
  `team_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '队名',
  `leader_id` bigint NOT NULL COMMENT '队长用户ID',
  `leader_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '队长姓名',
  `teacher_id` bigint NULL DEFAULT NULL COMMENT '指导教师用户ID',
  `teacher_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '指导教师姓名',
  `invite_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邀请码(6位)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '队伍状态(0组队中 1已提交 2审核通过)',
  `max_members` int NULL DEFAULT 5 COMMENT '人数上限',
  `current_members` int NULL DEFAULT 1 COMMENT '当前人数',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `is_public` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否公开招募(0否 1是)',
  `needed_skills` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所需技能标签,逗号分隔',
  PRIMARY KEY (`team_id`) USING BTREE,
  UNIQUE INDEX `uk_invite_code`(`invite_code` ASC) USING BTREE,
  INDEX `idx_competition_id`(`competition_id` ASC) USING BTREE,
  INDEX `idx_leader_id`(`leader_id` ASC) USING BTREE,
  INDEX `idx_comp_team_teacher`(`teacher_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛队伍表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comp_team
-- ----------------------------
INSERT INTO `comp_team` VALUES (1, 202, '一切可以队', 3, 'student01', NULL, NULL, 'N7VZBU', '0', 5, 1, '2', 'student01', '2026-06-03 14:37:38', '', '2026-06-03 14:46:43', NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (2, 202, 'ok队', 100, 'yao', NULL, NULL, '8SYFQ6', '0', 5, 2, '0', 'student01', '2026-06-03 14:52:15', 'yao', '2026-06-03 17:37:37', NULL, '1', '');
INSERT INTO `comp_team` VALUES (3, 103, '111', 3, 'student01', NULL, NULL, '6BXQPD', '0', 5, 1, '0', 'student01', '2026-06-04 02:15:24', '', '2026-06-04 02:15:33', NULL, '0', '路演答辩,市场调研');

-- ----------------------------
-- Table structure for comp_team_member
-- ----------------------------
DROP TABLE IF EXISTS `comp_team_member`;
CREATE TABLE `comp_team_member`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `team_id` bigint NOT NULL COMMENT '队伍ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `join_time` datetime NULL DEFAULT NULL COMMENT '加入时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0存在 2删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_team_user`(`team_id` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_team_id`(`team_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '队伍队员关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comp_team_member
-- ----------------------------
INSERT INTO `comp_team_member` VALUES (1, 1, 3, 'student01', 'student01', '2026-06-03 14:37:38', '2', 'student01', '2026-06-03 14:37:38');
INSERT INTO `comp_team_member` VALUES (2, 2, 3, 'student01', 'student01', '2026-06-03 14:52:15', '0', 'student01', '2026-06-03 14:52:15');
INSERT INTO `comp_team_member` VALUES (3, 2, 100, 'yao', 'yao', '2026-06-03 14:56:36', '0', 'yao', '2026-06-03 14:56:36');
INSERT INTO `comp_team_member` VALUES (4, 3, 3, 'student01', 'student01', '2026-06-04 02:15:24', '0', 'student01', '2026-06-04 02:15:24');

-- ----------------------------
-- Table structure for competition
-- ----------------------------
DROP TABLE IF EXISTS `competition`;
CREATE TABLE `competition`  (
  `competition_id` bigint NOT NULL AUTO_INCREMENT COMMENT '竞赛ID',
  `competition_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '竞赛名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '竞赛类别',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别名称',
  `competition_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '赛制（1个人赛 2团队赛）',
  `competition_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '竞赛级别（1校级 2市级 3省级 4国家级 5国际级）',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '竞赛详情描述',
  `apply_start_time` datetime NULL DEFAULT NULL COMMENT '报名开始时间',
  `apply_end_time` datetime NULL DEFAULT NULL COMMENT '报名结束时间',
  `start_time` datetime NULL DEFAULT NULL COMMENT '竞赛开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '竞赛结束时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '竞赛状态（0报名中 1进行中 2已结束）',
  `organizer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主办方',
  `host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '承办方',
  `max_participants` int NULL DEFAULT 0 COMMENT '参赛人数限制',
  `current_participants` int NULL DEFAULT 0 COMMENT '当前报名人数',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览量',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '竞赛标签JSON数组',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`competition_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 204 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '竞赛信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition
-- ----------------------------
INSERT INTO `competition` VALUES (100, '全国大学生数学建模竞赛', '01', '学科竞赛', '2', '4', '全国大学生数学建模竞赛是由教育部高等教育司和中国工业与应用数学学会共同主办的面向全国大学生的群众性科技活动。', '2026-06-01 00:00:00', '2026-09-15 23:59:59', '2026-09-20 08:00:00', '2026-09-23 18:00:00', '0', '教育部', '中国工业与应用数学学会', 50000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (101, '中国大学生计算机设计大赛', '01', '学科竞赛', '1', '4', '中国大学生计算机设计大赛是面向全国高校在校学生的科技类竞赛活动。', '2026-05-01 00:00:00', '2026-07-31 23:59:59', '2026-08-15 08:00:00', '2026-08-20 18:00:00', '0', '教育部', '中国高等教育学会', 30000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (102, '互联网+大学生创新创业大赛', '02', '创新创业', '2', '4', '中国国际\"互联网+\"大学生创新创业大赛是由教育部等多部委共同主办的国家级创新创业赛事。', '2026-04-01 00:00:00', '2026-06-30 23:59:59', '2026-07-15 08:00:00', '2026-07-20 18:00:00', '1', '教育部', '各高校', 100000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (103, '全国大学生电子设计竞赛', '03', '技能竞赛', '2', '4', '全国大学生电子设计竞赛是面向全国大学生的电子信息类学科竞赛。', '2026-03-01 00:00:00', '2026-08-31 23:59:59', '2026-09-08 08:00:00', '2026-09-11 18:00:00', '2', '教育部', '高等学校电子信息类专业教学指导委员会', 20000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (200, '2026年全国大学生英语作文大赛', '04', '外语类', '1', '4', '<p><strong>主办单位：</strong>高等学校大学外语教学研究会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国在校大学生（含高职高专、本科、研究生）</p><p><strong>竞赛形式：</strong>线上提交英语作文，题材不限，字数要求800-1500词。</p><p>本赛事已被多所双一流高校纳入保研加分体系，获奖证书含金量高。</p>', '2026-03-01 00:00:00', '2026-12-15 23:59:59', '2026-12-20 08:00:00', '2026-12-25 18:00:00', '0', '高等学校大学外语教学研究会', '全国大学生英语作文大赛组委会', 500000, 12349, 351000, '[\"A类赛事\",\"双一流高校覆盖\",\"保研加分\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (201, '2026全国大学生\"麟创杯\"人工智能知识竞赛', '05', 'IT/计算机类', '1', '4', '<p><strong>主办单位：</strong>中国技术市场协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生</p><p><strong>竞赛形式：</strong>线上客观题答题，涵盖人工智能基础、机器学习、深度学习、自然语言处理等知识点，满分100分。</p><p>本赛事由中国技术市场协会（国家一级社团）主办，证书可用于综测加分。</p>', '2026-04-01 00:00:00', '2026-10-31 23:59:59', '2026-11-05 08:00:00', '2026-11-10 18:00:00', '0', '中国技术市场协会', '\"麟创杯\"人工智能知识竞赛组委会', 100000, 3420, 56000, '[\"人工智能\",\"客观题答题\",\"国家一级社团\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (202, '2026年第六届全国大学生技术创新创业大赛', '02', '创新创业', '2', '4', '<p><strong>主办单位：</strong>中国技术创业协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生（本、硕、博均可）</p><p><strong>竞赛形式：</strong>团队参赛（3-5人），提交创业计划书及路演PPT，经初赛、复赛、决赛三轮评审。</p><p>优胜项目可获立项支持及投资人对接机会，是\"互联网+\"大赛的优质热身赛。</p>', '2026-02-01 00:00:00', '2026-09-30 23:59:59', '2026-10-15 08:00:00', '2026-10-20 18:00:00', '0', '中国技术创业协会', '全国大学生技术创新创业大赛组委会', 80000, 2890, 36000, '[\"挑战杯热身\",\"互联网+\",\"立项支持\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (203, '2026年第十六届APMCM亚太地区大学生数学建模竞赛', '06', '理工/数学类', '2', '5', '<p><strong>主办单位：</strong>中国国际科技促进会</p><p><strong>竞赛级别：</strong>国际级/国家级</p><p><strong>参赛对象：</strong>亚太地区高校在校学生</p><p><strong>竞赛形式：</strong>3人组队，在4天时间内完成一道数学建模题目，提交英文论文。赛题涵盖工程、经济、环境等交叉学科。</p><p>APMCM是国际认可度较高的数学建模赛事之一，获奖可用于国赛热身及综合测评加分。</p>', '2025-11-01 00:00:00', '2026-05-15 23:59:59', '2026-05-20 08:00:00', '2026-08-20 18:00:00', '1', '中国国际科技促进会', 'APMCM亚太地区大学生数学建模竞赛组委会', 30000, 18500, 47000, '[\"数学建模\",\"国赛热身\",\"综合测评加分\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);

-- ----------------------------
-- Table structure for competition_apply
-- ----------------------------
DROP TABLE IF EXISTS `competition_apply`;
CREATE TABLE `competition_apply`  (
  `apply_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `competition_id` bigint NOT NULL COMMENT '竞赛ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `team_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '团队名称',
  `team_members` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '团队成员',
  `apply_time` datetime NULL DEFAULT NULL COMMENT '报名时间',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '审核状态（0待审核 1通过 2拒绝）',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '审核意见',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`apply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '竞赛报名表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_apply
-- ----------------------------
INSERT INTO `competition_apply` VALUES (1, 100, 3, 'student01', '李四同学', '创新团队', '李四同学,张三同学,王五同学', '2026-05-29 16:02:16', '1', NULL, '', NULL, '2', '', NULL, '', '2026-06-03 13:09:02');
INSERT INTO `competition_apply` VALUES (2, 100, 5, 'student02', '赵同学', '智慧队', '赵同学,钱同学,孙同学', '2026-05-29 16:02:16', '0', NULL, '', NULL, '0', '', NULL, '', NULL);
INSERT INTO `competition_apply` VALUES (3, 101, 3, 'student01', '李四同学', '代码先锋队', '李四同学', '2026-05-29 16:02:16', '1', NULL, '', NULL, '2', '', NULL, '', '2026-06-03 13:09:04');
INSERT INTO `competition_apply` VALUES (4, 201, 3, 'student01', 'yu', '', '', '2026-06-02 22:01:48', '0', NULL, '', NULL, '2', 'student01', '2026-06-02 22:01:48', '', '2026-06-03 13:09:13');
INSERT INTO `competition_apply` VALUES (5, 201, 3, 'student01', 'yu', '', '', '2026-06-03 13:09:20', '0', NULL, '', NULL, '2', 'student01', '2026-06-03 13:09:20', '', '2026-06-04 02:05:07');
INSERT INTO `competition_apply` VALUES (6, 200, 3, 'student01', 'yu', '', '', '2026-06-03 13:50:37', '0', NULL, '', NULL, '2', 'student01', '2026-06-03 13:50:37', '', '2026-06-04 02:04:51');
INSERT INTO `competition_apply` VALUES (7, 201, 3, 'student01', 'yu', '', '', '2026-06-04 02:05:20', '1', '2026-06-04 02:14:47', NULL, 'admin', '0', 'student01', '2026-06-04 02:05:20', '', '2026-06-04 02:14:47');

-- ----------------------------
-- Table structure for competition_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `competition_audit_log`;
CREATE TABLE `competition_audit_log`  (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `biz_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型（apply/team/retrospect/experience/result）',
  `biz_id` bigint NOT NULL COMMENT '业务记录ID',
  `from_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核前状态',
  `to_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核后状态',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核人',
  `audit_time` datetime NOT NULL COMMENT '审核时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_audit_log_biz`(`biz_type` ASC, `biz_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核审计日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_audit_log
-- ----------------------------

-- ----------------------------
-- Table structure for competition_experience
-- ----------------------------
DROP TABLE IF EXISTS `competition_experience`;
CREATE TABLE `competition_experience`  (
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学长学姐经验帖表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_experience
-- ----------------------------
INSERT INTO `competition_experience` VALUES (1, '无', 'yu', '避坑指南', '<p>避开某学校</p>', 0, '1', 'teacher01', '2026-06-04 00:44:17', '0', 'student01', '2026-06-04 00:43:48', '', NULL);

-- ----------------------------
-- Table structure for competition_result
-- ----------------------------
DROP TABLE IF EXISTS `competition_result`;
CREATE TABLE `competition_result`  (
  `result_id` bigint NOT NULL AUTO_INCREMENT COMMENT '成绩记录ID',
  `competition_id` bigint NOT NULL COMMENT '竞赛ID',
  `team_id` bigint NULL DEFAULT NULL COMMENT '队伍ID（团队赛时关联comp_team）',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID（个人赛时关联sys_user）',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参赛项目名称',
  `award_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '获奖级别（如：国家级一等奖、省级二等奖）',
  `ranking` int NULL DEFAULT NULL COMMENT '排名（数字越小越靠前）',
  `score` decimal(10, 2) NULL DEFAULT NULL COMMENT '分数（如有具体评分）',
  `certificate_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '证书图片/文件URL',
  `certificate_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '证书文件SHA256哈希（防篡改校验）',
  `result_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '成绩状态（0待审核 1已确认 2已作废）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '录入人（教师登录名）',
  `create_time` datetime NOT NULL COMMENT '录入时间',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人（管理员登录名）',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后修改时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注说明',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  PRIMARY KEY (`result_id`) USING BTREE,
  INDEX `idx_result_competition`(`competition_id` ASC) USING BTREE,
  INDEX `idx_result_team`(`team_id` ASC) USING BTREE,
  INDEX `idx_result_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛成绩记录表（存证系统）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of competition_result
-- ----------------------------

-- ----------------------------
-- Table structure for competition_retrospect
-- ----------------------------
DROP TABLE IF EXISTS `competition_retrospect`;
CREATE TABLE `competition_retrospect`  (
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '往届项目复盘表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_retrospect
-- ----------------------------
INSERT INTO `competition_retrospect` VALUES (1, NULL, '吹牛大赛', '我将进入英伟达', '国家级', 'Yu', '2030', '<p>吹牛这块</p>', '1', 'teacher01', '2026-06-04 00:44:14', '0', 'student01', '2026-06-04 00:43:33', '', NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE INDEX `uk_config_key`(`config_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '系统名称', 'sys.name', '学科竞赛管理系统', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_config` VALUES (2, '系统简介', 'sys.title', '铜陵学院学科竞赛管理平台', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_config` VALUES (3, '上传路径', 'sys.upload.path', '/home/ruoyi/uploadPath', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1503 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '学校', 1, '管理员', '15800000000', 'admin@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '电气与信息工程学院', 2, '张三', '15800000001', 'dianqi@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 200, '0,100,200', '计算机科学与技术', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (202, 200, '0,100,200', '电子信息工程', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (203, 200, '0,100,200', '通信工程', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (204, 200, '0,100,200', '自动化', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (205, 200, '0,100,200', '物联网工程', 5, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (206, 200, '0,100,200', '人工智能', 6, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (300, 100, '0,100', '人工智能学院', 3, '李四', '15800000002', 'ai@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (301, 300, '0,100,300', '人工智能', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (302, 300, '0,100,300', '智能科学与技术', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (303, 300, '0,100,300', '数据科学与大数据技术', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (304, 300, '0,100,300', '机器人工程', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (305, 300, '0,100,300', '计算机科学与技术（AI方向）', 5, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (400, 100, '0,100', '大数据与统计学院', 4, '王五', '15800000003', 'bigdata@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (401, 400, '0,100,400', '数据科学与大数据技术', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (402, 400, '0,100,400', '统计学', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (403, 400, '0,100,400', '应用统计学', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (404, 400, '0,100,400', '信息与计算科学', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (500, 100, '0,100', '机电工程学院', 5, '赵六', '15800000004', 'jidian@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (501, 500, '0,100,500', '机械设计制造及其自动化', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (502, 500, '0,100,500', '材料成型及控制工程', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (503, 500, '0,100,500', '机械电子工程', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (504, 500, '0,100,500', '机器人工程', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (600, 100, '0,100', '材料科学与工程学院', 6, '钱七', '15800000005', 'cailiao@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (601, 600, '0,100,600', '材料科学与工程', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (602, 600, '0,100,600', '金属材料工程', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (603, 600, '0,100,600', '高分子材料与工程', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (604, 600, '0,100,600', '新能源材料与器件', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (700, 100, '0,100', '智能建造与空间信息学院', 7, '孙八', '15800000006', 'jianzhu@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (701, 700, '0,100,700', '土木工程', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (702, 700, '0,100,700', '建筑学', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (703, 700, '0,100,700', '测绘工程', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (704, 700, '0,100,700', '地理信息科学', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (705, 700, '0,100,700', '智能建造', 5, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (800, 100, '0,100', '会计学院', 8, '周九', '15800000007', 'kuaiji@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (801, 800, '0,100,800', '会计学', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (802, 800, '0,100,800', '审计学', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (803, 800, '0,100,800', '财务管理', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (804, 800, '0,100,800', '资产评估', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (900, 100, '0,100', '经济学院', 9, '吴十', '15800000008', 'jingji@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (901, 900, '0,100,900', '经济学', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (902, 900, '0,100,900', '金融学', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (903, 900, '0,100,900', '国际经济与贸易', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (904, 900, '0,100,900', '财政学', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1000, 100, '0,100', '管理学院', 10, '郑一', '15800000009', 'guanli@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1001, 1000, '0,100,1000', '市场营销', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1002, 1000, '0,100,1000', '物流管理', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1003, 1000, '0,100,1000', '人力资源管理', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1004, 1000, '0,100,1000', '工商管理', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1005, 1000, '0,100,1000', '房地产开发与管理', 5, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1100, 100, '0,100', '法学与公共管理学院', 11, '王二', '15800000010', 'faxue@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1101, 1100, '0,100,1100', '法学', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1102, 1100, '0,100,1100', '行政管理', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1103, 1100, '0,100,1100', '公共事业管理', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1104, 1100, '0,100,1100', '城市管理', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1200, 100, '0,100', '语言与传播学院', 12, '刘三', '15800000011', 'yuyan@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1201, 1200, '0,100,1200', '汉语言文学', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1202, 1200, '0,100,1200', '英语', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1203, 1200, '0,100,1200', '广告学', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1204, 1200, '0,100,1200', '网络与新媒体', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1205, 1200, '0,100,1200', '传播学', 5, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1300, 100, '0,100', '艺术与设计学院', 13, '陈四', '15800000012', 'yishu@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1301, 1300, '0,100,1300', '视觉传达设计', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1302, 1300, '0,100,1300', '环境设计', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1303, 1300, '0,100,1300', '产品设计', 3, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1304, 1300, '0,100,1300', '数字媒体艺术', 4, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1400, 100, '0,100', '马克思主义学院', 14, '杨五', '15800000013', 'makesi@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1401, 1400, '0,100,1400', '思想政治教育（本科）', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1402, 1400, '0,100,1400', '马克思主义理论类（研究生）', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1500, 100, '0,100', '体育学院', 15, '黄六', '15800000014', 'tiyu@school.edu.cn', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1501, 1500, '0,100,1500', '体育教育', 1, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);
INSERT INTO `sys_dept` VALUES (1502, 1500, '0,100,1500', '社会体育指导与管理', 2, '', '', '', '0', '0', 'admin', '2026-05-29 16:08:51', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (4, 1, '正常', '0', 'sys_normal_disable', '', '', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (5, 2, '停用', '1', 'sys_normal_disable', '', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (6, 1, '报名中', '0', 'competition_status', 'success', '', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (7, 2, '进行中', '1', 'competition_status', 'warning', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (8, 3, '已结束', '2', 'competition_status', 'info', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (9, 1, '待审核', '0', 'audit_status', 'info', '', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (10, 2, '通过', '1', 'audit_status', 'success', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (11, 3, '拒绝', '2', 'audit_status', 'danger', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (12, 1, '学科竞赛', '01', 'competition_category', '', '', 'Y', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (13, 2, '创新创业', '02', 'competition_category', '', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (14, 3, '技能竞赛', '03', 'competition_category', '', '', 'N', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (15, 4, '外语类', '04', 'competition_category', '', '', 'N', '0', 'admin', '2026-06-02 17:56:24', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (16, 5, 'IT/计算机类', '05', 'competition_category', '', '', 'N', '0', 'admin', '2026-06-02 17:56:24', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (17, 6, '理工/数学类', '06', 'competition_category', '', '', 'N', '0', 'admin', '2026-06-02 17:56:24', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (18, 1, '个人赛', '1', 'competition_type', '', '', 'Y', '0', 'admin', '2026-06-02 21:35:20', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (19, 2, '团队赛', '2', 'competition_type', '', '', 'N', '0', 'admin', '2026-06-02 21:35:20', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (20, 1, '校级', '1', 'competition_level', '', '', 'Y', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (21, 2, '市级', '2', 'competition_level', '', '', 'N', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (22, 3, '省级', '3', 'competition_level', '', '', 'N', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (23, 4, '国家级', '4', 'competition_level', '', '', 'N', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (24, 5, '国际级', '5', 'competition_level', '', '', 'N', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (25, 1, '组队中', '0', 'team_status', 'info', '', 'Y', '0', 'admin', '2026-06-03 13:49:47', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (26, 2, '已提交', '1', 'team_status', 'warning', '', 'N', '0', 'admin', '2026-06-03 13:49:47', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (27, 3, '审核通过', '2', 'team_status', 'success', '', 'N', '0', 'admin', '2026-06-03 13:49:47', '', NULL, '');
INSERT INTO `sys_dict_data` VALUES (28, 4, '待开赛', '3', 'competition_status', 'info', '', 'N', '0', 'admin', '2026-06-03 14:36:34', '', NULL, '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `uk_dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '用户性别');
INSERT INTO `sys_dict_type` VALUES (2, '系统状态', 'sys_normal_disable', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '系统状态');
INSERT INTO `sys_dict_type` VALUES (3, '竞赛状态', 'competition_status', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '竞赛状态');
INSERT INTO `sys_dict_type` VALUES (4, '审核状态', 'audit_status', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '审核状态');
INSERT INTO `sys_dict_type` VALUES (5, '竞赛类别', 'competition_category', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '竞赛类别');
INSERT INTO `sys_dict_type` VALUES (6, '赛制类型', 'competition_type', '0', 'admin', '2026-06-02 21:35:20', '', NULL, '竞赛赛制类型');
INSERT INTO `sys_dict_type` VALUES (7, '竞赛级别', 'competition_level', '0', 'admin', '2026-06-02 21:43:55', '', NULL, '竞赛级别');
INSERT INTO `sys_dict_type` VALUES (8, '队伍状态', 'team_status', '0', 'admin', '2026-06-03 13:49:47', '', NULL, '队伍状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 15:58:25', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 15:58:25', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 15:58:25', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 189 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 16:06:29');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 16:15:34');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 16:24:26');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 16:24:29');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 17:47:39');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 16:56:00');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 17:44:20');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 18:35:40');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 13:31:14');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 14:10:52');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 14:55:04');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 15:07:05');
INSERT INTO `sys_logininfor` VALUES (112, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 15:07:13');
INSERT INTO `sys_logininfor` VALUES (113, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 15:28:23');
INSERT INTO `sys_logininfor` VALUES (114, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 15:28:26');
INSERT INTO `sys_logininfor` VALUES (115, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 15:39:28');
INSERT INTO `sys_logininfor` VALUES (116, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 15:39:31');
INSERT INTO `sys_logininfor` VALUES (117, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 16:35:27');
INSERT INTO `sys_logininfor` VALUES (118, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 16:40:22');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 16:40:25');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 18:18:15');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 20:52:28');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 21:02:16');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 21:03:01');
INSERT INTO `sys_logininfor` VALUES (124, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 21:03:11');
INSERT INTO `sys_logininfor` VALUES (125, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 21:08:45');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 21:08:49');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-05-31 21:09:11');
INSERT INTO `sys_logininfor` VALUES (128, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-31 21:09:17');
INSERT INTO `sys_logininfor` VALUES (129, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 16:48:11');
INSERT INTO `sys_logininfor` VALUES (130, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-01 16:54:37');
INSERT INTO `sys_logininfor` VALUES (131, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 16:54:40');
INSERT INTO `sys_logininfor` VALUES (132, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-01 17:10:07');
INSERT INTO `sys_logininfor` VALUES (133, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 17:10:08');
INSERT INTO `sys_logininfor` VALUES (134, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 18:13:36');
INSERT INTO `sys_logininfor` VALUES (135, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 19:28:55');
INSERT INTO `sys_logininfor` VALUES (136, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 06:55:31');
INSERT INTO `sys_logininfor` VALUES (137, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 07:41:46');
INSERT INTO `sys_logininfor` VALUES (138, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 16:42:12');
INSERT INTO `sys_logininfor` VALUES (139, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 17:29:06');
INSERT INTO `sys_logininfor` VALUES (140, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 19:21:14');
INSERT INTO `sys_logininfor` VALUES (141, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 21:23:39');
INSERT INTO `sys_logininfor` VALUES (142, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-02 22:00:37');
INSERT INTO `sys_logininfor` VALUES (143, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 22:00:39');
INSERT INTO `sys_logininfor` VALUES (144, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 12:04:30');
INSERT INTO `sys_logininfor` VALUES (145, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 13:05:07');
INSERT INTO `sys_logininfor` VALUES (146, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 13:50:10');
INSERT INTO `sys_logininfor` VALUES (147, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 14:47:55');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 14:47:58');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 14:51:30');
INSERT INTO `sys_logininfor` VALUES (150, 'yao', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 14:51:34');
INSERT INTO `sys_logininfor` VALUES (151, 'yao', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 14:51:49');
INSERT INTO `sys_logininfor` VALUES (152, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 14:51:54');
INSERT INTO `sys_logininfor` VALUES (153, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '1', '用户不存在/密码错误', '2026-06-03 14:55:20');
INSERT INTO `sys_logininfor` VALUES (154, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '1', '验证码错误', '2026-06-03 14:55:24');
INSERT INTO `sys_logininfor` VALUES (155, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 14:55:30');
INSERT INTO `sys_logininfor` VALUES (156, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 15:31:57');
INSERT INTO `sys_logininfor` VALUES (157, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 15:31:58');
INSERT INTO `sys_logininfor` VALUES (158, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 15:35:36');
INSERT INTO `sys_logininfor` VALUES (159, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 15:35:38');
INSERT INTO `sys_logininfor` VALUES (160, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 16:11:28');
INSERT INTO `sys_logininfor` VALUES (161, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 16:11:32');
INSERT INTO `sys_logininfor` VALUES (162, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 16:24:15');
INSERT INTO `sys_logininfor` VALUES (163, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 16:41:12');
INSERT INTO `sys_logininfor` VALUES (164, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 17:17:23');
INSERT INTO `sys_logininfor` VALUES (165, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 17:20:10');
INSERT INTO `sys_logininfor` VALUES (166, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-03 17:20:22');
INSERT INTO `sys_logininfor` VALUES (167, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 17:20:25');
INSERT INTO `sys_logininfor` VALUES (168, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-03 17:44:31');
INSERT INTO `sys_logininfor` VALUES (169, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 17:44:35');
INSERT INTO `sys_logininfor` VALUES (170, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 18:34:58');
INSERT INTO `sys_logininfor` VALUES (171, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 19:59:15');
INSERT INTO `sys_logininfor` VALUES (172, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 21:38:37');
INSERT INTO `sys_logininfor` VALUES (173, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 21:39:52');
INSERT INTO `sys_logininfor` VALUES (174, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 23:11:29');
INSERT INTO `sys_logininfor` VALUES (175, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 23:32:24');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 23:33:06');
INSERT INTO `sys_logininfor` VALUES (177, 'yao', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-03 23:49:46');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-03 23:58:34');
INSERT INTO `sys_logininfor` VALUES (179, 'teacher01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-03 23:58:46');
INSERT INTO `sys_logininfor` VALUES (180, 'teacher01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-04 00:37:26');
INSERT INTO `sys_logininfor` VALUES (181, 'teacher01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '退出成功', '2026-06-04 00:42:40');
INSERT INTO `sys_logininfor` VALUES (182, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-04 00:42:45');
INSERT INTO `sys_logininfor` VALUES (183, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '1', '验证码已失效', '2026-06-04 00:44:01');
INSERT INTO `sys_logininfor` VALUES (184, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-04 00:44:05');
INSERT INTO `sys_logininfor` VALUES (185, 'teacher01', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-04 00:48:25');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-04 00:48:36');
INSERT INTO `sys_logininfor` VALUES (187, 'student01', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-04 01:43:02');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-04 02:06:16');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由参数',
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3073 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-29 16:02:15', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (3, '系统监控', 0, 6, 'monitor', '', '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (4, '系统工具', 0, 4, 'tool', '', '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-29 16:02:15', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-29 16:02:15', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-29 16:02:15', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '专业管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-05-29 16:02:15', '', NULL, '专业管理菜单');
INSERT INTO `sys_menu` VALUES (104, '身份管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-05-29 16:02:15', '', NULL, '身份管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-05-29 16:02:15', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-05-29 16:02:15', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-05-29 16:02:15', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '在线用户', 3, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (109, '定时任务', 3, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (110, '数据监控', 3, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (111, '服务监控', 3, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (112, '缓存监控', 3, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (113, '缓存列表', 3, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (114, '操作日志', 3, 7, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (115, '登录日志', 3, 8, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (116, '表单构建', 4, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (117, '代码生成', 4, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (118, '系统接口', 4, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-29 16:22:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '学院查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '学院新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '学院修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '学院删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '身份查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '身份新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '身份修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '身份删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1090, '任务查询', 109, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1091, '任务新增', 109, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1092, '任务修改', 109, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1093, '任务删除', 109, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1094, '状态修改', 109, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1140, '操作查询', 114, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1141, '操作删除', 114, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1150, '登录查询', 115, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1151, '登录删除', 115, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1170, '生成查询', 117, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1171, '生成修改', 117, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1172, '生成删除', 117, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1173, '导入代码', 117, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-29 16:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3000, '竞赛大厅', 0, 1, 'hall', NULL, '', '', 1, 0, 'M', '0', '0', '', 'star', 'admin', '2026-05-31 16:34:51', '', NULL, '参赛学生竞赛大厅目录');
INSERT INTO `sys_menu` VALUES (3001, '竞赛列表', 3000, 1, 'list', 'student/hall/index', '', 'StudentHall', 1, 0, 'C', '0', '0', 'student:hall:list', 'list', 'admin', '2026-05-31 16:34:51', '', NULL, '竞赛大厅-竞赛列表页面');
INSERT INTO `sys_menu` VALUES (3002, '竞赛查询', 3001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:hall:query', '#', 'admin', '2026-05-31 16:34:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3010, '组队匹配中心', 0, 3, 'match', NULL, '', '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', '2026-05-31 16:34:51', '', NULL, '参赛学生组队匹配目录');
INSERT INTO `sys_menu` VALUES (3020, '薪火相传', 0, 8, 'knowledge', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-05-31 16:34:51', '', NULL, '参赛学生知识库目录');
INSERT INTO `sys_menu` VALUES (3021, '知识库', 3020, 1, 'index', 'student/knowledge/index', '', 'StudentKnowledge', 1, 0, 'C', '0', '0', 'student:knowledge:list', 'documentation', 'admin', '2026-05-31 16:34:51', '', NULL, '薪火相传-知识库页面');
INSERT INTO `sys_menu` VALUES (3022, '知识库查询', 3021, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:knowledge:query', '#', 'admin', '2026-05-31 16:34:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3030, '我的赛程', 0, 5, 'myrace', NULL, '', '', 1, 0, 'M', '0', '0', '', 'time-range', 'admin', '2026-05-31 16:34:51', '', NULL, '参赛学生我的赛程目录');
INSERT INTO `sys_menu` VALUES (3031, '我的竞赛', 3030, 1, 'race', 'student/race/index', '', 'StudentRace', 1, 0, 'C', '0', '0', 'student:race:list', 'chart', 'admin', '2026-05-31 16:34:51', '', NULL, '我的赛程-我的竞赛页面');
INSERT INTO `sys_menu` VALUES (3032, '赛程查询', 3031, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'student:race:query', '#', 'admin', '2026-05-31 16:34:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3033, '上传凭证', 3031, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'student:race:upload', '#', 'admin', '2026-05-31 16:34:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3040, '组队广场', 3010, 1, 'team-square', 'student/hall/team-square', '', 'StudentTeamSquare', 1, 0, 'C', '0', '0', 'student:team:square:list', 'team', 'admin', '2026-06-03 15:15:21', '', NULL, '组队广场-公开招募队伍列表');
INSERT INTO `sys_menu` VALUES (3050, '人才市场', 3010, 2, 'market', 'student/hall/market', '', 'StudentMarket', 1, 0, 'C', '0', '0', 'student:market:list', 'people', 'admin', '2026-06-03 15:15:21', '', NULL, '人才市场-学生技能展示');
INSERT INTO `sys_menu` VALUES (3060, '知识库审核', 0, 99, 'knowledgeaudit', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-06-04 00:36:52', '', NULL, '管理员知识库审核目录');
INSERT INTO `sys_menu` VALUES (3061, '复盘审核', 3060, 1, 'retrospect', 'system/knowledgeaudit/retrospect/index', '', 'KnowledgeAuditRetrospect', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', '2026-06-04 00:36:52', '', NULL, '管理员-项目复盘审核页');
INSERT INTO `sys_menu` VALUES (3062, '经验帖审核', 3060, 2, 'experience', 'system/knowledgeaudit/experience/index', '', 'KnowledgeAuditExperience', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', '2026-06-04 00:36:52', '', NULL, '管理员-经验帖审核页');
INSERT INTO `sys_menu` VALUES (3063, '报名审核', 3060, 3, 'applyaudit', 'system/competitionaudit/apply/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛报名审核页');
INSERT INTO `sys_menu` VALUES (3064, '队伍审核', 3060, 4, 'teamaudit', 'system/competitionaudit/team/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛队伍审核页');
INSERT INTO `sys_menu` VALUES (3065, '成绩审核', 3060, 5, 'resultaudit', 'system/competitionaudit/result/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛成绩审核页');
INSERT INTO `sys_menu` VALUES (3070, '指导工作台', 0, 5, 'teacher', NULL, '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-06-04 00:36:52', '', NULL, '指导教师工作台目录');
INSERT INTO `sys_menu` VALUES (3071, '待办邀请', 3070, 1, 'invitation', 'teacher/invitation/index', '', 'TeacherInvitation', 1, 0, 'C', '0', '0', 'teacher:invitation:list', 'bell', 'admin', '2026-06-04 00:36:52', '', NULL, '教师-待办邀请页');
INSERT INTO `sys_menu` VALUES (3072, '指导团队', 3070, 2, 'team', 'teacher/team/index', '', 'TeacherTeam', 1, 0, 'C', '0', '0', 'teacher:team:list', 'peoples', 'admin', '2026-06-04 00:36:52', '', NULL, '教师-指导团队页');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '公告类型（1通知 2公告）',
  `notice_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '欢迎使用学科竞赛管理系统', '1', '<p>欢迎使用铜陵学院学科竞赛管理平台！</p><p>本系统用于管理和组织各类学科竞赛活动。</p><p>如有任何问题，请联系管理员。</p>', '0', 'admin', '2026-05-29 16:02:16', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '保存部门排序', 2, 'com.ruoyi.web.controller.system.SysDeptController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/dept/updateSort', '127.0.0.1', '内网IP', '{\"deptIds\":\"100\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 16:10:37', 28);
INSERT INTO `sys_oper_log` VALUES (101, '保存部门排序', 2, 'com.ruoyi.web.controller.system.SysDeptController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/dept/updateSort', '127.0.0.1', '内网IP', '{\"deptIds\":\"100,301\",\"orderNums\":\"1,2\"} ', NULL, 1, '当前层级下已存在排序号 2，请重新输入', '2026-05-29 16:10:46', 14);
INSERT INTO `sys_oper_log` VALUES (102, '保存部门排序', 2, 'com.ruoyi.web.controller.system.SysDeptController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/dept/updateSort', '127.0.0.1', '内网IP', '{\"deptIds\":\"100\",\"orderNums\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 16:10:49', 10);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"competition/apply/index\",\"createTime\":\"2026-05-29 16:14:21\",\"icon\":\"select\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":202,\"menuName\":\"报名审核\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2,\"path\":\"apply\",\"perms\":\"competition:apply:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-29 17:48:07', 23);
INSERT INTO `sys_oper_log` VALUES (104, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"3\",\"orderNums\":\"4\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 17:44:39', 78);
INSERT INTO `sys_oper_log` VALUES (105, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,2,3\",\"orderNums\":\"2,1,3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 17:44:48', 9);
INSERT INTO `sys_oper_log` VALUES (106, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:35:47', 7);
INSERT INTO `sys_oper_log` VALUES (107, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:35:49', 5);
INSERT INTO `sys_oper_log` VALUES (108, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:36:26', 23);
INSERT INTO `sys_oper_log` VALUES (109, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:36:28', 5);
INSERT INTO `sys_oper_log` VALUES (110, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:38:40', 5);
INSERT INTO `sys_oper_log` VALUES (111, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:49:08', 5);
INSERT INTO `sys_oper_log` VALUES (112, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"3\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:49:10', 5);
INSERT INTO `sys_oper_log` VALUES (113, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-30 18:49:37', 27);
INSERT INTO `sys_oper_log` VALUES (114, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1\",\"orderNums\":\"3\"} ', NULL, 1, '当前菜单层级下已存在该排序号 3，请重新输入', '2026-05-30 18:49:39', 10);
INSERT INTO `sys_oper_log` VALUES (115, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"2,1\"} ', NULL, 1, '当前菜单层级下已存在该排序号 2，请重新输入', '2026-05-30 18:49:44', 7);
INSERT INTO `sys_oper_log` VALUES (116, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"2,1\"} ', NULL, 1, '当前菜单层级下已存在该排序号 2，请重新输入', '2026-05-30 18:49:46', 7);
INSERT INTO `sys_oper_log` VALUES (117, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"3,1\"} ', NULL, 1, '当前菜单层级下已存在该排序号 3，请重新输入', '2026-05-30 18:49:49', 8);
INSERT INTO `sys_oper_log` VALUES (118, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"2,1\"} ', NULL, 1, '当前菜单层级下已存在该排序号 2，请重新输入', '2026-05-30 18:50:00', 6);
INSERT INTO `sys_oper_log` VALUES (119, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"2,1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 13:31:26', 32);
INSERT INTO `sys_oper_log` VALUES (120, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"2,1\",\"orderNums\":\"1,2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 13:31:35', 16);
INSERT INTO `sys_oper_log` VALUES (121, '保存部门排序', 2, 'com.ruoyi.web.controller.system.SysDeptController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/dept/updateSort', '127.0.0.1', '内网IP', '{\"deptIds\":\"301,302\",\"orderNums\":\"2,1\"} ', NULL, 1, '当前层级下已存在排序号 2，请重新输入', '2026-05-31 13:31:51', 9);
INSERT INTO `sys_oper_log` VALUES (122, '保存部门排序', 2, 'com.ruoyi.web.controller.system.SysDeptController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/dept/updateSort', '127.0.0.1', '内网IP', '{\"deptIds\":\"301,302\",\"orderNums\":\"2,1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 13:35:14', 40);
INSERT INTO `sys_oper_log` VALUES (123, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-05-29 16:02:15\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":101,\"params\":{}},\"deptId\":101,\"email\":\"student01@tlxy.edu.cn\",\"loginDate\":\"2026-05-29 16:02:15\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"postIds\":[4],\"pwdUpdateDate\":\"2026-05-29 16:02:15\",\"remark\":\"计算机学院学生\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"参赛学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":3,\"userName\":\"student01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 14:55:27', 22);
INSERT INTO `sys_oper_log` VALUES (124, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 14:56:18', 75);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3034', '127.0.0.1', '内网IP', '3034 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 16:40:37', 7);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3034', '127.0.0.1', '内网IP', '3034 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 16:40:43', 2);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3035', '127.0.0.1', '内网IP', '3035 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 16:40:52', 3);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3035', '127.0.0.1', '内网IP', '3035 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 16:40:58', 3);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3036', '127.0.0.1', '内网IP', '3036 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 16:42:33', 4);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3034', '127.0.0.1', '内网IP', '3034 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 20:52:46', 4);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3031', '127.0.0.1', '内网IP', '3031 ', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 20:53:05', 2);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/3036', '127.0.0.1', '内网IP', '3036 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-05-31 20:54:32', 7);
INSERT INTO `sys_oper_log` VALUES (133, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-05-29 16:02:15\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"指导教师\",\"roleId\":2,\"roleKey\":\"teacher\",\"roleName\":\"指导教师\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 20:56:28', 33);
INSERT INTO `sys_oper_log` VALUES (134, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-31 21:08:16', 16);
INSERT INTO `sys_oper_log` VALUES (135, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'student01', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/06/01/4cb4bfdb2cc34d889015cad4290a957e.jpg\",\"code\":200}', 0, NULL, '2026-06-01 17:04:20', 77);
INSERT INTO `sys_oper_log` VALUES (136, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"单独\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 17:15:46', 50);
INSERT INTO `sys_oper_log` VALUES (137, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"路演答辩,BP撰写,PPT美工,后端架构,前端开发\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 17:40:28', 17);
INSERT INTO `sys_oper_log` VALUES (138, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"BP撰写,PPT美工,后端架构,前端开发\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 17:41:12', 11);
INSERT INTO `sys_oper_log` VALUES (139, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"BP撰写,PPT美工,后端架构,前端开发\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 18:23:50', 16);
INSERT INTO `sys_oper_log` VALUES (140, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"BP撰写,PPT美工,后端架构,前端开发\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 19:39:15', 25);
INSERT INTO `sys_oper_log` VALUES (141, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"BP撰写,PPT美工,后端架构,前端开发\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-01 19:43:35', 10);
INSERT INTO `sys_oper_log` VALUES (142, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"BP撰写,PPT美工,后端架构,前端开发,路演答辩\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-02 07:05:21', 37);
INSERT INTO `sys_oper_log` VALUES (143, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'student01', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"student01@tlxy.edu.cn\",\"grade\":\"2022级\",\"nickName\":\"yu\",\"params\":{},\"phonenumber\":\"15777777777\",\"sex\":\"1\",\"skillTags\":\"路演答辩,PPT美工,UI/UX设计,项目PM,市场调研\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-02 07:42:10', 8);
INSERT INTO `sys_oper_log` VALUES (144, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":5} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 14:48:25', 79);
INSERT INTO `sys_oper_log` VALUES (145, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":902,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15711111111\",\"postIds\":[4],\"remark\":\"wu\",\"roleIds\":[100],\"sex\":\"1\",\"status\":\"0\",\"userName\":\"admin\"} ', '{\"msg\":\"新增用户\'admin\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2026-06-03 14:49:12', 3);
INSERT INTO `sys_oper_log` VALUES (146, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":902,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"postIds\":[4],\"remark\":\"wu\",\"roleIds\":[100],\"sex\":\"1\",\"status\":\"0\",\"userName\":\"admin\"} ', '{\"msg\":\"新增用户\'admin\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2026-06-03 14:49:18', 2);
INSERT INTO `sys_oper_log` VALUES (147, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":902,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"postIds\":[4],\"remark\":\"wu\",\"roleIds\":[100],\"sex\":\"1\",\"status\":\"0\",\"userId\":100,\"userName\":\"yao\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 14:49:31', 86);
INSERT INTO `sys_oper_log` VALUES (148, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'yao', '金融学', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"sex\":\"1\",\"skillTags\":\"路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 17:44:47', 12);
INSERT INTO `sys_oper_log` VALUES (149, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'yao', '金融学', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"sex\":\"1\",\"skillTags\":\"路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 17:59:47', 18);
INSERT INTO `sys_oper_log` VALUES (150, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"3060\",\"orderNums\":\"5\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 23:34:01', 20);
INSERT INTO `sys_oper_log` VALUES (151, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"1,3010,3030\",\"orderNums\":\"1,1,1\"} ', NULL, 1, '提交的排序号中存在重复，请检查', '2026-06-03 23:34:15', 2);
INSERT INTO `sys_oper_log` VALUES (152, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"3010,3,3020,3030,3060\",\"orderNums\":\"1,6,5,3,7\"} ', NULL, 1, '当前菜单层级下已存在该排序号 1，请重新输入', '2026-06-03 23:34:30', 5);
INSERT INTO `sys_oper_log` VALUES (153, '保存菜单排序', 2, 'com.ruoyi.web.controller.system.SysMenuController.updateSort()', 'PUT', 1, 'admin', NULL, '/system/menu/updateSort', '127.0.0.1', '内网IP', '{\"menuIds\":\"3010,3,3020,3030,3060\",\"orderNums\":\"3,6,8,5,7\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 23:34:51', 23);
INSERT INTO `sys_oper_log` VALUES (154, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-03 23:58:28', 78);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'dean', '院长', 1, '0', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'director', '系主任', 2, '0', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'teacher', '教师', 3, '0', 'admin', '2026-05-29 16:02:15', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'student', '学生', 4, '0', 'admin', '2026-05-29 16:02:15', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1全部数据权限 2自定数据权限 3本部门数据权限 4本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-29 16:02:15', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '指导教师', 'teacher', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-29 16:02:15', 'admin', '2026-05-31 20:56:28', '指导教师');
INSERT INTO `sys_role` VALUES (100, '参赛学生', 'student', 3, '1', 1, 1, '0', '0', 'admin', '2026-05-29 16:02:15', '', NULL, '参赛学生');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 3);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 100);
INSERT INTO `sys_role_menu` VALUES (1, 101);
INSERT INTO `sys_role_menu` VALUES (1, 102);
INSERT INTO `sys_role_menu` VALUES (1, 103);
INSERT INTO `sys_role_menu` VALUES (1, 104);
INSERT INTO `sys_role_menu` VALUES (1, 105);
INSERT INTO `sys_role_menu` VALUES (1, 106);
INSERT INTO `sys_role_menu` VALUES (1, 107);
INSERT INTO `sys_role_menu` VALUES (1, 108);
INSERT INTO `sys_role_menu` VALUES (1, 109);
INSERT INTO `sys_role_menu` VALUES (1, 110);
INSERT INTO `sys_role_menu` VALUES (1, 111);
INSERT INTO `sys_role_menu` VALUES (1, 112);
INSERT INTO `sys_role_menu` VALUES (1, 113);
INSERT INTO `sys_role_menu` VALUES (1, 114);
INSERT INTO `sys_role_menu` VALUES (1, 115);
INSERT INTO `sys_role_menu` VALUES (1, 116);
INSERT INTO `sys_role_menu` VALUES (1, 117);
INSERT INTO `sys_role_menu` VALUES (1, 118);
INSERT INTO `sys_role_menu` VALUES (1, 1000);
INSERT INTO `sys_role_menu` VALUES (1, 1001);
INSERT INTO `sys_role_menu` VALUES (1, 1002);
INSERT INTO `sys_role_menu` VALUES (1, 1003);
INSERT INTO `sys_role_menu` VALUES (1, 1004);
INSERT INTO `sys_role_menu` VALUES (1, 1005);
INSERT INTO `sys_role_menu` VALUES (1, 1006);
INSERT INTO `sys_role_menu` VALUES (1, 1007);
INSERT INTO `sys_role_menu` VALUES (1, 1008);
INSERT INTO `sys_role_menu` VALUES (1, 1009);
INSERT INTO `sys_role_menu` VALUES (1, 1010);
INSERT INTO `sys_role_menu` VALUES (1, 1011);
INSERT INTO `sys_role_menu` VALUES (1, 1012);
INSERT INTO `sys_role_menu` VALUES (1, 1013);
INSERT INTO `sys_role_menu` VALUES (1, 1014);
INSERT INTO `sys_role_menu` VALUES (1, 1015);
INSERT INTO `sys_role_menu` VALUES (1, 1016);
INSERT INTO `sys_role_menu` VALUES (1, 1017);
INSERT INTO `sys_role_menu` VALUES (1, 1018);
INSERT INTO `sys_role_menu` VALUES (1, 1019);
INSERT INTO `sys_role_menu` VALUES (1, 1020);
INSERT INTO `sys_role_menu` VALUES (1, 1021);
INSERT INTO `sys_role_menu` VALUES (1, 1022);
INSERT INTO `sys_role_menu` VALUES (1, 1023);
INSERT INTO `sys_role_menu` VALUES (1, 1025);
INSERT INTO `sys_role_menu` VALUES (1, 1026);
INSERT INTO `sys_role_menu` VALUES (1, 1027);
INSERT INTO `sys_role_menu` VALUES (1, 1028);
INSERT INTO `sys_role_menu` VALUES (1, 1030);
INSERT INTO `sys_role_menu` VALUES (1, 1031);
INSERT INTO `sys_role_menu` VALUES (1, 1032);
INSERT INTO `sys_role_menu` VALUES (1, 1033);
INSERT INTO `sys_role_menu` VALUES (1, 1035);
INSERT INTO `sys_role_menu` VALUES (1, 1036);
INSERT INTO `sys_role_menu` VALUES (1, 1037);
INSERT INTO `sys_role_menu` VALUES (1, 1038);
INSERT INTO `sys_role_menu` VALUES (1, 1090);
INSERT INTO `sys_role_menu` VALUES (1, 1091);
INSERT INTO `sys_role_menu` VALUES (1, 1092);
INSERT INTO `sys_role_menu` VALUES (1, 1093);
INSERT INTO `sys_role_menu` VALUES (1, 1094);
INSERT INTO `sys_role_menu` VALUES (1, 1140);
INSERT INTO `sys_role_menu` VALUES (1, 1141);
INSERT INTO `sys_role_menu` VALUES (1, 1150);
INSERT INTO `sys_role_menu` VALUES (1, 1151);
INSERT INTO `sys_role_menu` VALUES (1, 1170);
INSERT INTO `sys_role_menu` VALUES (1, 1171);
INSERT INTO `sys_role_menu` VALUES (1, 1172);
INSERT INTO `sys_role_menu` VALUES (1, 1173);
INSERT INTO `sys_role_menu` VALUES (1, 3060);
INSERT INTO `sys_role_menu` VALUES (1, 3061);
INSERT INTO `sys_role_menu` VALUES (1, 3062);
INSERT INTO `sys_role_menu` VALUES (1, 3063);
INSERT INTO `sys_role_menu` VALUES (1, 3064);
INSERT INTO `sys_role_menu` VALUES (1, 3065);
INSERT INTO `sys_role_menu` VALUES (1, 3070);
INSERT INTO `sys_role_menu` VALUES (1, 3071);
INSERT INTO `sys_role_menu` VALUES (1, 3072);
INSERT INTO `sys_role_menu` VALUES (2, 3000);
INSERT INTO `sys_role_menu` VALUES (2, 3001);
INSERT INTO `sys_role_menu` VALUES (2, 3020);
INSERT INTO `sys_role_menu` VALUES (2, 3021);
INSERT INTO `sys_role_menu` VALUES (2, 3060);
INSERT INTO `sys_role_menu` VALUES (2, 3061);
INSERT INTO `sys_role_menu` VALUES (2, 3062);
INSERT INTO `sys_role_menu` VALUES (2, 3070);
INSERT INTO `sys_role_menu` VALUES (2, 3071);
INSERT INTO `sys_role_menu` VALUES (2, 3072);
INSERT INTO `sys_role_menu` VALUES (100, 3000);
INSERT INTO `sys_role_menu` VALUES (100, 3001);
INSERT INTO `sys_role_menu` VALUES (100, 3002);
INSERT INTO `sys_role_menu` VALUES (100, 3010);
INSERT INTO `sys_role_menu` VALUES (100, 3020);
INSERT INTO `sys_role_menu` VALUES (100, 3021);
INSERT INTO `sys_role_menu` VALUES (100, 3022);
INSERT INTO `sys_role_menu` VALUES (100, 3030);
INSERT INTO `sys_role_menu` VALUES (100, 3031);
INSERT INTO `sys_role_menu` VALUES (100, 3032);
INSERT INTO `sys_role_menu` VALUES (100, 3033);
INSERT INTO `sys_role_menu` VALUES (100, 3040);
INSERT INTO `sys_role_menu` VALUES (100, 3050);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `student_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学号',
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '年级',
  `skill_tags` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '技能标签',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `show_in_market` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否在人才市场显示(0否 1是)',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, 'admin', 'admin', '00', 'admin@tlxy.edu.cn', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-04 02:06:15', '2026-05-29 16:02:15', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', NULL, '超级管理员', '0');
INSERT INTO `sys_user` VALUES (2, 101, 'teacher01', '张老师', '00', 'teacher01@tlxy.edu.cn', '15666666666', '1', '', '$2a$10$R/i0.ZNrwzUzXlDTteDF3eOI.XYh96hmPyNY8o2E8qNj/7Dom4nuO', '0', '0', '127.0.0.1', '2026-06-04 00:44:05', '2026-06-03 23:58:28', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', '2026-06-03 23:58:28', '计算机学院老师', '0');
INSERT INTO `sys_user` VALUES (3, NULL, 'student01', 'yu', '00', 'student01@tlxy.edu.cn', '15777777777', '1', '/profile/avatar/2026/06/01/4cb4bfdb2cc34d889015cad4290a957e.jpg', '$2a$10$7Twf9K.Ww7iS/f1HT2B7busjKcnMSgUqQJ/.2ZeASHOhLqnxZ.LGy', '0', '0', '127.0.0.1', '2026-06-04 01:43:00', '2026-05-31 14:56:18', '2206161033', '2022级', '路演答辩,PPT美工,UI/UX设计,项目PM,市场调研', 'admin', '2026-05-29 16:02:15', 'admin', '2026-06-03 20:03:27', '计算机学院学生', '1');
INSERT INTO `sys_user` VALUES (4, 201, 'teacher02', '王老师', '00', 'teacher02@tlxy.edu.cn', '15888888889', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-29 16:02:15', '2026-05-29 16:02:15', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', NULL, '电气工程学院老师', '0');
INSERT INTO `sys_user` VALUES (5, 201, 'student02', '赵同学', '00', 'student02@tlxy.edu.cn', '15999999999', '2', '', '$2a$10$fQNBa99hO7dMTdCei.zCqeFTAGRv6vpwRiHuyw2X0oPZbxwJv7cmu', '0', '0', '127.0.0.1', '2026-05-29 16:02:15', '2026-06-03 14:48:25', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', '2026-06-03 14:48:25', '电气工程学院学生', '0');
INSERT INTO `sys_user` VALUES (100, NULL, 'yao', 'yao', '00', '11111111111@qq.com', '15811111111', '1', '', '$2a$10$zRh8CDS5rbE9t24ED/1yn.vW4MyPIwlQDzzlae8uBIbsWwlu3h0JC', '0', '0', '127.0.0.1', '2026-06-03 23:49:45', NULL, NULL, NULL, '路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写', 'admin', '2026-06-03 14:49:31', '', '2026-06-03 21:40:03', 'wu', '1');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 3);
INSERT INTO `sys_user_post` VALUES (4, 3);
INSERT INTO `sys_user_post` VALUES (5, 4);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 100);
INSERT INTO `sys_user_role` VALUES (4, 2);
INSERT INTO `sys_user_role` VALUES (5, 100);
INSERT INTO `sys_user_role` VALUES (100, 100);

-- ----------------------------
-- Table structure for team_teacher_invitation
-- ----------------------------
DROP TABLE IF EXISTS `team_teacher_invitation`;
CREATE TABLE `team_teacher_invitation`  (
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师邀请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of team_teacher_invitation
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
