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

 Date: 09/07/2026 18:51:16
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛业务表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛队伍表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comp_team
-- ----------------------------
INSERT INTO `comp_team` VALUES (1, 202, '一切可以队', 3, 'student01', NULL, NULL, 'N7VZBU', '0', 5, 1, '2', 'student01', '2026-06-03 14:37:38', '', '2026-06-03 14:46:43', NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (2, 202, 'ok队', 100, 'yao', NULL, NULL, '8SYFQ6', '0', 5, 2, '0', 'student01', '2026-06-03 14:52:15', 'yao', '2026-06-03 17:37:37', NULL, '1', '');
INSERT INTO `comp_team` VALUES (3, 103, '111', 3, 'student01', NULL, NULL, '6BXQPD', '0', 5, 1, '0', 'student01', '2026-06-04 02:15:24', '', '2026-06-04 02:15:33', NULL, '0', '路演答辩,市场调研');
INSERT INTO `comp_team` VALUES (4, 400, 'TestTeam001', 3, 'student01', 2, 'teacher01', 'V846F5', NULL, 5, 2, '0', 'student01', '2026-06-28 15:06:35', 'student02', '2026-06-28 15:08:24', NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (5, 430, 'TeamAlpha', 3, 'student01', NULL, NULL, '42FMFK', '0', 5, 2, '0', 'student01', '2026-06-28 21:29:11', 'student02', '2026-06-28 21:29:12', NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (6, 431, 'TeamOne', 3, 'student01', NULL, NULL, 'MVBPAF', '0', 5, 1, '0', 'student01', '2026-06-28 21:29:12', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (7, 432, 'RaceTeam', 3, 'student01', NULL, NULL, 'AGZD8Y', '0', 5, 2, '0', 'student01', '2026-06-28 21:29:13', 'student02', '2026-06-28 21:29:14', NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (8, 433, 'BadTeam', 3, 'student01', NULL, NULL, 'MHCRPM', '0', 5, 1, '0', 'student01', '2026-06-28 21:29:14', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (9, 436, '<script>alert(1)</script>', 3, 'student01', NULL, NULL, 'A6PZSD', '0', 5, 1, '0', 'student01', '2026-06-28 21:29:15', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (10, 440, 'draft-team-test', 3, 'student01', NULL, NULL, 'RSGZUS', '0', 5, 1, '0', 'student01', '2026-06-29 11:16:14', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (11, 441, 'draft-team-retest', 3, 'student01', NULL, NULL, '4F4RWD', '0', 5, 1, '0', 'student01', '2026-06-29 13:30:17', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (12, 443, 'max-test-team', 3, 'student01', NULL, NULL, 'QZB9AY', '0', 5, 1, '0', 'student01', '2026-06-29 13:31:15', '', NULL, NULL, '0', NULL);
INSERT INTO `comp_team` VALUES (13, 445, '<script>alert(1)</script>', 3, 'student01', NULL, NULL, 'DEPGUB', '0', 5, 1, '0', 'student01', '2026-06-29 13:34:48', '', NULL, NULL, '0', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '队伍队员关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comp_team_member
-- ----------------------------
INSERT INTO `comp_team_member` VALUES (1, 1, 3, 'student01', 'student01', '2026-06-03 14:37:38', '2', 'student01', '2026-06-03 14:37:38');
INSERT INTO `comp_team_member` VALUES (2, 2, 3, 'student01', 'student01', '2026-06-03 14:52:15', '0', 'student01', '2026-06-03 14:52:15');
INSERT INTO `comp_team_member` VALUES (3, 2, 100, 'yao', 'yao', '2026-06-03 14:56:36', '0', 'yao', '2026-06-03 14:56:36');
INSERT INTO `comp_team_member` VALUES (4, 3, 3, 'student01', 'student01', '2026-06-04 02:15:24', '0', 'student01', '2026-06-04 02:15:24');
INSERT INTO `comp_team_member` VALUES (5, 4, 3, 'student01', 'student01', '2026-06-28 15:06:35', '0', 'student01', '2026-06-28 15:06:35');
INSERT INTO `comp_team_member` VALUES (6, 4, 5, 'student02', '赵同学', '2026-06-28 15:06:57', '0', 'student02', '2026-06-28 15:06:57');
INSERT INTO `comp_team_member` VALUES (7, 5, 3, 'student01', 'student01', '2026-06-28 21:29:11', '0', 'student01', '2026-06-28 21:29:11');
INSERT INTO `comp_team_member` VALUES (8, 5, 5, 'student02', '赵同学', '2026-06-28 21:29:12', '0', 'student02', '2026-06-28 21:29:12');
INSERT INTO `comp_team_member` VALUES (9, 6, 3, 'student01', 'student01', '2026-06-28 21:29:12', '0', 'student01', '2026-06-28 21:29:12');
INSERT INTO `comp_team_member` VALUES (10, 7, 3, 'student01', 'student01', '2026-06-28 21:29:13', '0', 'student01', '2026-06-28 21:29:13');
INSERT INTO `comp_team_member` VALUES (11, 7, 5, 'student02', '赵同学', '2026-06-28 21:29:14', '0', 'student02', '2026-06-28 21:29:14');
INSERT INTO `comp_team_member` VALUES (12, 8, 3, 'student01', 'student01', '2026-06-28 21:29:15', '0', 'student01', '2026-06-28 21:29:15');
INSERT INTO `comp_team_member` VALUES (13, 9, 3, 'student01', 'student01', '2026-06-28 21:29:15', '0', 'student01', '2026-06-28 21:29:15');
INSERT INTO `comp_team_member` VALUES (14, 10, 3, 'student01', 'student01', '2026-06-29 11:16:14', '0', 'student01', '2026-06-29 11:16:14');
INSERT INTO `comp_team_member` VALUES (15, 11, 3, 'student01', 'student01', '2026-06-29 13:30:17', '0', 'student01', '2026-06-29 13:30:17');
INSERT INTO `comp_team_member` VALUES (16, 12, 3, 'student01', 'student01', '2026-06-29 13:31:15', '0', 'student01', '2026-06-29 13:31:15');
INSERT INTO `comp_team_member` VALUES (17, 13, 3, 'student01', 'student01', '2026-06-29 13:34:48', '0', 'student01', '2026-06-29 13:34:48');

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
  `publish_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '发布状态（0草稿 1已发布 2已关闭 3已归档）',
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
) ENGINE = InnoDB AUTO_INCREMENT = 447 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '竞赛信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition
-- ----------------------------
INSERT INTO `competition` VALUES (100, '全国大学生数学建模竞赛', '01', '学科竞赛', '2', '4', '全国大学生数学建模竞赛是由教育部高等教育司和中国工业与应用数学学会共同主办的面向全国大学生的群众性科技活动。', '2026-06-01 00:00:00', '2026-09-15 23:59:59', '2026-09-20 08:00:00', '2026-09-23 18:00:00', '0', '1', '教育部', '中国工业与应用数学学会', 50000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (101, '中国大学生计算机设计大赛', '01', '学科竞赛', '1', '4', '中国大学生计算机设计大赛是面向全国高校在校学生的科技类竞赛活动。', '2026-05-01 00:00:00', '2026-07-31 23:59:59', '2026-08-15 08:00:00', '2026-08-20 18:00:00', '0', '1', '教育部', '中国高等教育学会', 30000, 1, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (102, '互联网+大学生创新创业大赛', '02', '创新创业', '2', '4', '中国国际\"互联网+\"大学生创新创业大赛是由教育部等多部委共同主办的国家级创新创业赛事。', '2026-04-01 00:00:00', '2026-06-30 23:59:59', '2026-07-15 08:00:00', '2026-07-20 18:00:00', '1', '1', '教育部', '各高校', 100000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (103, '全国大学生电子设计竞赛', '03', '技能竞赛', '2', '4', '全国大学生电子设计竞赛是面向全国大学生的电子信息类学科竞赛。', '2026-03-01 00:00:00', '2026-08-31 23:59:59', '2026-09-08 08:00:00', '2026-09-11 18:00:00', '2', '1', '教育部', '高等学校电子信息类专业教学指导委员会', 20000, 0, 0, '', '0', '', NULL, '', NULL);
INSERT INTO `competition` VALUES (200, '2026年全国大学生英语作文大赛', '04', '外语类', '1', '4', '<p><strong>主办单位：</strong>高等学校大学外语教学研究会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国在校大学生（含高职高专、本科、研究生）</p><p><strong>竞赛形式：</strong>线上提交英语作文，题材不限，字数要求800-1500词。</p><p>本赛事已被多所双一流高校纳入保研加分体系，获奖证书含金量高。</p>', '2026-03-01 00:00:00', '2026-12-15 23:59:59', '2026-12-20 08:00:00', '2026-12-25 18:00:00', '0', '1', '高等学校大学外语教学研究会', '全国大学生英语作文大赛组委会', 500000, 12350, 351000, '[\"A类赛事\",\"双一流高校覆盖\",\"保研加分\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (201, '2026全国大学生\"麟创杯\"人工智能知识竞赛', '05', 'IT/计算机类', '1', '4', '<p><strong>主办单位：</strong>中国技术市场协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生</p><p><strong>竞赛形式：</strong>线上客观题答题，涵盖人工智能基础、机器学习、深度学习、自然语言处理等知识点，满分100分。</p><p>本赛事由中国技术市场协会（国家一级社团）主办，证书可用于综测加分。</p>', '2026-04-01 00:00:00', '2026-10-31 23:59:59', '2026-11-05 08:00:00', '2026-11-10 18:00:00', '0', '1', '中国技术市场协会', '\"麟创杯\"人工智能知识竞赛组委会', 100000, 3421, 56000, '[\"人工智能\",\"客观题答题\",\"国家一级社团\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (202, '2026年第六届全国大学生技术创新创业大赛', '02', '创新创业', '2', '4', '<p><strong>主办单位：</strong>中国技术创业协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生（本、硕、博均可）</p><p><strong>竞赛形式：</strong>团队参赛（3-5人），提交创业计划书及路演PPT，经初赛、复赛、决赛三轮评审。</p><p>优胜项目可获立项支持及投资人对接机会，是\"互联网+\"大赛的优质热身赛。</p>', '2026-02-01 00:00:00', '2026-09-30 23:59:59', '2026-10-15 08:00:00', '2026-10-20 18:00:00', '0', '1', '中国技术创业协会', '全国大学生技术创新创业大赛组委会', 80000, 2890, 36000, '[\"挑战杯热身\",\"互联网+\",\"立项支持\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (203, '2026年第十六届APMCM亚太地区大学生数学建模竞赛', '06', '理工/数学类', '2', '5', '<p><strong>主办单位：</strong>中国国际科技促进会</p><p><strong>竞赛级别：</strong>国际级/国家级</p><p><strong>参赛对象：</strong>亚太地区高校在校学生</p><p><strong>竞赛形式：</strong>3人组队，在4天时间内完成一道数学建模题目，提交英文论文。赛题涵盖工程、经济、环境等交叉学科。</p><p>APMCM是国际认可度较高的数学建模赛事之一，获奖可用于国赛热身及综合测评加分。</p>', '2025-11-01 00:00:00', '2026-05-15 23:59:59', '2026-05-20 08:00:00', '2026-08-20 18:00:00', '1', '1', '中国国际科技促进会', 'APMCM亚太地区大学生数学建模竞赛组委会', 30000, 18500, 47000, '[\"数学建模\",\"国赛热身\",\"综合测评加分\"]', '0', 'admin', '2026-06-02 21:47:19', '', NULL);
INSERT INTO `competition` VALUES (300, '全国大学生市场调查与分析大赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国大学生市场调查与分析大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-12 23:59:59', '2026-08-10 08:00:00', '2026-08-12 18:00:00', '0', '1', '中国商业统计学会', '全国大学生市场调查与分析大赛组委会', 3000, 121, 1800, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (301, '全国大学生广告艺术大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生广告艺术大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-13 23:59:59', '2026-09-11 08:00:00', '2026-09-13 18:00:00', '0', '1', '全国大学生广告艺术大赛组委会', '全国大学生广告艺术大赛组委会', 5000, 257, 2777, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (302, '全国大学生物流设计大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生物流设计大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-14 23:59:59', '2026-10-12 08:00:00', '2026-10-14 18:00:00', '0', '1', '中国物流与采购联合会', '全国大学生物流设计大赛组委会', 7000, 394, 3754, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (303, '全国大学生结构设计竞赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国大学生结构设计竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-15 23:59:59', '2026-11-13 08:00:00', '2026-11-15 18:00:00', '0', '1', '全国大学生结构设计竞赛委员会', '全国大学生结构设计竞赛组委会', 9000, 531, 4731, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (304, '全国周培源大学生力学竞赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国周培源大学生力学竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-16 23:59:59', '2026-12-14 08:00:00', '2026-12-16 18:00:00', '0', '1', '中国力学学会', '全国周培源大学生力学竞赛组委会', 11000, 668, 5708, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (305, '全国大学生化学实验创新设计大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生化学实验创新设计大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-17 23:59:59', '2026-08-15 08:00:00', '2026-08-17 18:00:00', '0', '1', '中国化学会', '全国大学生化学实验创新设计大赛组委会', 13000, 805, 6685, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (306, '全国大学生物理实验竞赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国大学生物理实验竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-18 23:59:59', '2026-09-16 08:00:00', '2026-09-18 18:00:00', '0', '1', '高等学校国家级实验教学示范中心联席会', '全国大学生物理实验竞赛组委会', 15000, 943, 7662, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (307, '全国大学生测绘学科创新创业智能大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生测绘学科创新创业智能大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-19 23:59:59', '2026-10-17 08:00:00', '2026-10-19 18:00:00', '0', '1', '中国测绘学会教育工作委员会', '全国大学生测绘学科创新创业智能大赛组委会', 17000, 1079, 8639, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (308, '全国大学生GIS应用技能大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生GIS应用技能大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-20 23:59:59', '2026-11-18 08:00:00', '2026-11-20 18:00:00', '0', '1', '中国地理信息产业协会', '全国大学生GIS应用技能大赛组委会', 19000, 1216, 9616, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (309, '全国大学生土地国情调查大赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国大学生土地国情调查大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-21 23:59:59', '2026-12-19 08:00:00', '2026-12-21 18:00:00', '0', '1', '教育部高等学校公共管理类专业教学指导委员会', '全国大学生土地国情调查大赛组委会', 21000, 1353, 10593, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (310, '全国大学生交通科技大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生交通科技大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-22 23:59:59', '2026-08-20 08:00:00', '2026-08-22 18:00:00', '0', '1', '全国大学生交通科技大赛组委会', '全国大学生交通科技大赛组委会', 3000, 1490, 11570, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (311, '全国大学生先进成图技术与产品信息建模创新大赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生先进成图技术与产品信息建模创新大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-23 23:59:59', '2026-09-20 08:00:00', '2026-09-23 18:00:00', '0', '1', '全国大学生先进成图技术大赛组委会', '全国大学生先进成图技术与产品信息建模创新大赛组委会', 5000, 1627, 12547, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (312, '全国高校商业精英挑战赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国高校商业精英挑战赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-24 23:59:59', '2026-10-10 08:00:00', '2026-10-12 18:00:00', '0', '1', '中国贸促会商业行业委员会', '全国高校商业精英挑战赛组委会', 7000, 1764, 13524, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (313, '全国大学生人力资源管理综合能力竞赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生人力资源管理综合能力竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-25 23:59:59', '2026-11-11 08:00:00', '2026-11-13 18:00:00', '0', '1', '中国人力资源开发研究会', '全国大学生人力资源管理综合能力竞赛组委会', 9000, 1901, 14501, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (314, '全国大学生工程管理创新创业竞赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生工程管理创新创业竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-12 23:59:59', '2026-12-12 08:00:00', '2026-12-14 18:00:00', '0', '1', '教育部工程管理和工程造价专业教学指导分委员会', '全国大学生工程管理创新创业竞赛组委会', 11000, 2038, 15478, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (315, '全国大学生统计建模大赛', '01', '学科竞赛', '1', '4', '<p><strong>赛事简介：</strong>全国大学生统计建模大赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-13 23:59:59', '2026-08-13 08:00:00', '2026-08-15 18:00:00', '0', '1', '中国统计教育学会', '全国大学生统计建模大赛组委会', 13000, 2175, 16455, '[\"学科竞赛\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (316, '全国大学生生命科学竞赛', '01', '学科竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生生命科学竞赛面向高校学生开展，侧重学科竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-14 23:59:59', '2026-09-14 08:00:00', '2026-09-16 18:00:00', '0', '1', '全国大学生生命科学竞赛委员会', '全国大学生生命科学竞赛组委会', 15000, 2312, 17432, '[\"学科竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (317, '挑战杯全国大学生课外学术科技作品竞赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>挑战杯全国大学生课外学术科技作品竞赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-15 23:59:59', '2026-10-15 08:00:00', '2026-10-17 18:00:00', '0', '1', '共青团中央、中国科协、教育部', '挑战杯全国大学生课外学术科技作品竞赛组委会', 17000, 2449, 18409, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (318, '挑战杯中国大学生创业计划竞赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>挑战杯中国大学生创业计划竞赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-16 23:59:59', '2026-11-16 08:00:00', '2026-11-18 18:00:00', '0', '1', '共青团中央、教育部', '挑战杯中国大学生创业计划竞赛组委会', 19000, 2586, 19386, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (319, '中国国际大学生创新大赛', '02', '创新创业', '2', '5', '<p><strong>赛事简介：</strong>中国国际大学生创新大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-17 23:59:59', '2026-12-17 08:00:00', '2026-12-19 18:00:00', '0', '1', '教育部等部门', '中国国际大学生创新大赛组委会', 21000, 123, 20363, '[\"创新创业\",\"团队赛\",\"国际赛事\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (320, '全国大学生电子商务创新创意及创业挑战赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生电子商务创新创意及创业挑战赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-18 23:59:59', '2026-08-18 08:00:00', '2026-08-20 18:00:00', '0', '1', '全国电子商务产教融合创新联盟', '全国大学生电子商务创新创意及创业挑战赛组委会', 3000, 260, 21340, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (321, '中国大学生服务外包创新创业大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>中国大学生服务外包创新创业大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-19 23:59:59', '2026-09-19 08:00:00', '2026-09-21 18:00:00', '0', '1', '教育部、商务部、无锡市人民政府', '中国大学生服务外包创新创业大赛组委会', 5000, 397, 22317, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (322, 'iCAN大学生创新创业大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>iCAN大学生创新创业大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-20 23:59:59', '2026-10-20 08:00:00', '2026-10-22 18:00:00', '0', '1', 'iCAN大学生创新创业大赛组委会', 'iCAN大学生创新创业大赛组委会', 7000, 534, 23294, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (323, '全国大学生节能减排社会实践与科技竞赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生节能减排社会实践与科技竞赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-21 23:59:59', '2026-11-20 08:00:00', '2026-11-23 18:00:00', '0', '1', '教育部高等教育司', '全国大学生节能减排社会实践与科技竞赛组委会', 9000, 671, 24271, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (324, '全国大学生创新方法大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生创新方法大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-22 23:59:59', '2026-12-10 08:00:00', '2026-12-12 18:00:00', '0', '1', '中国科协', '全国大学生创新方法大赛组委会', 11000, 808, 25248, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (325, '全国大学生乡村振兴创新创业大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生乡村振兴创新创业大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-23 23:59:59', '2026-08-11 08:00:00', '2026-08-13 18:00:00', '0', '1', '全国大学生乡村振兴创新创业大赛组委会', '全国大学生乡村振兴创新创业大赛组委会', 13000, 945, 26225, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (326, '全国大学生文化创意设计大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生文化创意设计大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-24 23:59:59', '2026-09-12 08:00:00', '2026-09-14 18:00:00', '0', '1', '全国大学生文化创意设计大赛组委会', '全国大学生文化创意设计大赛组委会', 15000, 1082, 27202, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (327, '中国大学生机械工程创新创意大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>中国大学生机械工程创新创意大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-25 23:59:59', '2026-10-13 08:00:00', '2026-10-15 18:00:00', '0', '1', '中国机械工程学会', '中国大学生机械工程创新创意大赛组委会', 17000, 1219, 28179, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (328, '全国大学生工业设计大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生工业设计大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-12 23:59:59', '2026-11-14 08:00:00', '2026-11-16 18:00:00', '0', '1', '教育部高等学校工业设计专业教学指导分委员会', '全国大学生工业设计大赛组委会', 19000, 1356, 29156, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (329, '全国大学生数字媒体科技作品及创意竞赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生数字媒体科技作品及创意竞赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-13 23:59:59', '2026-12-15 08:00:00', '2026-12-17 18:00:00', '0', '1', '中国人工智能学会', '全国大学生数字媒体科技作品及创意竞赛组委会', 21000, 1493, 30133, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (330, '两岸新锐设计竞赛华灿奖', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>两岸新锐设计竞赛华灿奖面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-14 23:59:59', '2026-08-16 08:00:00', '2026-08-18 18:00:00', '0', '1', '中国高等教育学会', '两岸新锐设计竞赛华灿奖组委会', 3000, 1630, 31110, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (331, '米兰设计周中国高校设计学科师生优秀作品展', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>米兰设计周中国高校设计学科师生优秀作品展面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-15 23:59:59', '2026-09-17 08:00:00', '2026-09-19 18:00:00', '0', '1', '米兰设计周中国高校设计学科师生优秀作品展组委会', '米兰设计周中国高校设计学科师生优秀作品展组委会', 5000, 1767, 32087, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (332, '未来设计师·全国高校数字艺术设计大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>未来设计师·全国高校数字艺术设计大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-16 23:59:59', '2026-10-18 08:00:00', '2026-10-20 18:00:00', '0', '1', '工业和信息化部人才交流中心', '未来设计师·全国高校数字艺术设计大赛组委会', 7000, 1904, 33064, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (333, '全国大学生红色旅游创意策划大赛', '02', '创新创业', '2', '4', '<p><strong>赛事简介：</strong>全国大学生红色旅游创意策划大赛面向高校学生开展，侧重创新创业相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-17 23:59:59', '2026-11-19 08:00:00', '2026-11-21 18:00:00', '0', '1', '文化和旅游部资源开发司', '全国大学生红色旅游创意策划大赛组委会', 9000, 2041, 34041, '[\"创新创业\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (334, '全国大学生机器人大赛ROBOCON', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生机器人大赛ROBOCON面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-18 23:59:59', '2026-12-20 08:00:00', '2026-12-22 18:00:00', '0', '1', '共青团中央', '全国大学生机器人大赛ROBOCON组委会', 11000, 2178, 35018, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (335, 'RoboMaster全国大学生机器人大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>RoboMaster全国大学生机器人大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-19 23:59:59', '2026-08-20 08:00:00', '2026-08-23 18:00:00', '0', '1', '全国大学生机器人大赛组委会', 'RoboMaster全国大学生机器人大赛组委会', 13000, 2315, 35995, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (336, '中国高校智能机器人创意大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>中国高校智能机器人创意大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-20 23:59:59', '2026-09-10 08:00:00', '2026-09-12 18:00:00', '0', '1', '中国高等教育学会', '中国高校智能机器人创意大赛组委会', 15000, 2452, 36972, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (337, '全国大学生智能汽车竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生智能汽车竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-21 23:59:59', '2026-10-11 08:00:00', '2026-10-13 18:00:00', '0', '1', '教育部高等学校自动化类专业教学指导委员会', '全国大学生智能汽车竞赛组委会', 17000, 2589, 37949, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (338, '中国大学生工程实践与创新能力大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>中国大学生工程实践与创新能力大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-22 23:59:59', '2026-11-12 08:00:00', '2026-11-14 18:00:00', '0', '1', '教育部工程训练教学指导委员会', '中国大学生工程实践与创新能力大赛组委会', 19000, 126, 38926, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (339, '全国大学生机械创新设计大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生机械创新设计大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-23 23:59:59', '2026-12-13 08:00:00', '2026-12-15 18:00:00', '0', '1', '全国大学生机械创新设计大赛组委会', '全国大学生机械创新设计大赛组委会', 21000, 263, 39903, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (340, '全国大学生过程装备实践与创新赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生过程装备实践与创新赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-24 23:59:59', '2026-08-14 08:00:00', '2026-08-16 18:00:00', '0', '1', '中国机械工程学会', '全国大学生过程装备实践与创新赛组委会', 3000, 400, 40880, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (341, '全国大学生金相技能大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生金相技能大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-25 23:59:59', '2026-09-15 08:00:00', '2026-09-17 18:00:00', '0', '1', '教育部高等学校材料类专业教学指导委员会', '全国大学生金相技能大赛组委会', 5000, 537, 41857, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (342, '全国大学生焊接创新大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生焊接创新大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-12 23:59:59', '2026-10-16 08:00:00', '2026-10-18 18:00:00', '0', '1', '中国机械工程学会焊接分会', '全国大学生焊接创新大赛组委会', 7000, 674, 42834, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (343, '全国大学生光电设计竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生光电设计竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-13 23:59:59', '2026-11-17 08:00:00', '2026-11-19 18:00:00', '0', '1', '中国光学学会', '全国大学生光电设计竞赛组委会', 9000, 811, 43811, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (344, '全国大学生集成电路创新创业大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生集成电路创新创业大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-14 23:59:59', '2026-12-18 08:00:00', '2026-12-20 18:00:00', '0', '1', '工业和信息化部人才交流中心', '全国大学生集成电路创新创业大赛组委会', 11000, 948, 44788, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (345, '全国大学生嵌入式芯片与系统设计竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生嵌入式芯片与系统设计竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-15 23:59:59', '2026-08-19 08:00:00', '2026-08-21 18:00:00', '0', '1', '中国电子学会', '全国大学生嵌入式芯片与系统设计竞赛组委会', 13000, 1085, 45765, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (346, '全国大学生化工设计竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生化工设计竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-16 23:59:59', '2026-09-20 08:00:00', '2026-09-22 18:00:00', '0', '1', '中国化工学会', '全国大学生化工设计竞赛组委会', 15000, 1222, 46742, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (347, '全国大学生制药工程设计竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生制药工程设计竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-17 23:59:59', '2026-10-20 08:00:00', '2026-10-23 18:00:00', '0', '1', '教育部高等学校药学类专业教学指导委员会', '全国大学生制药工程设计竞赛组委会', 17000, 1359, 47719, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (348, '全国大学生水利创新设计大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生水利创新设计大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-18 23:59:59', '2026-11-10 08:00:00', '2026-11-12 18:00:00', '0', '1', '中国水利教育协会', '全国大学生水利创新设计大赛组委会', 19000, 1496, 48696, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (349, '全国大学生交通运输科技大赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生交通运输科技大赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-19 23:59:59', '2026-12-11 08:00:00', '2026-12-13 18:00:00', '0', '1', '中国交通教育研究会', '全国大学生交通运输科技大赛组委会', 21000, 1633, 49673, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (350, '全国大学生智能建造与管理创新竞赛', '03', '技能竞赛', '2', '4', '<p><strong>赛事简介：</strong>全国大学生智能建造与管理创新竞赛面向高校学生开展，侧重技能竞赛相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-20 23:59:59', '2026-08-12 08:00:00', '2026-08-14 18:00:00', '0', '1', '全国高校智能建造专业联盟', '全国大学生智能建造与管理创新竞赛组委会', 3000, 1770, 2650, '[\"技能竞赛\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (351, '外研社·国才杯理解当代中国全国大学生外语能力大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>外研社·国才杯理解当代中国全国大学生外语能力大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-21 23:59:59', '2026-09-13 08:00:00', '2026-09-15 18:00:00', '0', '1', '北京外国语大学', '外研社·国才杯理解当代中国全国大学生外语能力大赛组委会', 5000, 1907, 3627, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (352, '全国大学生英语竞赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生英语竞赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-22 23:59:59', '2026-10-14 08:00:00', '2026-10-16 18:00:00', '0', '1', '高等学校大学外语教学研究会', '全国大学生英语竞赛组委会', 7000, 2044, 4604, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (353, '21世纪杯全国英语演讲比赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>21世纪杯全国英语演讲比赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-23 23:59:59', '2026-11-15 08:00:00', '2026-11-17 18:00:00', '0', '1', '中国日报社', '21世纪杯全国英语演讲比赛组委会', 9000, 2181, 5581, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (354, '韩素音国际翻译大赛', '04', '外语类', '1', '5', '<p><strong>赛事简介：</strong>韩素音国际翻译大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-24 23:59:59', '2026-12-16 08:00:00', '2026-12-18 18:00:00', '0', '1', '中国翻译协会', '韩素音国际翻译大赛组委会', 11000, 2318, 6558, '[\"外语类\",\"个人赛\",\"国际赛事\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (355, '全国口译大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国口译大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-25 23:59:59', '2026-08-17 08:00:00', '2026-08-19 18:00:00', '0', '1', '中国翻译协会', '全国口译大赛组委会', 13000, 2455, 7535, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (356, '全国高校商务英语竞赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国高校商务英语竞赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-12 23:59:59', '2026-09-18 08:00:00', '2026-09-20 18:00:00', '0', '1', '中国对外贸易经济合作企业协会', '全国高校商务英语竞赛组委会', 15000, 2592, 8512, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (357, '全国大学生英语翻译大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生英语翻译大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-13 23:59:59', '2026-10-19 08:00:00', '2026-10-21 18:00:00', '0', '1', '全国大学生英语翻译大赛组委会', '全国大学生英语翻译大赛组委会', 17000, 129, 9489, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (358, '全国大学生英语词汇能力大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生英语词汇能力大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-14 23:59:59', '2026-11-20 08:00:00', '2026-11-22 18:00:00', '0', '1', '中国外语战略研究中心', '全国大学生英语词汇能力大赛组委会', 19000, 266, 10466, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (359, '全国大学生英语语法竞赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生英语语法竞赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-15 23:59:59', '2026-12-20 08:00:00', '2026-12-23 18:00:00', '0', '1', '全国大学生英语语法竞赛组委会', '全国大学生英语语法竞赛组委会', 21000, 403, 11443, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (360, '全国大学生学术英语词汇竞赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生学术英语词汇竞赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-16 23:59:59', '2026-08-10 08:00:00', '2026-08-12 18:00:00', '0', '1', '全国大学生学术英语竞赛组委会', '全国大学生学术英语词汇竞赛组委会', 3000, 540, 12420, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (361, '笹川杯全国高校日本知识大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>笹川杯全国高校日本知识大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-17 23:59:59', '2026-09-11 08:00:00', '2026-09-13 18:00:00', '0', '1', '中国教育国际交流协会', '笹川杯全国高校日本知识大赛组委会', 5000, 677, 13397, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (362, '中华全国日语演讲比赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>中华全国日语演讲比赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-18 23:59:59', '2026-10-12 08:00:00', '2026-10-14 18:00:00', '0', '1', '中国教育国际交流协会', '中华全国日语演讲比赛组委会', 7000, 814, 14374, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (363, '全国高校法语演讲比赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国高校法语演讲比赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-19 23:59:59', '2026-11-13 08:00:00', '2026-11-15 18:00:00', '0', '1', '教育部高等学校外国语言文学类专业教学指导委员会', '全国高校法语演讲比赛组委会', 9000, 951, 15351, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (364, '全国高校德语专业大学生德语辩论赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国高校德语专业大学生德语辩论赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-20 23:59:59', '2026-12-14 08:00:00', '2026-12-16 18:00:00', '0', '1', '教育部高等学校德语专业教学指导分委员会', '全国高校德语专业大学生德语辩论赛组委会', 11000, 1088, 16328, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (365, '全国高校俄语大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国高校俄语大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-21 23:59:59', '2026-08-15 08:00:00', '2026-08-17 18:00:00', '0', '1', '教育部国际合作与交流司', '全国高校俄语大赛组委会', 13000, 1227, 17305, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (366, '全国高校西班牙语专业四项技能大赛', '04', '外语类', '1', '4', '<p><strong>赛事简介：</strong>全国高校西班牙语专业四项技能大赛面向高校学生开展，侧重外语类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-22 23:59:59', '2026-09-16 08:00:00', '2026-09-18 18:00:00', '0', '1', '全国高校西班牙语专业教学研究会', '全国高校西班牙语专业四项技能大赛组委会', 15000, 1364, 18282, '[\"外语类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (367, 'ICPC国际大学生程序设计竞赛', '05', 'IT/计算机类', '1', '5', '<p><strong>赛事简介：</strong>ICPC国际大学生程序设计竞赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-23 23:59:59', '2026-10-17 08:00:00', '2026-10-19 18:00:00', '0', '1', 'ICPC基金会', 'ICPC国际大学生程序设计竞赛组委会', 17000, 1499, 19259, '[\"IT/计算机类\",\"个人赛\",\"国际赛事\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (368, '中国大学生程序设计竞赛CCPC', '05', 'IT/计算机类', '2', '4', '<p><strong>赛事简介：</strong>中国大学生程序设计竞赛CCPC面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-24 23:59:59', '2026-11-18 08:00:00', '2026-11-20 18:00:00', '0', '1', '中国大学生程序设计竞赛组委会', '中国大学生程序设计竞赛CCPC组委会', 19000, 1636, 20236, '[\"IT/计算机类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (369, '蓝桥杯全国软件和信息技术专业人才大赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>蓝桥杯全国软件和信息技术专业人才大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-25 23:59:59', '2026-12-19 08:00:00', '2026-12-21 18:00:00', '0', '1', '工业和信息化部人才交流中心', '蓝桥杯全国软件和信息技术专业人才大赛组委会', 21000, 1773, 21213, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (370, '中国高校计算机大赛团体程序设计天梯赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>中国高校计算机大赛团体程序设计天梯赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-12 23:59:59', '2026-08-20 08:00:00', '2026-08-22 18:00:00', '0', '1', '全国高等学校计算机教育研究会', '中国高校计算机大赛团体程序设计天梯赛组委会', 3000, 1912, 22190, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (371, '中国高校计算机大赛大数据挑战赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>中国高校计算机大赛大数据挑战赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-13 23:59:59', '2026-09-20 08:00:00', '2026-09-23 18:00:00', '0', '1', '全国高等学校计算机教育研究会', '中国高校计算机大赛大数据挑战赛组委会', 5000, 2049, 23167, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (372, '中国高校计算机大赛人工智能创意赛', '05', 'IT/计算机类', '2', '4', '<p><strong>赛事简介：</strong>中国高校计算机大赛人工智能创意赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-14 23:59:59', '2026-10-10 08:00:00', '2026-10-12 18:00:00', '0', '1', '全国高等学校计算机教育研究会', '中国高校计算机大赛人工智能创意赛组委会', 7000, 2184, 24144, '[\"IT/计算机类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (373, '中国高校计算机大赛网络技术挑战赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>中国高校计算机大赛网络技术挑战赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-15 23:59:59', '2026-11-11 08:00:00', '2026-11-13 18:00:00', '0', '1', '全国高等学校计算机教育研究会', '中国高校计算机大赛网络技术挑战赛组委会', 9000, 2321, 25121, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (374, '中国高校计算机大赛移动应用创新赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>中国高校计算机大赛移动应用创新赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-16 23:59:59', '2026-12-12 08:00:00', '2026-12-14 18:00:00', '0', '1', '全国高等学校计算机教育研究会', '中国高校计算机大赛移动应用创新赛组委会', 11000, 2458, 26098, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (375, '全国大学生信息安全竞赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生信息安全竞赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-17 23:59:59', '2026-08-13 08:00:00', '2026-08-15 18:00:00', '0', '1', '教育部高等学校网络空间安全专业教学指导委员会', '全国大学生信息安全竞赛组委会', 13000, 2597, 27075, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (376, '全国大学生网络安全精英赛', '05', 'IT/计算机类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生网络安全精英赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-18 23:59:59', '2026-09-14 08:00:00', '2026-09-16 18:00:00', '0', '1', '全国大学生网络安全精英赛组委会', '全国大学生网络安全精英赛组委会', 15000, 132, 28052, '[\"IT/计算机类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (377, '全国大学生软件测试大赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生软件测试大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-19 23:59:59', '2026-10-15 08:00:00', '2026-10-17 18:00:00', '0', '1', '全国大学生软件测试大赛组委会', '全国大学生软件测试大赛组委会', 17000, 269, 29029, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (378, '全国大学生物联网设计竞赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生物联网设计竞赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-20 23:59:59', '2026-11-16 08:00:00', '2026-11-18 18:00:00', '0', '1', '教育部高等学校计算机类专业教学指导委员会', '全国大学生物联网设计竞赛组委会', 19000, 406, 30006, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (379, '全国大学生计算机系统能力大赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生计算机系统能力大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-21 23:59:59', '2026-12-17 08:00:00', '2026-12-19 18:00:00', '0', '1', '教育部高等学校计算机类专业教学指导委员会', '全国大学生计算机系统能力大赛组委会', 21000, 543, 30983, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (380, '全国大学生计算机博弈大赛', '05', 'IT/计算机类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生计算机博弈大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-22 23:59:59', '2026-08-18 08:00:00', '2026-08-20 18:00:00', '0', '1', '中国人工智能学会', '全国大学生计算机博弈大赛组委会', 3000, 680, 31960, '[\"IT/计算机类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (381, '全国大学生数字取证竞赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生数字取证竞赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-23 23:59:59', '2026-09-19 08:00:00', '2026-09-21 18:00:00', '0', '1', '中国电子学会', '全国大学生数字取证竞赛组委会', 5000, 819, 32937, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (382, '华为ICT大赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>华为ICT大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-24 23:59:59', '2026-10-20 08:00:00', '2026-10-22 18:00:00', '0', '1', '华为技术有限公司', '华为ICT大赛组委会', 7000, 954, 33914, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (383, '百度之星程序设计大赛', '05', 'IT/计算机类', '1', '4', '<p><strong>赛事简介：</strong>百度之星程序设计大赛面向高校学生开展，侧重IT/计算机类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-25 23:59:59', '2026-11-20 08:00:00', '2026-11-23 18:00:00', '0', '1', '百度公司', '百度之星程序设计大赛组委会', 9000, 1091, 34891, '[\"IT/计算机类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (384, '美国大学生数学建模竞赛MCM/ICM', '06', '理工/数学类', '1', '5', '<p><strong>赛事简介：</strong>美国大学生数学建模竞赛MCM/ICM面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-12 23:59:59', '2026-12-10 08:00:00', '2026-12-12 18:00:00', '0', '1', '美国数学及其应用联合会', '美国大学生数学建模竞赛MCM/ICM组委会', 11000, 1228, 35868, '[\"理工/数学类\",\"个人赛\",\"国际赛事\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (385, 'MathorCup高校数学建模挑战赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>MathorCup高校数学建模挑战赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-13 23:59:59', '2026-08-11 08:00:00', '2026-08-13 18:00:00', '0', '1', '中国优选法统筹法与经济数学研究会', 'MathorCup高校数学建模挑战赛组委会', 13000, 1365, 36845, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (386, '华数杯全国大学生数学建模竞赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>华数杯全国大学生数学建模竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-14 23:59:59', '2026-09-12 08:00:00', '2026-09-14 18:00:00', '0', '1', '华数杯全国大学生数学建模竞赛组委会', '华数杯全国大学生数学建模竞赛组委会', 15000, 1502, 37822, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (387, '泰迪杯数据挖掘挑战赛', '06', '理工/数学类', '1', '4', '<p><strong>赛事简介：</strong>泰迪杯数据挖掘挑战赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-15 23:59:59', '2026-10-13 08:00:00', '2026-10-15 18:00:00', '0', '1', '泰迪杯数据挖掘挑战赛组委会', '泰迪杯数据挖掘挑战赛组委会', 17000, 1639, 38799, '[\"理工/数学类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (388, '深圳杯数学建模挑战赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>深圳杯数学建模挑战赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-16 23:59:59', '2026-11-14 08:00:00', '2026-11-16 18:00:00', '0', '1', '中国工业与应用数学学会', '深圳杯数学建模挑战赛组委会', 19000, 1776, 39776, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (389, '全国大学生数学竞赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生数学竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-17 23:59:59', '2026-12-15 08:00:00', '2026-12-17 18:00:00', '0', '1', '中国数学会', '全国大学生数学竞赛组委会', 21000, 1913, 40753, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (390, '全国大学生数据分析大赛', '06', '理工/数学类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生数据分析大赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-18 23:59:59', '2026-08-16 08:00:00', '2026-08-18 18:00:00', '0', '1', '全国大学生数据分析大赛组委会', '全国大学生数据分析大赛组委会', 3000, 2052, 41730, '[\"理工/数学类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (391, '全国大学生物理学术竞赛CUPT', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生物理学术竞赛CUPT面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-19 23:59:59', '2026-09-17 08:00:00', '2026-09-19 18:00:00', '0', '1', '全国大学生物理学术竞赛委员会', '全国大学生物理学术竞赛CUPT组委会', 5000, 2187, 42707, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (392, '全国大学生电工数学建模竞赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生电工数学建模竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-20 23:59:59', '2026-10-18 08:00:00', '2026-10-20 18:00:00', '0', '1', '中国电机工程学会', '全国大学生电工数学建模竞赛组委会', 7000, 2324, 43684, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (393, '全国大学生化工实验大赛', '06', '理工/数学类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生化工实验大赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-21 23:59:59', '2026-11-19 08:00:00', '2026-11-21 18:00:00', '0', '1', '中国化工教育协会', '全国大学生化工实验大赛组委会', 9000, 2461, 44661, '[\"理工/数学类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (394, '全国大学生材料综合技能大赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生材料综合技能大赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-22 23:59:59', '2026-12-20 08:00:00', '2026-12-22 18:00:00', '0', '1', '教育部高等学校材料类专业教学指导委员会', '全国大学生材料综合技能大赛组委会', 11000, 2598, 45638, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (395, '全国大学生地球物理知识竞赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生地球物理知识竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-05-01 09:00:00', '2026-07-23 23:59:59', '2026-08-20 08:00:00', '2026-08-23 18:00:00', '0', '1', '中国地球物理学会', '全国大学生地球物理知识竞赛组委会', 13000, 135, 46615, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (396, '全国大学生基础医学创新研究暨实验设计论坛', '06', '理工/数学类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生基础医学创新研究暨实验设计论坛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-06-01 09:00:00', '2026-08-24 23:59:59', '2026-09-10 08:00:00', '2026-09-12 18:00:00', '0', '1', '高等学校国家级实验教学示范中心联席会', '全国大学生基础医学创新研究暨实验设计论坛组委会', 15000, 273, 47592, '[\"理工/数学类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (397, '全国大学生生物医学工程创新设计竞赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生生物医学工程创新设计竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-07-01 09:00:00', '2026-09-25 23:59:59', '2026-10-11 08:00:00', '2026-10-13 18:00:00', '0', '1', '中国生物医学工程学会', '全国大学生生物医学工程创新设计竞赛组委会', 17000, 409, 48569, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (398, '全国大学生环境资源模拟法庭大赛', '06', '理工/数学类', '2', '4', '<p><strong>赛事简介：</strong>全国大学生环境资源模拟法庭大赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以团队协作、作品提交或现场答辩为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-08-01 09:00:00', '2026-10-12 23:59:59', '2026-11-12 08:00:00', '2026-11-14 18:00:00', '0', '1', '全国大学生环境资源模拟法庭大赛组委会', '全国大学生环境资源模拟法庭大赛组委会', 19000, 546, 49546, '[\"理工/数学类\",\"团队赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (399, '全国大学生农业建筑环境与能源工程相关专业创新创业竞赛', '06', '理工/数学类', '1', '4', '<p><strong>赛事简介：</strong>全国大学生农业建筑环境与能源工程相关专业创新创业竞赛面向高校学生开展，侧重理工/数学类相关知识、实践能力与综合素养。</p><p><strong>组织方式：</strong>以个人报名、在线或现场竞技为主，具体赛道与资格以当届官方通知为准。</p><p><strong>数据提示：</strong>本条报名时间为 InnoTrack 演示排期，请参赛前访问主办方渠道核验。</p>', '2026-09-01 09:00:00', '2026-11-13 23:59:59', '2026-12-13 08:00:00', '2026-12-15 18:00:00', '0', '1', '中国农业工程学会', '全国大学生农业建筑环境与能源工程相关专业创新创业竞赛组委会', 21000, 683, 2523, '[\"理工/数学类\",\"个人赛\",\"国家级\"]', '0', 'admin', '2026-06-20 12:00:00', '', NULL);
INSERT INTO `competition` VALUES (400, 'test-competition-001-?????????', '06', '????', '2', '4', 'test-modified', '2026-06-01 00:00:00', '2026-07-28 23:59:59', '2026-08-01 00:00:00', '2026-09-01 23:59:59', '0', '1', 'test org', 'test host', 100, 2, 0, 'test', '0', 'admin', '2026-06-28 14:13:18', 'admin', '2026-06-28 20:23:52');
INSERT INTO `competition` VALUES (401, 'concurrent-test-1a', '06', '', '1', '4', 'concurrent test', '2026-06-01 00:00:00', '2026-12-31 23:59:59', '2027-01-01 00:00:00', '2027-03-01 23:59:59', '0', '1', 'test', 'test', 100, 2, 0, '', '0', 'admin', '2026-06-28 21:14:44', '', '2026-06-28 21:14:57');
INSERT INTO `competition` VALUES (402, 'concurrent-test-1b', '06', '', '1', '4', 'idempotency test', '2026-06-01 00:00:00', '2026-12-31 23:59:59', '2027-01-01 00:00:00', '2027-03-01 23:59:59', '0', '1', 'test', 'test', 100, 1, 0, '', '0', 'admin', '2026-06-28 21:15:25', '', '2026-06-28 21:15:25');
INSERT INTO `competition` VALUES (403, 'concurrent-test-1c', '06', '', '1', '4', 'capacity test max=1', '2026-06-01 00:00:00', '2026-12-31 23:59:59', '2027-01-01 00:00:00', '2027-03-01 23:59:59', '0', '1', 'test', 'test', 1, 1, 0, '', '0', 'admin', '2026-06-28 21:15:47', '', '2026-06-28 21:15:47');
INSERT INTO `competition` VALUES (404, 'concurrent-test-1d', '06', '', '1', '4', 'deadline test - past', '2024-12-01 00:00:00', '2025-01-01 23:59:59', '2025-01-15 00:00:00', '2025-03-01 23:59:59', '0', '1', 'test', 'test', 100, 0, 0, '', '0', 'admin', '2026-06-28 21:16:08', '', '2026-06-28 21:16:08');
INSERT INTO `competition` VALUES (405, 'ConcurrentJoinX_', '', '', '1', '', '+', NULL, NULL, '2026-06-29 21:21:55', '2026-07-28 21:21:55', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:55', '', NULL);
INSERT INTO `competition` VALUES (406, 'ConcurrentCDX_', '', '', '1', '', '+', NULL, NULL, '2026-06-29 21:21:55', '2026-07-28 21:21:55', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:55', '', NULL);
INSERT INTO `competition` VALUES (407, 'InviteCompX_', '', '', '1', '', '+', NULL, NULL, '2026-06-29 21:21:55', '2026-07-28 21:21:55', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:55', '', NULL);
INSERT INTO `competition` VALUES (408, 'StateMachineDraftX_', '', '', '1', '', '+', NULL, NULL, '2026-06-29 21:21:55', '2026-07-28 21:21:55', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:55', '', NULL);
INSERT INTO `competition` VALUES (409, '\' OR 1=1 --', '', '', '1', '', 'SQLi test', NULL, NULL, '2026-06-29 21:21:56', '2026-07-28 21:21:56', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:56', '', NULL);
INSERT INTO `competition` VALUES (410, 'XSS_TestX_', '', '', '1', '', '+', NULL, NULL, '2026-06-29 21:21:56', '2026-07-28 21:21:56', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:21:56', '', NULL);
INSERT INTO `competition` VALUES (411, 'ConcurrentJoin_212355', '', '', '1', '', 'Test concurrent join', NULL, NULL, '2026-06-29 21:23:55', '2026-07-28 21:23:55', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:55', '', '2026-06-28 21:23:55');
INSERT INTO `competition` VALUES (412, 'ConcurrentCD_212355', '', '', '1', '', 'Test concurrent CD', NULL, NULL, '2026-06-29 21:23:55', '2026-07-28 21:23:55', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:55', '', '2026-06-28 21:23:55');
INSERT INTO `competition` VALUES (413, 'InviteRace_212356', '', '', '1', '', 'Test invite race', NULL, NULL, '2026-06-29 21:23:56', '2026-07-28 21:23:56', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:56', '', '2026-06-28 21:23:56');
INSERT INTO `competition` VALUES (414, 'StateDraft_212357', '', '', '1', '', 'Draft state test', NULL, NULL, '2026-06-29 21:23:57', '2026-07-28 21:23:57', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:57', '', NULL);
INSERT INTO `competition` VALUES (415, '\'; DROP TABLE competition; --', '', '', '1', '', 'SQLi test', NULL, NULL, '2026-06-29 21:23:57', '2026-07-28 21:23:57', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:57', '', NULL);
INSERT INTO `competition` VALUES (416, 'XSS_StoreTest_212357', '', '', '1', '', '<script>alert(\'xss\')</script>', NULL, NULL, '2026-06-29 21:23:57', '2026-07-28 21:23:57', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:23:57', '', NULL);
INSERT INTO `competition` VALUES (417, 'ConcurrentJoin_212528', '', '', '1', '', 'Test concurrent join', '2026-06-28 21:20:28', '2026-07-28 21:25:28', '2026-06-28 21:20:28', '2026-07-28 21:25:28', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:28', '', '2026-06-28 21:25:28');
INSERT INTO `competition` VALUES (418, 'ConcurrentCD_212529', '', '', '1', '', 'Test CD', '2026-06-28 21:20:29', '2026-07-28 21:25:29', '2026-06-28 21:20:29', '2026-07-28 21:25:29', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:29', '', '2026-06-28 21:25:29');
INSERT INTO `competition` VALUES (419, 'InviteRace_212530', '', '', '1', '', 'Test invite race', '2026-06-28 21:20:30', '2026-07-28 21:25:30', '2026-06-28 21:20:30', '2026-07-28 21:25:30', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:30', '', '2026-06-28 21:25:30');
INSERT INTO `competition` VALUES (420, 'StateDraft_212530', '', '', '1', '', 'draft_test', '2026-06-28 21:20:30', '2026-07-28 21:25:30', '2026-06-28 21:20:30', '2026-07-28 21:25:30', '0', '3', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:30', '', '2026-06-28 21:25:30');
INSERT INTO `competition` VALUES (421, '\'; DROP TABLE competition; --', '', '', '1', '', 'sqli_test', '2026-06-28 21:20:31', '2026-07-28 21:25:31', '2026-06-28 21:20:31', '2026-07-28 21:25:31', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:31', '', NULL);
INSERT INTO `competition` VALUES (422, 'XSS_Store_212530', '', '', '1', '', '<script>alert(\'xss\')</script>', '2026-06-28 21:20:31', '2026-07-28 21:25:31', '2026-06-28 21:20:31', '2026-07-28 21:25:31', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:25:31', '', NULL);
INSERT INTO `competition` VALUES (423, 'CJoin_212727', '', '', '1', '', 'Concurrent join test', '2026-06-28 21:22:27', '2026-07-28 21:27:27', '2026-06-28 21:22:27', '2026-07-28 21:27:27', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:27', '', '2026-06-28 21:27:27');
INSERT INTO `competition` VALUES (424, 'CCD_212727', '', '', '1', '', 'Create+disband test', '2026-06-28 21:22:27', '2026-07-28 21:27:27', '2026-06-28 21:22:27', '2026-07-28 21:27:27', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:27', '', '2026-06-28 21:27:28');
INSERT INTO `competition` VALUES (425, 'CRace_212728', '', '', '1', '', 'Invite race test', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:28', '', '2026-06-28 21:27:28');
INSERT INTO `competition` VALUES (426, 'StateDraft_212728', '', '', '1', '', 'draft', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '0', '3', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:28', '', '2026-06-28 21:27:28');
INSERT INTO `competition` VALUES (427, '\'; DROP TABLE competition; --', '', '', '1', '', 'sqli', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:28', '', NULL);
INSERT INTO `competition` VALUES (428, 'XSS_212728', '', '', '1', '', '<script>alert(\'xss\')</script>', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '2026-06-28 21:22:28', '2026-07-28 21:27:28', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:28', '', NULL);
INSERT INTO `competition` VALUES (429, 'TXSS_212729', '', '', '1', '', 'Team XSS test', '2026-06-28 21:22:29', '2026-07-28 21:27:29', '2026-06-28 21:22:29', '2026-07-28 21:27:29', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:27:29', '', '2026-06-28 21:27:29');
INSERT INTO `competition` VALUES (430, 'CJoin_212911', '', '', '2', '', 'Concurrent join test', '2026-06-28 21:24:11', '2026-07-28 21:29:11', '2026-06-28 21:24:11', '2026-07-28 21:29:11', '0', '1', '', '', 100, 0, 0, '', '0', 'admin', '2026-06-28 21:29:11', '', '2026-06-28 21:29:11');
INSERT INTO `competition` VALUES (431, 'CCD_212912', '', '', '2', '', 'Create+disband test', '2026-06-28 21:24:12', '2026-07-28 21:29:12', '2026-06-28 21:24:12', '2026-07-28 21:29:12', '0', '1', '', '', 100, 1, 0, '', '0', 'admin', '2026-06-28 21:29:12', '', '2026-06-28 21:29:12');
INSERT INTO `competition` VALUES (432, 'CRace_212913', '', '', '2', '', 'Invite race test', '2026-06-28 21:24:13', '2026-07-28 21:29:13', '2026-06-28 21:24:13', '2026-07-28 21:29:13', '0', '1', '', '', 100, 1, 0, '', '0', 'admin', '2026-06-28 21:29:13', '', '2026-06-28 21:29:13');
INSERT INTO `competition` VALUES (433, 'StateDraft_212914', '', '', '2', '', 'draft', '2026-06-28 21:24:14', '2026-07-28 21:29:14', '2026-06-28 21:24:14', '2026-07-28 21:29:14', '0', '3', '', '', 100, 0, 0, '', '0', 'admin', '2026-06-28 21:29:14', '', '2026-06-28 21:29:15');
INSERT INTO `competition` VALUES (434, '\'; DROP TABLE competition; --', '', '', '1', '', 'sqli', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:29:15', '', NULL);
INSERT INTO `competition` VALUES (435, 'XSS_212914', '', '', '1', '', '<script>alert(\'xss\')</script>', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:29:15', '', NULL);
INSERT INTO `competition` VALUES (436, 'TXSS_212915', '', '', '2', '', 'Team XSS test', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '2026-06-28 21:24:15', '2026-07-28 21:29:15', '0', '1', '', '', 100, 1, 0, '', '0', 'admin', '2026-06-28 21:29:15', '', '2026-06-28 21:29:15');
INSERT INTO `competition` VALUES (437, '????????????', '', '', '1', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-28 21:32:49', '', NULL);
INSERT INTO `competition` VALUES (438, 'AuditTest_213338', '', '', '1', '', NULL, '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '0', '', '', 100, 0, 0, '', '0', 'admin', '2026-06-28 21:33:38', '', NULL);
INSERT INTO `competition` VALUES (439, 'AuditTest_213423', '', '', '1', '', NULL, '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 100, 2, 0, '', '0', 'admin', '2026-06-28 21:34:23', '', '2026-06-28 21:34:24');
INSERT INTO `competition` VALUES (440, 'draft-test-5a', '', '', '2', '', '??????', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 11:15:53', '', '2026-06-29 11:16:22');
INSERT INTO `competition` VALUES (441, 'draft-guard-retest', '', '', '2', '', 'test draft team block', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 13:30:00', '', '2026-06-29 13:30:25');
INSERT INTO `competition` VALUES (442, 'notif-retest-01', '', '', '1', '', 'notification test', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 13:30:22', '', '2026-06-29 13:30:36');
INSERT INTO `competition` VALUES (443, 'maxmembers-retest', '', '', '2', '', 'test maxMembers', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 13:31:01', '', '2026-06-29 13:31:15');
INSERT INTO `competition` VALUES (444, 'xss-retest', '', '', '1', '', 'alert(\'xss\')', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 13:34:06', '', '2026-06-29 14:05:01');
INSERT INTO `competition` VALUES (445, 'team-xss-retest', '', '', '2', '', 'team xss test', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '1', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 13:34:35', '', '2026-06-29 13:34:40');
INSERT INTO `competition` VALUES (446, 'xss-verify-test-2', '', '', '1', '', '<script>alert(\'xss\')</script>', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '2026-01-01 00:00:00', '2026-12-31 23:59:59', '0', '0', '', '', 0, 0, 0, '', '0', 'admin', '2026-06-29 14:05:02', '', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '竞赛报名表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_apply
-- ----------------------------
INSERT INTO `competition_apply` VALUES (1, 100, 3, 'student01', '李四同学', '创新团队', '李四同学,张三同学,王五同学', '2026-05-29 16:02:16', '1', NULL, '', NULL, '2', '', NULL, '', '2026-06-03 13:09:02');
INSERT INTO `competition_apply` VALUES (2, 100, 5, 'student02', '赵同学', '智慧队', '赵同学,钱同学,孙同学', '2026-05-29 16:02:16', '1', '2026-06-20 17:28:06', NULL, 'admin', '0', '', NULL, '', '2026-06-20 17:28:06');
INSERT INTO `competition_apply` VALUES (3, 101, 3, 'student01', '李四同学', '代码先锋队', '李四同学', '2026-05-29 16:02:16', '1', NULL, '', NULL, '2', '', NULL, '', '2026-06-03 13:09:04');
INSERT INTO `competition_apply` VALUES (4, 201, 3, 'student01', 'yu', '', '', '2026-06-02 22:01:48', '0', NULL, '', NULL, '2', 'student01', '2026-06-02 22:01:48', '', '2026-06-03 13:09:13');
INSERT INTO `competition_apply` VALUES (5, 201, 3, 'student01', 'yu', '', '', '2026-06-03 13:09:20', '0', NULL, '', NULL, '2', 'student01', '2026-06-03 13:09:20', '', '2026-06-04 02:05:07');
INSERT INTO `competition_apply` VALUES (6, 200, 3, 'student01', 'yu', '', '', '2026-06-03 13:50:37', '0', NULL, '', NULL, '2', 'student01', '2026-06-03 13:50:37', '', '2026-06-04 02:04:51');
INSERT INTO `competition_apply` VALUES (7, 201, 3, 'student01', 'yu', '', '', '2026-06-04 02:05:20', '1', '2026-06-04 02:14:47', NULL, 'admin', '0', 'student01', '2026-06-04 02:05:20', '', '2026-06-04 02:14:47');
INSERT INTO `competition_apply` VALUES (8, 400, 3, 'student01', 'yu', '', '', '2026-06-28 15:01:15', '1', '2026-06-28 15:01:15', NULL, 'admin', '0', 'student01', '2026-06-28 15:01:15', '', '2026-06-28 15:01:15');
INSERT INTO `competition_apply` VALUES (9, 400, 5, 'student02', '赵同学', '', '', '2026-06-28 15:06:52', '1', '2026-06-28 18:58:42', NULL, 'admin', '0', 'student02', '2026-06-28 15:06:52', '', '2026-06-28 18:58:42');
INSERT INTO `competition_apply` VALUES (10, 396, 5, 'student02', '赵同学', '', '', '2026-06-28 19:01:33', '1', '2026-06-28 19:02:00', NULL, 'admin', '0', 'student02', '2026-06-28 19:01:33', '', '2026-06-28 19:02:00');
INSERT INTO `competition_apply` VALUES (11, 396, 3, 'student01', 'yu', '', '', '2026-06-28 19:45:15', '1', '2026-06-28 19:45:25', NULL, 'admin', '2', 'student01', '2026-06-28 19:45:15', '', '2026-06-28 21:15:04');
INSERT INTO `competition_apply` VALUES (12, 390, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (13, 390, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (14, 381, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (15, 381, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (16, 375, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (17, 375, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (18, 371, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (19, 371, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (20, 370, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (21, 370, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (22, 366, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:46', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:46', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (23, 366, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:47', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:47', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (24, 365, 3, 'student01', 'yu', '', '', '2026-06-28 21:13:47', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:13:47', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (25, 365, 5, 'student02', '赵同学', '', '', '2026-06-28 21:13:47', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:13:47', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (26, 306, 5, 'student02', '赵同学', '', '', '2026-06-28 21:14:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:14:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (27, 300, 5, 'student02', '赵同学', '', '', '2026-06-28 21:14:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:14:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (28, 201, 5, 'student02', '赵同学', '', '', '2026-06-28 21:14:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:14:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (29, 200, 5, 'student02', '赵同学', '', '', '2026-06-28 21:14:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:14:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (30, 101, 5, 'student02', '赵同学', '', '', '2026-06-28 21:14:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:14:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (31, 401, 3, 'student01', 'yu', '', '', '2026-06-28 21:15:09', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:15:09', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (32, 401, 5, 'student02', '赵同学', '', '', '2026-06-28 21:15:09', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student02', '2026-06-28 21:15:09', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (33, 402, 3, 'student01', 'yu', '', '', '2026-06-28 21:15:32', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:15:32', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (34, 403, 3, 'student01', 'yu', '', '', '2026-06-28 21:15:53', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:15:53', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (35, 417, 3, 'student01', 'yu', '', '', '2026-06-28 21:25:28', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:25:28', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (36, 418, 3, 'student01', 'yu', '', '', '2026-06-28 21:25:29', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:25:29', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (37, 419, 3, 'student01', 'yu', '', '', '2026-06-28 21:25:30', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:25:30', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (38, 420, 3, 'student01', 'yu', '', '', '2026-06-28 21:25:30', '1', '2026-06-28 21:36:42', '6c-batch-audit', 'admin', '0', 'student01', '2026-06-28 21:25:30', '', '2026-06-28 21:36:42');
INSERT INTO `competition_apply` VALUES (39, 439, 3, 'student01', 'yu', '', '', '2026-06-28 21:34:24', '1', '2026-06-28 21:35:58', '3a-duplicate-test', 'admin', '0', 'student01', '2026-06-28 21:34:24', '', '2026-06-28 21:35:58');
INSERT INTO `competition_apply` VALUES (40, 439, 5, 'student02', '赵同学', '', '', '2026-06-28 21:34:24', '1', '2026-06-28 21:35:59', '3b-pass', 'admin', '0', 'student02', '2026-06-28 21:34:24', '', '2026-06-28 21:35:59');
INSERT INTO `competition_apply` VALUES (41, 436, 3, 'student01', 'yu', '', '', '2026-06-28 21:48:09', '1', '2026-06-28 21:48:29', '8b-test-1', 'admin', '0', 'student01', '2026-06-28 21:48:09', '', '2026-06-28 21:48:29');
INSERT INTO `competition_apply` VALUES (42, 432, 3, 'student01', 'yu', '', '', '2026-06-28 21:48:53', '1', '2026-06-28 21:48:54', '8b-test-2-mq-down', 'admin', '0', 'student01', '2026-06-28 21:48:53', '', '2026-06-28 21:48:54');
INSERT INTO `competition_apply` VALUES (43, 431, 3, 'student01', 'yu', '', '', '2026-06-28 21:49:23', '1', '2026-06-28 21:49:24', '8b-test-3-recovered', 'admin', '0', 'student01', '2026-06-28 21:49:23', '', '2026-06-28 21:49:24');
INSERT INTO `competition_apply` VALUES (44, 440, 3, 'student01', 'yu', '', '', '2026-06-29 11:16:28', '0', NULL, '', NULL, '0', 'student01', '2026-06-29 11:16:28', '', NULL);
INSERT INTO `competition_apply` VALUES (45, 441, 3, 'student01', 'yu', '', '', '2026-06-29 13:30:31', '0', NULL, '', NULL, '0', 'student01', '2026-06-29 13:30:31', '', NULL);
INSERT INTO `competition_apply` VALUES (46, 442, 3, 'student01', 'yu', '', '', '2026-06-29 13:30:53', '1', '2026-06-29 13:31:11', NULL, 'admin', '0', 'student01', '2026-06-29 13:30:53', '', '2026-06-29 13:31:11');
INSERT INTO `competition_apply` VALUES (47, 443, 3, 'student01', 'yu', '', '', '2026-06-29 13:31:15', '0', NULL, '', NULL, '0', 'student01', '2026-06-29 13:31:15', '', NULL);
INSERT INTO `competition_apply` VALUES (48, 445, 3, 'student01', 'yu', '', '', '2026-06-29 13:34:48', '0', NULL, '', NULL, '0', 'student01', '2026-06-29 13:34:48', '', NULL);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核审计日志表' ROW_FORMAT = DYNAMIC;

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
  `reject_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '驳回原因',
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
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学长学姐经验帖表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_experience
-- ----------------------------
INSERT INTO `competition_experience` VALUES (1, '无', 'yu', '避坑指南', '<p>避开某学校</p>', 0, '1', NULL, 'teacher01', '2026-06-04 00:44:17', '0', 'student01', '2026-06-04 00:43:48', '', NULL);
INSERT INTO `competition_experience` VALUES (100, '从零到国奖：一份能执行的十二周备赛计划', '林知夏', '备赛心得', '<h3>核心经验</h3><p>把目标拆成规则研读、能力补齐、模拟训练和材料打磨四个阶段。前两周只做赛制与评分项分析；中间六周每周完成一次限时训练；最后四周固定版本、交叉检查并预留提交缓冲。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 1200, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-01 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (101, '第一次组队别只看技能：队友筛选的五个问题', '周予安', '团队协作', '<h3>核心经验</h3><p>组队前确认每周可投入时间、冲突处理方式、目标奖项、擅长模块和退出机制。技能互补重要，但稳定交付、及时沟通与愿意接受评审意见更重要。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 1637, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-02 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (102, '数学建模三天怎么分工：建模、代码与论文并行法', '陈砚', '建模方法', '<h3>核心经验</h3><p>开题后先共同确定问题边界，再由三人分别维护模型假设、实验代码和论文主线。每六小时同步一次结论与图表，禁止代码结果和论文口径分叉。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 2074, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-03 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (103, '答辩只有五分钟：让评委迅速看懂项目价值', '许嘉禾', '答辩技巧', '<h3>核心经验</h3><p>第一页讲清真实问题，第二页给出核心方案，第三页展示可验证结果。删掉长背景和技术名词堆砌，用一条证据链回答为什么做、怎么做、效果如何。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 2511, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-04 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (104, '创新创业项目如何找到真实需求而不是自嗨', '沈星遥', '创新创业', '<h3>核心经验</h3><p>先访谈十位目标用户，记录他们当前怎么解决、付出了什么成本、为何仍不满意。只有重复出现且愿意付出时间或金钱的问题，才值得进入产品方案。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 2948, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-05 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (105, '比赛材料版本管理：再也不提交错文件', '顾明川', '工具方法', '<h3>核心经验</h3><p>建立统一目录、命名规则和冻结时间。所有提交文件经过负责人汇总，使用日期与版本号命名；终稿生成校验清单，至少由两位成员分别下载回看。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 3385, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-06 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (106, '程序设计竞赛复盘模板：从罚时到知识缺口', '苏念', '程序设计', '<h3>核心经验</h3><p>赛后不要只补通过代码，要记录读题误差、算法识别、实现耗时和调试路径。把每次失败归入知识、策略、编码或协作四类，下一周安排针对训练。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 3822, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-07 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (107, '英语演讲比赛备赛：内容、语音与临场的配比', '唐一诺', '外语备赛', '<h3>核心经验</h3><p>内容占一半精力，先让论点可信且有个人观察；语音训练解决重音和停顿；临场训练用随机题与计时器，练习在忘词时自然改述。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 4259, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-08 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (108, '做问卷最常见的六个坑及修正方式', '叶清扬', '调研方法', '<h3>核心经验</h3><p>避免诱导问题、双重问题和样本只来自朋友圈。预测试后再正式发放，记录无效样本规则，并在报告中说明抽样边界，不用漂亮数字掩盖偏差。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 4696, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-09 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (109, '路演PPT减法指南：二十页压到十页', '陆景行', '材料打磨', '<h3>核心经验</h3><p>每页只承担一个结论，标题直接写观点。保留用户痛点、解决方案、核心壁垒、验证数据、商业模式和团队能力，其余内容放入备份页。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 5133, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-10 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (110, '硬件竞赛联调血泪史：先做最小闭环', '江晚晴', '工程实践', '<h3>核心经验</h3><p>不要等所有模块完成后再联调。先让传感、控制、执行和反馈跑通最小闭环，再逐个替换为正式模块；每次只改一个变量，并保留可回退版本。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 5570, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-11 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (111, '数据竞赛如何防止验证集泄漏', '谢云舟', '数据分析', '<h3>核心经验</h3><p>任何来自全量数据的统计量都可能泄漏。划分训练验证集后再做填补、编码和特征选择；交叉验证流水线要完整包住预处理，并保留独立复核脚本。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 6007, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-12 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (112, '跨专业团队沟通：把术语翻译成决策', '宋时雨', '团队协作', '<h3>核心经验</h3><p>讨论时用目标、输入、输出和验收标准描述任务。算法同学不只说模型指标，设计同学不只说视觉感受，所有结论都落到用户价值与交付风险。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 6444, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-13 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (113, '如何给指导老师开一次高效周会', '温书言', '时间管理', '<h3>核心经验</h3><p>会前一天发一页进展摘要，包括完成项、数据证据、当前阻塞和需要老师决策的问题。会上只讨论分歧，会后十分钟内确认负责人和截止时间。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 6881, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-14 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (114, '从校赛到国赛：每一轮应该升级什么', '程屿', '晋级策略', '<h3>核心经验</h3><p>校赛验证完整性，省赛强化差异化，国赛突出证据与落地。不要每轮推翻重做，而应根据评审反馈建立问题清单，按影响和成本排序迭代。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 7318, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-15 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (115, '作品集怎么呈现过程：失败实验也有价值', '乔木', '作品呈现', '<h3>核心经验</h3><p>评委不仅看最终效果，也看团队如何做选择。保留关键草图、对比实验和失败原因，用前后对照说明一次重要迭代带来了什么改善。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 7755, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-16 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (116, '赛前七天检查清单：证据、版权与合规', '余声', '避坑指南', '<h3>核心经验</h3><p>逐项检查数据授权、图片字体版权、引用来源、成员资格和匿名要求。确认演示设备、离线备份、文件格式与网络替代方案，避免非能力因素丢分。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 8192, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-17 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (117, '个人赛时间管理：用三轮扫描代替死磕', '白榆', '时间管理', '<h3>核心经验</h3><p>第一轮快速拿下确定题，第二轮集中处理中等难度，第三轮攻克高价值难题并检查。给每题设置止损时间，卡住时标记信息后先向前走。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 8629, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-18 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (118, '如何读懂竞赛评分表并反推任务优先级', '夏栀', '备赛心得', '<h3>核心经验</h3><p>把每个评分项改写成可观察证据，例如创新性对应竞品差异与专利检索，应用价值对应用户验证与成本测算。分值高但证据弱的部分优先补齐。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 9066, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-01 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (119, '比赛结束后怎么复盘：一小时团队会议框架', '孟川', '复盘方法', '<h3>核心经验</h3><p>按事实、原因、行动三个层次展开。先还原时间线，再讨论哪些决策有效或失误，最后形成不超过五条可执行改进，并指定负责人和验证日期。</p><h3>落地建议</h3><p>先选择一项在本周实践，并用可检查的产出验证；不要一次增加太多流程。每次模拟或评审后补充记录，让方法逐渐适合自己的比赛与团队。</p><blockquote>本文为平台演示经验内容，请结合具体赛事规则调整。</blockquote>', 9503, '1', NULL, 'admin', '2026-06-20 12:30:00', '0', 'student_seed', '2026-06-02 20:00:00', '', NULL);
INSERT INTO `competition_experience` VALUES (120, '????????-001', 'yu', '', '???????????????????????????...', 0, '2', NULL, 'admin', '2026-06-28 15:06:44', '0', 'student01', '2026-06-28 15:05:41', '', '2026-06-28 15:06:44');
INSERT INTO `competition_experience` VALUES (121, 'NotifTestExperience', 'yu', '', 'Testing reject notification content here. Testing reject notification content here. Testing reject notification content here. Testing reject notification content here.', 0, '0', NULL, '', NULL, '0', 'student01', '2026-06-28 19:15:52', '', NULL);
INSERT INTO `competition_experience` VALUES (122, 'NotifTestExperience', 'yu', '', 'Testing reject notification content here. Testing reject notification content here. Testing reject notification content here. Testing reject notification content here.', 0, '2', NULL, 'admin', '2026-06-28 19:16:47', '0', 'student01', '2026-06-28 19:16:47', '', '2026-06-28 19:16:47');
INSERT INTO `competition_experience` VALUES (123, '???????', 'yu', '', '???????????', 0, '2', NULL, 'admin', '2026-06-28 19:44:08', '0', 'student01', '2026-06-28 19:43:58', '', '2026-06-28 19:44:08');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '竞赛成绩记录表（存证系统）' ROW_FORMAT = DYNAMIC;

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
  `reject_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '驳回原因',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1222 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '往届项目复盘表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of competition_retrospect
-- ----------------------------
INSERT INTO `competition_retrospect` VALUES (1, NULL, '吹牛大赛', '我将进入英伟达', '国家级', 'Yu', '2030', '<p>吹牛这块</p>', '1', NULL, 'teacher01', '2026-06-04 00:44:14', '0', 'student01', '2026-06-04 00:43:33', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1000, 100, '全国大学生数学建模竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生数学建模竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1001, 100, '全国大学生数学建模竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生数学建模竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1002, 101, '中国大学生计算机设计大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加中国大学生计算机设计大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1003, 101, '中国大学生计算机设计大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加中国大学生计算机设计大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1004, 102, '互联网+大学生创新创业大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加互联网+大学生创新创业大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1005, 102, '互联网+大学生创新创业大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加互联网+大学生创新创业大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1006, 103, '全国大学生电子设计竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国大学生电子设计竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1007, 103, '全国大学生电子设计竞赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国大学生电子设计竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1008, 200, '2026年全国大学生英语作文大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加2026年全国大学生英语作文大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1009, 200, '2026年全国大学生英语作文大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加2026年全国大学生英语作文大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1010, 201, '2026全国大学生麟创杯人工智能知识竞赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加2026全国大学生麟创杯人工智能知识竞赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1011, 201, '2026全国大学生麟创杯人工智能知识竞赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加2026全国大学生麟创杯人工智能知识竞赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1012, 202, '2026年第六届全国大学生技术创新创业大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加2026年第六届全国大学生技术创新创业大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1013, 202, '2026年第六届全国大学生技术创新创业大赛', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加2026年第六届全国大学生技术创新创业大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1014, 203, '2026年第十六届APMCM亚太地区大学生数学建模竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加2026年第十六届APMCM亚太地区大学生数学建模竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1015, 203, '2026年第十六届APMCM亚太地区大学生数学建模竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加2026年第十六届APMCM亚太地区大学生数学建模竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1016, 300, '全国大学生市场调查与分析大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国大学生市场调查与分析大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1017, 300, '全国大学生市场调查与分析大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国大学生市场调查与分析大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1018, 301, '全国大学生广告艺术大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生广告艺术大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1019, 301, '全国大学生广告艺术大赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生广告艺术大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1020, 302, '全国大学生物流设计大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加全国大学生物流设计大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1021, 302, '全国大学生物流设计大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加全国大学生物流设计大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1022, 303, '全国大学生结构设计竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国大学生结构设计竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1023, 303, '全国大学生结构设计竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国大学生结构设计竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1024, 304, '全国周培源大学生力学竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国周培源大学生力学竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1025, 304, '全国周培源大学生力学竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国周培源大学生力学竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1026, 305, '全国大学生化学实验创新设计大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国大学生化学实验创新设计大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1027, 305, '全国大学生化学实验创新设计大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国大学生化学实验创新设计大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1028, 306, '全国大学生物理实验竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加全国大学生物理实验竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1029, 306, '全国大学生物理实验竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加全国大学生物理实验竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1030, 307, '全国大学生测绘学科创新创业智能大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国大学生测绘学科创新创业智能大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1031, 307, '全国大学生测绘学科创新创业智能大赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国大学生测绘学科创新创业智能大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1032, 308, '全国大学生GIS应用技能大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国大学生GIS应用技能大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1033, 308, '全国大学生GIS应用技能大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国大学生GIS应用技能大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1034, 309, '全国大学生土地国情调查大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生土地国情调查大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1035, 309, '全国大学生土地国情调查大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生土地国情调查大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1036, 310, '全国大学生交通科技大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加全国大学生交通科技大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1037, 310, '全国大学生交通科技大赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加全国大学生交通科技大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1038, 311, '全国大学生先进成图技术与产品信息建模创新大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加全国大学生先进成图技术与产品信息建模创新大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1039, 311, '全国大学生先进成图技术与产品信息建模创新大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加全国大学生先进成图技术与产品信息建模创新大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1040, 312, '全国高校商业精英挑战赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国高校商业精英挑战赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1041, 312, '全国高校商业精英挑战赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国高校商业精英挑战赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1042, 313, '全国大学生人力资源管理综合能力竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生人力资源管理综合能力竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1043, 313, '全国大学生人力资源管理综合能力竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生人力资源管理综合能力竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1044, 314, '全国大学生工程管理创新创业竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加全国大学生工程管理创新创业竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1045, 314, '全国大学生工程管理创新创业竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加全国大学生工程管理创新创业竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1046, 315, '全国大学生统计建模大赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国大学生统计建模大赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1047, 315, '全国大学生统计建模大赛', '格物工坊——面向真实场景的跨学科研究与实践', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国大学生统计建模大赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1048, 316, '全国大学生生命科学竞赛', '知衡计划——基于多源证据的学科问题分析与验证', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生生命科学竞赛，围绕“基于多源证据的学科问题分析与验证”完成知衡计划——基于多源证据的学科问题分析与验证。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1049, 316, '全国大学生生命科学竞赛', '格物工坊——面向真实场景的跨学科研究与实践', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生生命科学竞赛，围绕“面向真实场景的跨学科研究与实践”完成格物工坊——面向真实场景的跨学科研究与实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1050, 317, '挑战杯全国大学生课外学术科技作品竞赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加挑战杯全国大学生课外学术科技作品竞赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1051, 317, '挑战杯全国大学生课外学术科技作品竞赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加挑战杯全国大学生课外学术科技作品竞赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1052, 318, '挑战杯中国大学生创业计划竞赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加挑战杯中国大学生创业计划竞赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1053, 318, '挑战杯中国大学生创业计划竞赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加挑战杯中国大学生创业计划竞赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1054, 319, '中国国际大学生创新大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加中国国际大学生创新大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1055, 319, '中国国际大学生创新大赛', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加中国国际大学生创新大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1056, 320, '全国大学生电子商务创新创意及创业挑战赛', '青禾行动——青年共创的校园服务创新方案', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国大学生电子商务创新创意及创业挑战赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1057, 320, '全国大学生电子商务创新创意及创业挑战赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国大学生电子商务创新创意及创业挑战赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1058, 321, '中国大学生服务外包创新创业大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加中国大学生服务外包创新创业大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1059, 321, '中国大学生服务外包创新创业大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加中国大学生服务外包创新创业大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1060, 322, 'iCAN大学生创新创业大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加iCAN大学生创新创业大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1061, 322, 'iCAN大学生创新创业大赛', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加iCAN大学生创新创业大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1062, 323, '全国大学生节能减排社会实践与科技竞赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加全国大学生节能减排社会实践与科技竞赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1063, 323, '全国大学生节能减排社会实践与科技竞赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加全国大学生节能减排社会实践与科技竞赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1064, 324, '全国大学生创新方法大赛', '青禾行动——青年共创的校园服务创新方案', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国大学生创新方法大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1065, 324, '全国大学生创新方法大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国大学生创新方法大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1066, 325, '全国大学生乡村振兴创新创业大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生乡村振兴创新创业大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1067, 325, '全国大学生乡村振兴创新创业大赛', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生乡村振兴创新创业大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1068, 326, '全国大学生文化创意设计大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加全国大学生文化创意设计大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1069, 326, '全国大学生文化创意设计大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加全国大学生文化创意设计大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1070, 327, '中国大学生机械工程创新创意大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加中国大学生机械工程创新创意大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1071, 327, '中国大学生机械工程创新创意大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加中国大学生机械工程创新创意大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1072, 328, '全国大学生工业设计大赛', '青禾行动——青年共创的校园服务创新方案', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生工业设计大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1073, 328, '全国大学生工业设计大赛', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生工业设计大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1074, 329, '全国大学生数字媒体科技作品及创意竞赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国大学生数字媒体科技作品及创意竞赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1075, 329, '全国大学生数字媒体科技作品及创意竞赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国大学生数字媒体科技作品及创意竞赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1076, 330, '两岸新锐设计竞赛华灿奖', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加两岸新锐设计竞赛华灿奖，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1077, 330, '两岸新锐设计竞赛华灿奖', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加两岸新锐设计竞赛华灿奖，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1078, 331, '米兰设计周中国高校设计学科师生优秀作品展', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加米兰设计周中国高校设计学科师生优秀作品展，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1079, 331, '米兰设计周中国高校设计学科师生优秀作品展', '微光引擎——面向社区需求的可持续创业项目', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加米兰设计周中国高校设计学科师生优秀作品展，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1080, 332, '未来设计师·全国高校数字艺术设计大赛', '青禾行动——青年共创的校园服务创新方案', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加未来设计师·全国高校数字艺术设计大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1081, 332, '未来设计师·全国高校数字艺术设计大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加未来设计师·全国高校数字艺术设计大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1082, 333, '全国大学生红色旅游创意策划大赛', '青禾行动——青年共创的校园服务创新方案', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生红色旅游创意策划大赛，围绕“青年共创的校园服务创新方案”完成青禾行动——青年共创的校园服务创新方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1083, 333, '全国大学生红色旅游创意策划大赛', '微光引擎——面向社区需求的可持续创业项目', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生红色旅游创意策划大赛，围绕“面向社区需求的可持续创业项目”完成微光引擎——面向社区需求的可持续创业项目。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1084, 334, '全国大学生机器人大赛ROBOCON', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加全国大学生机器人大赛ROBOCON，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1085, 334, '全国大学生机器人大赛ROBOCON', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加全国大学生机器人大赛ROBOCON，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1086, 335, 'RoboMaster全国大学生机器人大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加RoboMaster全国大学生机器人大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1087, 335, 'RoboMaster全国大学生机器人大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加RoboMaster全国大学生机器人大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1088, 336, '中国高校智能机器人创意大赛', '灵犀智造——模块化感知控制与工程实现', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加中国高校智能机器人创意大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1089, 336, '中国高校智能机器人创意大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加中国高校智能机器人创意大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1090, 337, '全国大学生智能汽车竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生智能汽车竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1091, 337, '全国大学生智能汽车竞赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生智能汽车竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1092, 338, '中国大学生工程实践与创新能力大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加中国大学生工程实践与创新能力大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1093, 338, '中国大学生工程实践与创新能力大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加中国大学生工程实践与创新能力大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1094, 339, '全国大学生机械创新设计大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国大学生机械创新设计大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1095, 339, '全国大学生机械创新设计大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国大学生机械创新设计大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1096, 340, '全国大学生过程装备实践与创新赛', '灵犀智造——模块化感知控制与工程实现', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生过程装备实践与创新赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1097, 340, '全国大学生过程装备实践与创新赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生过程装备实践与创新赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1098, 341, '全国大学生金相技能大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国大学生金相技能大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1099, 341, '全国大学生金相技能大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国大学生金相技能大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1100, 342, '全国大学生焊接创新大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加全国大学生焊接创新大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1101, 342, '全国大学生焊接创新大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加全国大学生焊接创新大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1102, 343, '全国大学生光电设计竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国大学生光电设计竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1103, 343, '全国大学生光电设计竞赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国大学生光电设计竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1104, 344, '全国大学生集成电路创新创业大赛', '灵犀智造——模块化感知控制与工程实现', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国大学生集成电路创新创业大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1105, 344, '全国大学生集成电路创新创业大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国大学生集成电路创新创业大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1106, 345, '全国大学生嵌入式芯片与系统设计竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生嵌入式芯片与系统设计竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1107, 345, '全国大学生嵌入式芯片与系统设计竞赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生嵌入式芯片与系统设计竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1108, 346, '全国大学生化工设计竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加全国大学生化工设计竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1109, 346, '全国大学生化工设计竞赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加全国大学生化工设计竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1110, 347, '全国大学生制药工程设计竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加全国大学生制药工程设计竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1111, 347, '全国大学生制药工程设计竞赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加全国大学生制药工程设计竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1112, 348, '全国大学生水利创新设计大赛', '灵犀智造——模块化感知控制与工程实现', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国大学生水利创新设计大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1113, 348, '全国大学生水利创新设计大赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国大学生水利创新设计大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1114, 349, '全国大学生交通运输科技大赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生交通运输科技大赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1115, 349, '全国大学生交通运输科技大赛', '逐风系统——低成本高可靠的智能装备方案', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生交通运输科技大赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1116, 350, '全国大学生智能建造与管理创新竞赛', '灵犀智造——模块化感知控制与工程实现', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加全国大学生智能建造与管理创新竞赛，围绕“模块化感知控制与工程实现”完成灵犀智造——模块化感知控制与工程实现。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1117, 350, '全国大学生智能建造与管理创新竞赛', '逐风系统——低成本高可靠的智能装备方案', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加全国大学生智能建造与管理创新竞赛，围绕“低成本高可靠的智能装备方案”完成逐风系统——低成本高可靠的智能装备方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1118, 351, '外研社·国才杯理解当代中国全国大学生外语能力大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加外研社·国才杯理解当代中国全国大学生外语能力大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1119, 351, '外研社·国才杯理解当代中国全国大学生外语能力大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加外研社·国才杯理解当代中国全国大学生外语能力大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1120, 352, '全国大学生英语竞赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生英语竞赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1121, 352, '全国大学生英语竞赛', '声动世界——多语种表达与国际传播实践', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生英语竞赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1122, 353, '21世纪杯全国英语演讲比赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加21世纪杯全国英语演讲比赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1123, 353, '21世纪杯全国英语演讲比赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加21世纪杯全国英语演讲比赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1124, 354, '韩素音国际翻译大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加韩素音国际翻译大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1125, 354, '韩素音国际翻译大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加韩素音国际翻译大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1126, 355, '全国口译大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国口译大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1127, 355, '全国口译大赛', '声动世界——多语种表达与国际传播实践', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国口译大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1128, 356, '全国高校商务英语竞赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国高校商务英语竞赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1129, 356, '全国高校商务英语竞赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国高校商务英语竞赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1130, 357, '全国大学生英语翻译大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生英语翻译大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1131, 357, '全国大学生英语翻译大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生英语翻译大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1132, 358, '全国大学生英语词汇能力大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加全国大学生英语词汇能力大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1133, 358, '全国大学生英语词汇能力大赛', '声动世界——多语种表达与国际传播实践', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加全国大学生英语词汇能力大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1134, 359, '全国大学生英语语法竞赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加全国大学生英语语法竞赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1135, 359, '全国大学生英语语法竞赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加全国大学生英语语法竞赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1136, 360, '全国大学生学术英语词汇竞赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国大学生学术英语词汇竞赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1137, 360, '全国大学生学术英语词汇竞赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国大学生学术英语词汇竞赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1138, 361, '笹川杯全国高校日本知识大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加笹川杯全国高校日本知识大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1139, 361, '笹川杯全国高校日本知识大赛', '声动世界——多语种表达与国际传播实践', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加笹川杯全国高校日本知识大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1140, 362, '中华全国日语演讲比赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加中华全国日语演讲比赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1141, 362, '中华全国日语演讲比赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加中华全国日语演讲比赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1142, 363, '全国高校法语演讲比赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国高校法语演讲比赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1143, 363, '全国高校法语演讲比赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国高校法语演讲比赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1144, 364, '全国高校德语专业大学生德语辩论赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国高校德语专业大学生德语辩论赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1145, 364, '全国高校德语专业大学生德语辩论赛', '声动世界——多语种表达与国际传播实践', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国高校德语专业大学生德语辩论赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1146, 365, '全国高校俄语大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国高校俄语大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1147, 365, '全国高校俄语大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国高校俄语大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1148, 366, '全国高校西班牙语专业四项技能大赛', '桥语中国——用跨文化叙事讲好中国故事', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加全国高校西班牙语专业四项技能大赛，围绕“用跨文化叙事讲好中国故事”完成桥语中国——用跨文化叙事讲好中国故事。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1149, 366, '全国高校西班牙语专业四项技能大赛', '声动世界——多语种表达与国际传播实践', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加全国高校西班牙语专业四项技能大赛，围绕“多语种表达与国际传播实践”完成声动世界——多语种表达与国际传播实践。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1150, 367, 'ICPC国际大学生程序设计竞赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加ICPC国际大学生程序设计竞赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1151, 367, 'ICPC国际大学生程序设计竞赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加ICPC国际大学生程序设计竞赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1152, 368, '中国大学生程序设计竞赛CCPC', '星河智联——面向校园场景的智能信息平台', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加中国大学生程序设计竞赛CCPC，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1153, 368, '中国大学生程序设计竞赛CCPC', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加中国大学生程序设计竞赛CCPC，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1154, 369, '蓝桥杯全国软件和信息技术专业人才大赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加蓝桥杯全国软件和信息技术专业人才大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1155, 369, '蓝桥杯全国软件和信息技术专业人才大赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加蓝桥杯全国软件和信息技术专业人才大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1156, 370, '中国高校计算机大赛团体程序设计天梯赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛团体程序设计天梯赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1157, 370, '中国高校计算机大赛团体程序设计天梯赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛团体程序设计天梯赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1158, 371, '中国高校计算机大赛大数据挑战赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛大数据挑战赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1159, 371, '中国高校计算机大赛大数据挑战赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛大数据挑战赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1160, 372, '中国高校计算机大赛人工智能创意赛', '星河智联——面向校园场景的智能信息平台', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛人工智能创意赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1161, 372, '中国高校计算机大赛人工智能创意赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛人工智能创意赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1162, 373, '中国高校计算机大赛网络技术挑战赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛网络技术挑战赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1163, 373, '中国高校计算机大赛网络技术挑战赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛网络技术挑战赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1164, 374, '中国高校计算机大赛移动应用创新赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛移动应用创新赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1165, 374, '中国高校计算机大赛移动应用创新赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加中国高校计算机大赛移动应用创新赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1166, 375, '全国大学生信息安全竞赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国大学生信息安全竞赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1167, 375, '全国大学生信息安全竞赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国大学生信息安全竞赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1168, 376, '全国大学生网络安全精英赛', '星河智联——面向校园场景的智能信息平台', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加全国大学生网络安全精英赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1169, 376, '全国大学生网络安全精英赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加全国大学生网络安全精英赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1170, 377, '全国大学生软件测试大赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国大学生软件测试大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1171, 377, '全国大学生软件测试大赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国大学生软件测试大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1172, 378, '全国大学生物联网设计竞赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加全国大学生物联网设计竞赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1173, 378, '全国大学生物联网设计竞赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加全国大学生物联网设计竞赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1174, 379, '全国大学生计算机系统能力大赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国大学生计算机系统能力大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1175, 379, '全国大学生计算机系统能力大赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国大学生计算机系统能力大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1176, 380, '全国大学生计算机博弈大赛', '星河智联——面向校园场景的智能信息平台', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国大学生计算机博弈大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1177, 380, '全国大学生计算机博弈大赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国大学生计算机博弈大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1178, 381, '全国大学生数字取证竞赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生数字取证竞赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1179, 381, '全国大学生数字取证竞赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生数字取证竞赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1180, 382, '华为ICT大赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加华为ICT大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1181, 382, '华为ICT大赛', '云盾计划——可信数据分析与安全协同系统', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加华为ICT大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1182, 383, '百度之星程序设计大赛', '星河智联——面向校园场景的智能信息平台', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加百度之星程序设计大赛，围绕“面向校园场景的智能信息平台”完成星河智联——面向校园场景的智能信息平台。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1183, 383, '百度之星程序设计大赛', '云盾计划——可信数据分析与安全协同系统', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加百度之星程序设计大赛，围绕“可信数据分析与安全协同系统”完成云盾计划——可信数据分析与安全协同系统。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1184, 384, '美国大学生数学建模竞赛MCM/ICM', '数见未来——复杂系统的数据建模与优化', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加美国大学生数学建模竞赛MCM/ICM，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1185, 384, '美国大学生数学建模竞赛MCM/ICM', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加美国大学生数学建模竞赛MCM/ICM，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1186, 385, 'MathorCup高校数学建模挑战赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加MathorCup高校数学建模挑战赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1187, 385, 'MathorCup高校数学建模挑战赛', '理析万象——多尺度实验分析与预测方案', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加MathorCup高校数学建模挑战赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1188, 386, '华数杯全国大学生数学建模竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加华数杯全国大学生数学建模竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1189, 386, '华数杯全国大学生数学建模竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加华数杯全国大学生数学建模竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1190, 387, '泰迪杯数据挖掘挑战赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加泰迪杯数据挖掘挑战赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1191, 387, '泰迪杯数据挖掘挑战赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加泰迪杯数据挖掘挑战赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1192, 388, '深圳杯数学建模挑战赛', '数见未来——复杂系统的数据建模与优化', '国家级一等奖', '林知夏', '2023', '<h3>项目概况</h3><p>团队参加深圳杯数学建模挑战赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1193, 388, '深圳杯数学建模挑战赛', '理析万象——多尺度实验分析与预测方案', '省级一等奖', '周予安', '2024', '<h3>项目概况</h3><p>团队参加深圳杯数学建模挑战赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1194, 389, '全国大学生数学竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '陈砚', '2024', '<h3>项目概况</h3><p>团队参加全国大学生数学竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1195, 389, '全国大学生数学竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '许嘉禾', '2025', '<h3>项目概况</h3><p>团队参加全国大学生数学竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1196, 390, '全国大学生数据分析大赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '沈星遥', '2025', '<h3>项目概况</h3><p>团队参加全国大学生数据分析大赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1197, 390, '全国大学生数据分析大赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '顾明川', '2023', '<h3>项目概况</h3><p>团队参加全国大学生数据分析大赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1198, 391, '全国大学生物理学术竞赛CUPT', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '苏念', '2023', '<h3>项目概况</h3><p>团队参加全国大学生物理学术竞赛CUPT，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1199, 391, '全国大学生物理学术竞赛CUPT', '理析万象——多尺度实验分析与预测方案', '省级一等奖', '唐一诺', '2024', '<h3>项目概况</h3><p>团队参加全国大学生物理学术竞赛CUPT，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1200, 392, '全国大学生电工数学建模竞赛', '数见未来——复杂系统的数据建模与优化', '国家级一等奖', '叶清扬', '2024', '<h3>项目概况</h3><p>团队参加全国大学生电工数学建模竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1201, 392, '全国大学生电工数学建模竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '陆景行', '2025', '<h3>项目概况</h3><p>团队参加全国大学生电工数学建模竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1202, 393, '全国大学生化工实验大赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '江晚晴', '2025', '<h3>项目概况</h3><p>团队参加全国大学生化工实验大赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1203, 393, '全国大学生化工实验大赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '谢云舟', '2023', '<h3>项目概况</h3><p>团队参加全国大学生化工实验大赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1204, 394, '全国大学生材料综合技能大赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '宋时雨', '2023', '<h3>项目概况</h3><p>团队参加全国大学生材料综合技能大赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1205, 394, '全国大学生材料综合技能大赛', '理析万象——多尺度实验分析与预测方案', '省级一等奖', '温书言', '2024', '<h3>项目概况</h3><p>团队参加全国大学生材料综合技能大赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1206, 395, '全国大学生地球物理知识竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '程屿', '2024', '<h3>项目概况</h3><p>团队参加全国大学生地球物理知识竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1207, 395, '全国大学生地球物理知识竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '乔木', '2025', '<h3>项目概况</h3><p>团队参加全国大学生地球物理知识竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1208, 396, '全国大学生基础医学创新研究暨实验设计论坛', '数见未来——复杂系统的数据建模与优化', '国家级一等奖', '余声', '2025', '<h3>项目概况</h3><p>团队参加全国大学生基础医学创新研究暨实验设计论坛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1209, 396, '全国大学生基础医学创新研究暨实验设计论坛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '白榆', '2023', '<h3>项目概况</h3><p>团队参加全国大学生基础医学创新研究暨实验设计论坛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1210, 397, '全国大学生生物医学工程创新设计竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '夏栀', '2023', '<h3>项目概况</h3><p>团队参加全国大学生生物医学工程创新设计竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1211, 397, '全国大学生生物医学工程创新设计竞赛', '理析万象——多尺度实验分析与预测方案', '省级一等奖', '孟川', '2024', '<h3>项目概况</h3><p>团队参加全国大学生生物医学工程创新设计竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1212, 398, '全国大学生环境资源模拟法庭大赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '秦朗', '2024', '<h3>项目概况</h3><p>团队参加全国大学生环境资源模拟法庭大赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1213, 398, '全国大学生环境资源模拟法庭大赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '楚宁', '2025', '<h3>项目概况</h3><p>团队参加全国大学生环境资源模拟法庭大赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1214, 399, '全国大学生农业建筑环境与能源工程相关专业创新创业竞赛', '数见未来——复杂系统的数据建模与优化', '国家级二等奖', '黎川', '2025', '<h3>项目概况</h3><p>团队参加全国大学生农业建筑环境与能源工程相关专业创新创业竞赛，围绕“复杂系统的数据建模与优化”完成数见未来——复杂系统的数据建模与优化。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1215, 399, '全国大学生农业建筑环境与能源工程相关专业创新创业竞赛', '理析万象——多尺度实验分析与预测方案', '国家级三等奖', '简宁', '2023', '<h3>项目概况</h3><p>团队参加全国大学生农业建筑环境与能源工程相关专业创新创业竞赛，围绕“多尺度实验分析与预测方案”完成理析万象——多尺度实验分析与预测方案。前期通过规则拆解、资料检索和用户访谈确定范围，中期完成核心方案与验证，后期集中打磨材料和答辩。</p><h3>关键过程</h3><p>最初版本的问题是目标过宽、证据分散。团队将任务拆成需求、方案、实验和表达四条线，每周用评分表自检，并通过两轮模拟评审修正重点。最终版本保留一条清晰主线，同时补足数据、成本或可行性证据。</p><h3>踩坑与改进</h3><p>最大的教训是联调和材料整合启动太晚。下一次会在开赛第一周建立统一文件规范，每个里程碑都产出可演示版本；答辩前至少进行三次限时演练，并为常见追问准备证据页。</p><p><em>注：此复盘为 InnoTrack 演示数据，项目、人物及奖项均为虚构样例。</em></p>', '1', NULL, 'admin', '2026-06-20 13:00:00', '0', 'student_seed', '2026-06-20 12:45:00', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1216, 400, '', '???????-001', '???', '????', '2025', '????????????????????????????XX??...', '1', NULL, 'admin', '2026-06-28 15:06:44', '0', 'student01', '2026-06-28 15:05:33', '', '2026-06-28 15:06:44');
INSERT INTO `competition_retrospect` VALUES (1217, 400, '', '??????', '???', '????', '2026', '?????????', '1', NULL, 'admin', '2026-06-28 18:59:18', '0', 'student01', '2026-06-28 18:57:54', '', '2026-06-28 18:59:18');
INSERT INTO `competition_retrospect` VALUES (1218, 400, '', '??????V2', '???', '????', '2026', 'RabbitMQ???????', '1', NULL, 'admin', '2026-06-28 19:02:26', '0', 'student01', '2026-06-28 19:01:46', '', '2026-06-28 19:02:26');
INSERT INTO `competition_retrospect` VALUES (1219, 400, '', 'NotifTestRetrospect', 'FirstPrize', 'TestLeader', '2026', 'Testing notification feature content here. Testing notification feature content here. Testing notification feature content here. Testing notification feature content here.', '0', NULL, '', NULL, '0', 'student01', '2026-06-28 19:15:50', '', NULL);
INSERT INTO `competition_retrospect` VALUES (1220, 400, '', 'NotifTestRetrospect', 'FirstPrize', 'TestLeader', '2026', 'Testing notification feature content here. Testing notification feature content here. Testing notification feature content here. Testing notification feature content here.', '1', NULL, 'admin', '2026-06-28 19:16:45', '0', 'student01', '2026-06-28 19:16:45', '', '2026-06-28 19:16:45');
INSERT INTO `competition_retrospect` VALUES (1221, 400, '', '??????', '???', '????', '2026', '???????????', '1', NULL, 'admin', '2026-06-28 19:43:46', '0', 'student01', '2026-06-28 19:43:36', '', '2026-06-28 19:43:46');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 920 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_logininfor` VALUES (189, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:19:10');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:32:59');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:33:00');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:33:07');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:33:07');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:35:23');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:35:23');
INSERT INTO `sys_logininfor` VALUES (196, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:39:45');
INSERT INTO `sys_logininfor` VALUES (197, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:39:47');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:39:50');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:39:50');
INSERT INTO `sys_logininfor` VALUES (200, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:43:48');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:43:51');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:43:51');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:44:07');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:44:07');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:46:35');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:46:36');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:47:27');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:47:27');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:50:10');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:50:11');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:52:54');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:52:54');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:53:59');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:53:59');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '登录成功', '2026-06-07 20:54:52');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '0', '退出成功', '2026-06-07 20:54:52');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:55:08');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:55:08');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:55:34');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:55:34');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:56:14');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:56:14');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:57:33');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-07 20:57:33');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-07 20:58:13');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 148', 'Windows10', '1', '验证码已失效', '2026-06-07 21:08:16');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-11 15:54:03');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-13 19:39:44');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 13:07:56');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-16 13:16:38');
INSERT INTO `sys_logininfor` VALUES (231, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 13:16:42');
INSERT INTO `sys_logininfor` VALUES (232, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-16 13:45:45');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 13:45:52');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-16 13:56:03');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 13:56:05');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-16 13:56:49');
INSERT INTO `sys_logininfor` VALUES (237, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 13:56:54');
INSERT INTO `sys_logininfor` VALUES (238, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 14:50:33');
INSERT INTO `sys_logininfor` VALUES (239, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-16 17:13:46');
INSERT INTO `sys_logininfor` VALUES (240, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-18 19:39:46');
INSERT INTO `sys_logininfor` VALUES (241, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-19 00:18:02');
INSERT INTO `sys_logininfor` VALUES (242, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-19 00:18:03');
INSERT INTO `sys_logininfor` VALUES (243, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-19 15:18:17');
INSERT INTO `sys_logininfor` VALUES (244, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-19 16:57:30');
INSERT INTO `sys_logininfor` VALUES (245, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-19 19:52:55');
INSERT INTO `sys_logininfor` VALUES (246, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-19 20:04:23');
INSERT INTO `sys_logininfor` VALUES (247, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-19 20:04:35');
INSERT INTO `sys_logininfor` VALUES (248, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 01:57:15');
INSERT INTO `sys_logininfor` VALUES (249, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-20 01:57:53');
INSERT INTO `sys_logininfor` VALUES (250, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 01:57:58');
INSERT INTO `sys_logininfor` VALUES (251, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码已失效', '2026-06-20 11:29:55');
INSERT INTO `sys_logininfor` VALUES (252, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码已失效', '2026-06-20 11:39:22');
INSERT INTO `sys_logininfor` VALUES (253, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-20 11:39:48');
INSERT INTO `sys_logininfor` VALUES (254, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 14:49:44');
INSERT INTO `sys_logininfor` VALUES (255, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码已失效', '2026-06-20 15:42:32');
INSERT INTO `sys_logininfor` VALUES (256, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 15:42:38');
INSERT INTO `sys_logininfor` VALUES (257, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 16:18:47');
INSERT INTO `sys_logininfor` VALUES (258, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 16:51:33');
INSERT INTO `sys_logininfor` VALUES (259, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-20 17:13:34');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 17:13:39');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-20 17:22:11');
INSERT INTO `sys_logininfor` VALUES (262, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 17:22:19');
INSERT INTO `sys_logininfor` VALUES (263, 'yao', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-20 17:26:34');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-20 17:26:42');
INSERT INTO `sys_logininfor` VALUES (269, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '注册成功', '2026-06-21 16:47:57');
INSERT INTO `sys_logininfor` VALUES (270, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '用户不存在/密码错误', '2026-06-21 16:48:04');
INSERT INTO `sys_logininfor` VALUES (271, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '用户不存在/密码错误', '2026-06-21 16:48:08');
INSERT INTO `sys_logininfor` VALUES (272, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-21 16:48:16');
INSERT INTO `sys_logininfor` VALUES (273, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-21 16:59:32');
INSERT INTO `sys_logininfor` VALUES (274, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-21 17:00:16');
INSERT INTO `sys_logininfor` VALUES (275, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-21 17:00:17');
INSERT INTO `sys_logininfor` VALUES (276, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-21 18:03:55');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 13:46:21');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '登录成功', '2026-06-28 13:46:41');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '退出成功', '2026-06-28 13:54:08');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 13:54:41');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '登录成功', '2026-06-28 13:56:20');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 13:57:25');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 13:57:53');
INSERT INTO `sys_logininfor` VALUES (284, 'teacher01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 13:59:53');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:44');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:45');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:00:45');
INSERT INTO `sys_logininfor` VALUES (293, 'teacher01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-06-28 14:01:52');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (296, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (300, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (305, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (306, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (307, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (310, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (311, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:12');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:13');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:03:26');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:03:26');
INSERT INTO `sys_logininfor` VALUES (316, 'teacher01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:03:40');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:04:16');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (331, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:34');
INSERT INTO `sys_logininfor` VALUES (332, 'teacher01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:04:48');
INSERT INTO `sys_logininfor` VALUES (333, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (338, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (339, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (340, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (341, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (342, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (346, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (347, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (350, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (351, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (352, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (353, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (354, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (355, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (356, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (358, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (359, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (360, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (361, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (362, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (364, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (365, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (366, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (367, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (368, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (369, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (370, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (371, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (372, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (373, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (374, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (375, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (376, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (377, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (378, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (381, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (382, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (385, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (386, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (387, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (388, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (389, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (390, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (391, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (392, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (393, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (394, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (395, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (396, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (397, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (398, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (400, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (401, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (402, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (403, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (404, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (405, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (406, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (407, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (408, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (409, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (410, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (411, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (412, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (413, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (414, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (415, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (416, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (417, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (418, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (420, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:50');
INSERT INTO `sys_logininfor` VALUES (421, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (422, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (423, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (425, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (426, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (427, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (428, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (429, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (432, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (433, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:04:51');
INSERT INTO `sys_logininfor` VALUES (434, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (435, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (436, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (437, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (438, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (439, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (440, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (441, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (442, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (443, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (444, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (445, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (446, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (447, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (449, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (451, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (452, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:06:39');
INSERT INTO `sys_logininfor` VALUES (453, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:06:53');
INSERT INTO `sys_logininfor` VALUES (454, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:11:14');
INSERT INTO `sys_logininfor` VALUES (455, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:25:32');
INSERT INTO `sys_logininfor` VALUES (456, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (457, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (458, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (459, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (460, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (461, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (462, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (463, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (464, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (465, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (466, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (467, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (468, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (469, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (470, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (471, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (472, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (473, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (474, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (475, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (476, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (477, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (478, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (479, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (480, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (481, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (482, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (483, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (484, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (485, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (486, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (487, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (488, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (489, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (490, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (491, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:20');
INSERT INTO `sys_logininfor` VALUES (492, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (493, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (494, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (495, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (496, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (497, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (498, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (499, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (500, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (501, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (502, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (503, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (504, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (505, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (506, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (507, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (508, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (509, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (510, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (511, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (512, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (513, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (514, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (515, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (516, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (517, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (518, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (519, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (520, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (521, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (522, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (523, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (524, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (525, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (526, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (527, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (528, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (529, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (530, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (531, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (532, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (533, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (534, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (535, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (536, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (537, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (538, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (539, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (540, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (541, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (542, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (543, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (544, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (545, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (546, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (547, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (548, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (549, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (550, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:21');
INSERT INTO `sys_logininfor` VALUES (551, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (552, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (553, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (554, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (555, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (556, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (557, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (558, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (559, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (560, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (561, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (562, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (563, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (564, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (565, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (566, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (567, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (568, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (569, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (570, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (571, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (572, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (573, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (574, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (575, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (576, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (577, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (578, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (579, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (580, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (581, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (582, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (583, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (584, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (585, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (586, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (587, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (588, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (589, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (590, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (591, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (592, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (593, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (594, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (595, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (596, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (597, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (598, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (599, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (600, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (601, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (602, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (603, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (604, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (605, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (606, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (607, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (608, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (609, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (610, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (611, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (612, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (613, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (614, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (615, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (616, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (617, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (618, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (619, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (620, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (621, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (622, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (623, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (624, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (625, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (626, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (627, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (628, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (629, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (630, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:45');
INSERT INTO `sys_logininfor` VALUES (631, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (632, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (633, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (634, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (635, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (636, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (637, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (638, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (639, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (640, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (641, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (642, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (643, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (644, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (645, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (646, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (647, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (648, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (649, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (650, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (651, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (652, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (653, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (654, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (655, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (656, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (657, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (658, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (659, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (660, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (661, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (662, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (663, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (664, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (665, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (666, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (667, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (668, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (669, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (670, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (671, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (672, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (673, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (674, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (675, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (676, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (677, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (678, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (679, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (680, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (681, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (682, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (683, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (684, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (685, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (686, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (687, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (688, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (689, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (690, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (691, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (692, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (693, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (694, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (695, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (696, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (697, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (698, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (699, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (700, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (701, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (702, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:26:46');
INSERT INTO `sys_logininfor` VALUES (703, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (704, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (705, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (706, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (707, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (708, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (709, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (710, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (711, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (712, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (713, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (714, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (715, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (716, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (717, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (718, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (719, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (720, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (721, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:27:36');
INSERT INTO `sys_logininfor` VALUES (722, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:28:16');
INSERT INTO `sys_logininfor` VALUES (723, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:28:20');
INSERT INTO `sys_logininfor` VALUES (724, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '退出成功', '2026-06-28 14:31:30');
INSERT INTO `sys_logininfor` VALUES (725, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (726, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (727, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (728, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (729, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (730, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (731, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (732, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (733, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (734, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (735, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (736, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (737, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:26');
INSERT INTO `sys_logininfor` VALUES (738, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (739, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (740, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (741, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (742, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (743, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (744, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (745, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:32:27');
INSERT INTO `sys_logininfor` VALUES (746, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (747, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (748, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (749, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (750, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (751, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (752, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (753, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (754, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (755, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (756, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (757, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (758, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (759, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (760, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (761, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (762, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (763, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (764, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (765, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (766, 'admin', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 14:33:01');
INSERT INTO `sys_logininfor` VALUES (767, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (768, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (769, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (770, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (771, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (772, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:15');
INSERT INTO `sys_logininfor` VALUES (773, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (774, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (775, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (776, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (777, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (778, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (779, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (780, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (781, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (782, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (783, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (784, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (785, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (786, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (787, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (788, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (789, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (790, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (791, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (792, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (793, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (794, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (795, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (796, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:16');
INSERT INTO `sys_logininfor` VALUES (797, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (798, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (799, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (800, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (801, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (802, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (803, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (804, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:35:32');
INSERT INTO `sys_logininfor` VALUES (805, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:35:33');
INSERT INTO `sys_logininfor` VALUES (806, 'student01', '127.0.0.1', '内网IP', 'QoderCN 1.4.1', 'Windows 10.0', '1', '验证码错误', '2026-06-28 14:43:44');
INSERT INTO `sys_logininfor` VALUES (807, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:55:13');
INSERT INTO `sys_logininfor` VALUES (808, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '用户不存在/密码错误', '2026-06-28 14:55:14');
INSERT INTO `sys_logininfor` VALUES (809, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:56:10');
INSERT INTO `sys_logininfor` VALUES (810, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:56:10');
INSERT INTO `sys_logininfor` VALUES (811, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:56:55');
INSERT INTO `sys_logininfor` VALUES (812, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:56:55');
INSERT INTO `sys_logininfor` VALUES (813, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:58:40');
INSERT INTO `sys_logininfor` VALUES (814, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 14:59:10');
INSERT INTO `sys_logininfor` VALUES (815, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:01:14');
INSERT INTO `sys_logininfor` VALUES (816, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:01:14');
INSERT INTO `sys_logininfor` VALUES (817, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:04:40');
INSERT INTO `sys_logininfor` VALUES (818, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:04:42');
INSERT INTO `sys_logininfor` VALUES (819, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:04:54');
INSERT INTO `sys_logininfor` VALUES (820, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:05:07');
INSERT INTO `sys_logininfor` VALUES (821, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:06:43');
INSERT INTO `sys_logininfor` VALUES (822, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 15:07:40');
INSERT INTO `sys_logininfor` VALUES (823, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-28 18:44:33');
INSERT INTO `sys_logininfor` VALUES (824, '1111111dd', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-28 18:44:38');
INSERT INTO `sys_logininfor` VALUES (825, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 18:57:16');
INSERT INTO `sys_logininfor` VALUES (826, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 18:57:46');
INSERT INTO `sys_logininfor` VALUES (827, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 18:58:29');
INSERT INTO `sys_logininfor` VALUES (828, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:00:34');
INSERT INTO `sys_logininfor` VALUES (829, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:00:54');
INSERT INTO `sys_logininfor` VALUES (830, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:01:01');
INSERT INTO `sys_logininfor` VALUES (831, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-28 19:13:27');
INSERT INTO `sys_logininfor` VALUES (832, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 19:13:27');
INSERT INTO `sys_logininfor` VALUES (833, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:13:42');
INSERT INTO `sys_logininfor` VALUES (834, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:15:45');
INSERT INTO `sys_logininfor` VALUES (835, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:15:45');
INSERT INTO `sys_logininfor` VALUES (836, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:15:46');
INSERT INTO `sys_logininfor` VALUES (837, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:15:46');
INSERT INTO `sys_logininfor` VALUES (838, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:16:41');
INSERT INTO `sys_logininfor` VALUES (839, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:16:41');
INSERT INTO `sys_logininfor` VALUES (840, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:16:41');
INSERT INTO `sys_logininfor` VALUES (841, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:16:41');
INSERT INTO `sys_logininfor` VALUES (842, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:43:04');
INSERT INTO `sys_logininfor` VALUES (843, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:43:29');
INSERT INTO `sys_logininfor` VALUES (844, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 19:44:44');
INSERT INTO `sys_logininfor` VALUES (845, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 20:23:33');
INSERT INTO `sys_logininfor` VALUES (846, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:11:14');
INSERT INTO `sys_logininfor` VALUES (847, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:11:46');
INSERT INTO `sys_logininfor` VALUES (848, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:11:46');
INSERT INTO `sys_logininfor` VALUES (849, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:11:52');
INSERT INTO `sys_logininfor` VALUES (850, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-28 21:12:03');
INSERT INTO `sys_logininfor` VALUES (851, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:12:11');
INSERT INTO `sys_logininfor` VALUES (852, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:12:19');
INSERT INTO `sys_logininfor` VALUES (853, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:12:26');
INSERT INTO `sys_logininfor` VALUES (854, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:14:13');
INSERT INTO `sys_logininfor` VALUES (855, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:15:03');
INSERT INTO `sys_logininfor` VALUES (856, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:15:04');
INSERT INTO `sys_logininfor` VALUES (857, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:15:04');
INSERT INTO `sys_logininfor` VALUES (858, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:15:04');
INSERT INTO `sys_logininfor` VALUES (859, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:15:27');
INSERT INTO `sys_logininfor` VALUES (860, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:16:35');
INSERT INTO `sys_logininfor` VALUES (861, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:17:23');
INSERT INTO `sys_logininfor` VALUES (862, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:17:42');
INSERT INTO `sys_logininfor` VALUES (863, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:17:54');
INSERT INTO `sys_logininfor` VALUES (864, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:18:12');
INSERT INTO `sys_logininfor` VALUES (865, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:18:42');
INSERT INTO `sys_logininfor` VALUES (866, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:20:26');
INSERT INTO `sys_logininfor` VALUES (867, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:20:27');
INSERT INTO `sys_logininfor` VALUES (868, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:20:27');
INSERT INTO `sys_logininfor` VALUES (869, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码已失效', '2026-06-28 21:20:43');
INSERT INTO `sys_logininfor` VALUES (870, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:21:53');
INSERT INTO `sys_logininfor` VALUES (871, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:21:54');
INSERT INTO `sys_logininfor` VALUES (872, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:21:55');
INSERT INTO `sys_logininfor` VALUES (873, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:22:35');
INSERT INTO `sys_logininfor` VALUES (874, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:23:54');
INSERT INTO `sys_logininfor` VALUES (875, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:23:54');
INSERT INTO `sys_logininfor` VALUES (876, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:23:55');
INSERT INTO `sys_logininfor` VALUES (877, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:24:21');
INSERT INTO `sys_logininfor` VALUES (878, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:25:27');
INSERT INTO `sys_logininfor` VALUES (879, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:25:28');
INSERT INTO `sys_logininfor` VALUES (880, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:25:28');
INSERT INTO `sys_logininfor` VALUES (881, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:25:58');
INSERT INTO `sys_logininfor` VALUES (882, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:26:10');
INSERT INTO `sys_logininfor` VALUES (883, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:27:26');
INSERT INTO `sys_logininfor` VALUES (884, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:27:27');
INSERT INTO `sys_logininfor` VALUES (885, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:27:27');
INSERT INTO `sys_logininfor` VALUES (886, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:29:09');
INSERT INTO `sys_logininfor` VALUES (887, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:29:10');
INSERT INTO `sys_logininfor` VALUES (888, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:29:11');
INSERT INTO `sys_logininfor` VALUES (889, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:32:04');
INSERT INTO `sys_logininfor` VALUES (890, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:32:17');
INSERT INTO `sys_logininfor` VALUES (891, 'teacher01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:32:24');
INSERT INTO `sys_logininfor` VALUES (892, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:32:25');
INSERT INTO `sys_logininfor` VALUES (893, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-28 21:41:00');
INSERT INTO `sys_logininfor` VALUES (894, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:41:18');
INSERT INTO `sys_logininfor` VALUES (895, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-28 21:41:55');
INSERT INTO `sys_logininfor` VALUES (896, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-28 21:42:19');
INSERT INTO `sys_logininfor` VALUES (897, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:45:40');
INSERT INTO `sys_logininfor` VALUES (898, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-28 21:47:17');
INSERT INTO `sys_logininfor` VALUES (899, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 11:14:11');
INSERT INTO `sys_logininfor` VALUES (900, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码已失效', '2026-06-29 11:14:20');
INSERT INTO `sys_logininfor` VALUES (901, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 11:14:35');
INSERT INTO `sys_logininfor` VALUES (902, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 11:19:11');
INSERT INTO `sys_logininfor` VALUES (903, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 11:19:31');
INSERT INTO `sys_logininfor` VALUES (904, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 13:29:31');
INSERT INTO `sys_logininfor` VALUES (905, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 13:29:33');
INSERT INTO `sys_logininfor` VALUES (906, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 13:29:39');
INSERT INTO `sys_logininfor` VALUES (907, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 13:29:39');
INSERT INTO `sys_logininfor` VALUES (908, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 13:29:45');
INSERT INTO `sys_logininfor` VALUES (909, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-29 14:03:18');
INSERT INTO `sys_logininfor` VALUES (910, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-29 14:03:18');
INSERT INTO `sys_logininfor` VALUES (911, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-29 14:03:18');
INSERT INTO `sys_logininfor` VALUES (912, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '1', '验证码错误', '2026-06-29 14:03:41');
INSERT INTO `sys_logininfor` VALUES (913, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 14:04:02');
INSERT INTO `sys_logininfor` VALUES (914, 'admin', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 14:04:07');
INSERT INTO `sys_logininfor` VALUES (915, 'student01', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 14:04:07');
INSERT INTO `sys_logininfor` VALUES (916, 'student02', '127.0.0.1', '内网IP', 'WindowsPowerShell 5.1.22621.6133', 'Windows 10.0', '0', '登录成功', '2026-06-29 14:04:07');
INSERT INTO `sys_logininfor` VALUES (917, 'student01', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-09 18:26:12');
INSERT INTO `sys_logininfor` VALUES (918, 'student01', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '1', '用户不存在/密码错误', '2026-07-09 18:26:16');
INSERT INTO `sys_logininfor` VALUES (919, 'yao', '127.0.0.1', '内网IP', 'Edge 150', 'Windows >=10', '0', '登录成功', '2026-07-09 18:26:23');

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
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 5, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-29 16:02:15', '', NULL, '系统管理目录');
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
INSERT INTO `sys_menu` VALUES (2000, '竞赛管理', 0, 1, 'competition', NULL, '', NULL, 1, 0, 'M', '0', '0', '', 'component', 'admin', '2026-06-07 20:58:07', '', NULL, '竞赛管理父目录');
INSERT INTO `sys_menu` VALUES (2001, '竞赛发布', 2000, 1, 'index', 'system/competition/index', '', 'CompetitionManage', 1, 0, 'C', '0', '0', 'system:competition:list', 'edit', 'admin', '2026-06-07 20:58:07', '', NULL, '竞赛发布-CRUD');
INSERT INTO `sys_menu` VALUES (2002, '成绩管理', 2000, 4, 'result', 'system/competition/result', '', 'CompetitionResult', 1, 0, 'C', '0', '0', 'system:competition:manage', 'form', 'admin', '2026-06-07 20:58:07', '', NULL, '成绩录入+审核');
INSERT INTO `sys_menu` VALUES (2010, '知识库管理', 0, 3, 'knowledge-manage', NULL, '', NULL, 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-06-07 20:58:07', '', NULL, '知识库管理父目录');
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
INSERT INTO `sys_menu` VALUES (3061, '复盘审核', 2010, 1, 'retrospect', 'system/knowledgeaudit/retrospect/index', '', 'KnowledgeAuditRetrospect', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', '2026-06-04 00:36:52', '', NULL, '管理员-项目复盘审核页');
INSERT INTO `sys_menu` VALUES (3062, '经验帖审核', 2010, 2, 'experience', 'system/knowledgeaudit/experience/index', '', 'KnowledgeAuditExperience', 1, 0, 'C', '0', '0', 'system:knowledge:audit', 'list', 'admin', '2026-06-04 00:36:52', '', NULL, '管理员-经验帖审核页');
INSERT INTO `sys_menu` VALUES (3063, '报名审核', 2000, 2, 'applyaudit', 'system/competitionaudit/apply/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛报名审核页');
INSERT INTO `sys_menu` VALUES (3064, '队伍审核', 2000, 3, 'teamaudit', 'system/competitionaudit/team/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛队伍审核页');
INSERT INTO `sys_menu` VALUES (3065, '成绩审核', 2000, 5, 'resultaudit', 'system/competitionaudit/result/index', '', '', 1, 0, 'C', '0', '0', 'system:competition:audit', 'list', 'admin', '2026-06-04 02:09:08', '', NULL, '管理员-竞赛成绩审核页');
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 1, 1, '2026-06-20 17:14:33');

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
) ENGINE = InnoDB AUTO_INCREMENT = 166 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_oper_log` VALUES (155, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'yao', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/06/19/4c2ebdd229f0460e8b49b8ef897216e8.jpg\",\"code\":200}', 0, NULL, '2026-06-19 00:56:46', 126);
INSERT INTO `sys_oper_log` VALUES (156, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'yao', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/06/20/d5034bd04e2042b1aea3d4396bb8b72c.png\",\"code\":200}', 0, NULL, '2026-06-20 17:12:33', 272);
INSERT INTO `sys_oper_log` VALUES (157, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2026/06/20/a4e3c9e238fa4dc1be790363042f2af3.jpg\",\"code\":200}', 0, NULL, '2026-06-20 17:16:06', 11);
INSERT INTO `sys_oper_log` VALUES (158, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'yao', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"11111111111@qq.com\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"sex\":\"1\",\"skillTags\":\"路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-20 17:22:34', 38);
INSERT INTO `sys_oper_log` VALUES (159, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'yao', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"11111111111@qq.com\",\"grade\":\"2022\",\"nickName\":\"yao\",\"params\":{},\"phonenumber\":\"15811111111\",\"sex\":\"1\",\"skillTags\":\"路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写\",\"studentNo\":\"2206161033\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-20 17:22:44', 13);
INSERT INTO `sys_oper_log` VALUES (160, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, '1111111dd', '应用统计学', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":403,\"email\":\"2488605758@qq.com\",\"grade\":\"2022级\",\"nickName\":\"yud\",\"params\":{},\"phonenumber\":\"15755762222\",\"sex\":\"2\",\"skillTags\":\"路演答辩,项目PM,市场调研\",\"studentNo\":\"222233223232\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-21 17:01:16', 37);
INSERT INTO `sys_oper_log` VALUES (161, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3,\"userName\":\"student01\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 14:31:18', 110);
INSERT INTO `sys_oper_log` VALUES (162, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 14:56:10', 90);
INSERT INTO `sys_oper_log` VALUES (163, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 15:05:02', 94);
INSERT INTO `sys_oper_log` VALUES (164, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":5} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 15:05:02', 92);
INSERT INTO `sys_oper_log` VALUES (165, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', NULL, '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 15:05:02', 88);

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
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, 'admin', 'admin', '00', 'admin@tlxy.edu.cn', '15888888888', '1', '/profile/avatar/2026/06/20/a4e3c9e238fa4dc1be790363042f2af3.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-29 14:04:07', '2026-05-29 16:02:15', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', '2026-06-20 17:16:06', '超级管理员', '0');
INSERT INTO `sys_user` VALUES (2, 101, 'teacher01', '张老师', '00', 'teacher01@tlxy.edu.cn', '15666666666', '1', '', '$2a$10$/v6y6nwTc3fLB1m2plEbvOndJS3GJq0Ki7x4fnijaXzdmuWwQxPte', '0', '0', '127.0.0.1', '2026-06-28 21:32:24', '2026-06-28 15:05:02', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', '2026-06-28 15:05:02', '计算机学院老师', '0');
INSERT INTO `sys_user` VALUES (3, NULL, 'student01', 'yu', '00', 'student01@tlxy.edu.cn', '15777777777', '1', '/profile/avatar/2026/06/01/4cb4bfdb2cc34d889015cad4290a957e.jpg', '$2a$10$KZG3GIEkDjs1cSTapLy4A.j3z7dAL00RTkvN9L1Bh1Epz4z3CDY3O', '0', '0', '127.0.0.1', '2026-06-29 14:04:08', '2026-06-28 15:05:02', '2206161033', '2022级', '路演答辩,PPT美工,UI/UX设计,项目PM,市场调研', 'admin', '2026-05-29 16:02:15', 'admin', '2026-06-28 15:05:02', '计算机学院学生', '1');
INSERT INTO `sys_user` VALUES (4, 201, 'teacher02', '王老师', '00', 'teacher02@tlxy.edu.cn', '15888888889', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-29 16:02:15', '2026-05-29 16:02:15', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', NULL, '电气工程学院老师', '0');
INSERT INTO `sys_user` VALUES (5, 201, 'student02', '赵同学', '00', 'student02@tlxy.edu.cn', '15999999999', '2', '', '$2a$10$HHU1voM1bN6krRG1TfHBPOMT7knB65LXB55srJ.nGTlVZJsOtJOf.', '0', '0', '127.0.0.1', '2026-06-29 14:04:08', '2026-06-28 15:05:02', NULL, NULL, NULL, 'admin', '2026-05-29 16:02:15', '', '2026-06-28 15:05:02', '电气工程学院学生', '0');
INSERT INTO `sys_user` VALUES (100, NULL, 'yao', 'yao', '00', '11111111111@qq.com', '15811111111', '1', '/profile/avatar/2026/06/20/d5034bd04e2042b1aea3d4396bb8b72c.png', '$2a$10$zRh8CDS5rbE9t24ED/1yn.vW4MyPIwlQDzzlae8uBIbsWwlu3h0JC', '0', '0', '127.0.0.1', '2026-07-09 18:26:23', NULL, '2206161033', '2022', '路演答辩,UI/UX设计,海报/视频剪辑,财务测算,BP撰写', 'admin', '2026-06-03 14:49:31', '', '2026-06-20 17:22:44', 'wu', '1');
INSERT INTO `sys_user` VALUES (102, 403, '1111111dd', 'yud', '00', '2488605758@qq.com', '15755762222', '2', '', '$2a$10$Bfxgyi.GLoBAQCvk8y8MAegKnhuVz/HH8rr0llovRYdYNwJSvgx7W', '0', '0', '127.0.0.1', '2026-06-28 18:44:38', '2026-06-21 16:47:54', '222233223232', '2022级', '路演答辩,项目PM,市场调研', 'self-register', '2026-06-21 16:47:54', '', '2026-06-21 17:01:16', NULL, '0');

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
INSERT INTO `sys_user_role` VALUES (102, 100);

-- ----------------------------
-- Table structure for team_invitation_record
-- ----------------------------
DROP TABLE IF EXISTS `team_invitation_record`;
CREATE TABLE `team_invitation_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '邀请记录ID',
  `team_id` bigint NOT NULL COMMENT '队伍ID',
  `inviter_id` bigint NOT NULL COMMENT '邀请人（队长）用户ID',
  `invitee_id` bigint NOT NULL COMMENT '被邀请人用户ID',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待处理 1已同意 2已拒绝 3已撤销）',
  `create_time` datetime NOT NULL COMMENT '邀请时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_invitee`(`invitee_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_team`(`team_id` ASC) USING BTREE,
  INDEX `idx_inviter`(`inviter_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '队伍邀请记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of team_invitation_record
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师邀请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of team_teacher_invitation
-- ----------------------------
INSERT INTO `team_teacher_invitation` VALUES (1, 4, 400, 2, 'teacher01', 3, 'yu', 'TestTeam001', 'test-competition-001', '1', '????', '2026-06-28 15:07:35', '2026-06-28 15:07:50');

-- ----------------------------
-- Table structure for user_notification
-- ----------------------------
DROP TABLE IF EXISTS `user_notification`;
CREATE TABLE `user_notification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '通知ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `biz_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型',
  `biz_id` bigint NULL DEFAULT NULL COMMENT '关联业务ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `is_read` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '0未读 1已读',
  `create_time` datetime NOT NULL COMMENT '通知时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notification_user`(`user_id` ASC, `is_read` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_notification
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
