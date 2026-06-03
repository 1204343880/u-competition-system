-- ============================================
-- 竞赛管理系统 - 赛氪竞赛数据初始化（幂等版）
-- 可重复执行，已存在的列/数据自动跳过
-- 执行前请确保：USE ruoyidemo;
-- ============================================

-- -------------------------------------------
-- 1. 添加 competition_type 列（个人赛/团队赛）
-- -------------------------------------------
SET @check = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'competition' AND COLUMN_NAME = 'competition_type');

SET @ddl = IF(@check = 0,
    'ALTER TABLE competition ADD COLUMN competition_type char(1) DEFAULT ''1'' COMMENT ''赛制（1个人赛 2团队赛）'' AFTER category_name',
    'SELECT ''competition_type already exists'' AS msg');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -------------------------------------------
-- 2. 添加 competition_level 列（校级/市级/省级/国家级/国际级）
-- -------------------------------------------
SET @check = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'competition' AND COLUMN_NAME = 'competition_level');

SET @ddl = IF(@check = 0,
    'ALTER TABLE competition ADD COLUMN competition_level char(1) DEFAULT '''' COMMENT ''竞赛级别（1校级 2市级 3省级 4国家级 5国际级）'' AFTER competition_type',
    'SELECT ''competition_level already exists'' AS msg');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -------------------------------------------
-- 3. 添加 view_count 列（存在则跳过）
-- -------------------------------------------
SET @check = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'competition' AND COLUMN_NAME = 'view_count');

SET @ddl = IF(@check = 0,
    'ALTER TABLE competition ADD COLUMN view_count INT DEFAULT 0 COMMENT ''浏览量'' AFTER current_participants',
    'SELECT ''view_count already exists'' AS msg');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -------------------------------------------
-- 3. 添加 tags 列（存在则跳过）
-- -------------------------------------------
SET @check = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'competition' AND COLUMN_NAME = 'tags');

SET @ddl = IF(@check = 0,
    'ALTER TABLE competition ADD COLUMN tags VARCHAR(255) DEFAULT '''' COMMENT ''竞赛标签JSON数组'' AFTER view_count',
    'SELECT ''tags already exists'' AS msg');
PREPARE stmt FROM @ddl; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -------------------------------------------
-- 4. description 升级为 LONGTEXT
-- -------------------------------------------
ALTER TABLE competition MODIFY COLUMN description LONGTEXT COMMENT '竞赛详情描述';

-- -------------------------------------------
-- 5. 字典数据
-- -------------------------------------------
INSERT IGNORE INTO sys_dict_data VALUES
(15, 4, '外语类', '04', 'competition_category', '', '', 'N', '0', 'admin', NOW(), '', NULL, ''),
(16, 5, 'IT/计算机类', '05', 'competition_category', '', '', 'N', '0', 'admin', NOW(), '', NULL, ''),
(17, 6, '理工/数学类', '06', 'competition_category', '', '', 'N', '0', 'admin', NOW(), '', NULL, '');

INSERT IGNORE INTO sys_dict_type VALUES (6, '赛制类型', 'competition_type', '0', 'admin', NOW(), '', NULL, '竞赛赛制类型');
INSERT IGNORE INTO sys_dict_data VALUES
(18, 1, '个人赛', '1', 'competition_type', '', '', 'Y', '0', 'admin', NOW(), '', NULL, ''),
(19, 2, '团队赛', '2', 'competition_type', '', '', 'N', '0', 'admin', NOW(), '', NULL, '');

INSERT IGNORE INTO sys_dict_type VALUES (7, '竞赛级别', 'competition_level', '0', 'admin', NOW(), '', NULL, '竞赛级别');
INSERT IGNORE INTO sys_dict_data VALUES
(20, 1, '校级', '1', 'competition_level', '', '', 'Y', '0', 'admin', NOW(), '', NULL, ''),
(21, 2, '市级', '2', 'competition_level', '', '', 'N', '0', 'admin', NOW(), '', NULL, ''),
(22, 3, '省级', '3', 'competition_level', '', '', 'N', '0', 'admin', NOW(), '', NULL, ''),
(23, 4, '国家级', '4', 'competition_level', '', '', 'N', '0', 'admin', NOW(), '', NULL, ''),
(24, 5, '国际级', '5', 'competition_level', '', '', 'N', '0', 'admin', NOW(), '', NULL, '');

-- -------------------------------------------
-- 6. status: 0=报名中 1=进行中 2=已结束
--    competition_type: 1=个人赛 2=团队赛
--    competition_level: 1=校级 2=市级 3=省级 4=国家级 5=国际级
-- -------------------------------------------

-- -------------------------------------------
-- 7. 插入 4 条赛氪竞赛数据
-- -------------------------------------------
DELETE FROM competition WHERE competition_id >= 200;
ALTER TABLE competition AUTO_INCREMENT = 200;

INSERT INTO competition (
    competition_name, category, category_name, competition_type, competition_level,
    description, apply_start_time, apply_end_time, start_time, end_time,
    status, organizer, host, max_participants, current_participants,
    view_count, tags,
    del_flag, create_by, create_time
) VALUES
(
    '2026年全国大学生英语作文大赛',
    '04', '外语类', '1', '4',
    '<p><strong>主办单位：</strong>高等学校大学外语教学研究会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国在校大学生（含高职高专、本科、研究生）</p><p><strong>竞赛形式：</strong>线上提交英语作文，题材不限，字数要求800-1500词。</p><p>本赛事已被多所双一流高校纳入保研加分体系，获奖证书含金量高。</p>',
    '2026-03-01 00:00:00', '2026-12-15 23:59:59', '2026-12-20 08:00:00', '2026-12-25 18:00:00',
    '0', '高等学校大学外语教学研究会', '全国大学生英语作文大赛组委会', 500000, 12350,
    351000, '["A类赛事","双一流高校覆盖","保研加分"]',
    '0', 'admin', NOW()
),
(
    '2026全国大学生"麟创杯"人工智能知识竞赛',
    '05', 'IT/计算机类', '1', '4',
    '<p><strong>主办单位：</strong>中国技术市场协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生</p><p><strong>竞赛形式：</strong>线上客观题答题，涵盖人工智能基础、机器学习、深度学习、自然语言处理等知识点，满分100分。</p><p>本赛事由中国技术市场协会（国家一级社团）主办，证书可用于综测加分。</p>',
    '2026-04-01 00:00:00', '2026-10-31 23:59:59', '2026-11-05 08:00:00', '2026-11-10 18:00:00',
    '0', '中国技术市场协会', '"麟创杯"人工智能知识竞赛组委会', 100000, 3420,
    56000, '["人工智能","客观题答题","国家一级社团"]',
    '0', 'admin', NOW()
),
(
    '2026年第六届全国大学生技术创新创业大赛',
    '02', '创新创业', '2', '4',
    '<p><strong>主办单位：</strong>中国技术创业协会</p><p><strong>竞赛级别：</strong>国家级</p><p><strong>参赛对象：</strong>全国高校在校学生（本、硕、博均可）</p><p><strong>竞赛形式：</strong>团队参赛（3-5人），提交创业计划书及路演PPT，经初赛、复赛、决赛三轮评审。</p><p>优胜项目可获立项支持及投资人对接机会，是"互联网+"大赛的优质热身赛。</p>',
    '2026-02-01 00:00:00', '2026-09-30 23:59:59', '2026-10-15 08:00:00', '2026-10-20 18:00:00',
    '0', '中国技术创业协会', '全国大学生技术创新创业大赛组委会', 80000, 2890,
    36000, '["挑战杯热身","互联网+","立项支持"]',
    '0', 'admin', NOW()
),
(
    '2026年第十六届APMCM亚太地区大学生数学建模竞赛',
    '06', '理工/数学类', '2', '5',
    '<p><strong>主办单位：</strong>中国国际科技促进会</p><p><strong>竞赛级别：</strong>国际级/国家级</p><p><strong>参赛对象：</strong>亚太地区高校在校学生</p><p><strong>竞赛形式：</strong>3人组队，在4天时间内完成一道数学建模题目，提交英文论文。赛题涵盖工程、经济、环境等交叉学科。</p><p>APMCM是国际认可度较高的数学建模赛事之一，获奖可用于国赛热身及综合测评加分。</p>',
    '2025-11-01 00:00:00', '2026-05-15 23:59:59', '2026-05-20 08:00:00', '2026-08-20 18:00:00',
    '1', '中国国际科技促进会', 'APMCM亚太地区大学生数学建模竞赛组委会', 30000, 18500,
    47000, '["数学建模","国赛热身","综合测评加分"]',
    '0', 'admin', NOW()
);

-- -------------------------------------------
-- 8. 补全旧数据赛制 + 级别
-- -------------------------------------------
UPDATE competition SET competition_type = '2' WHERE competition_type IS NULL AND competition_name LIKE '%建模%';
UPDATE competition SET competition_type = '2' WHERE competition_type IS NULL AND competition_name LIKE '%互联网%';
UPDATE competition SET competition_type = '2' WHERE competition_type IS NULL AND competition_name LIKE '%创业%';
UPDATE competition SET competition_type = '1' WHERE competition_type IS NULL;
UPDATE competition SET competition_level = '4' WHERE competition_level IS NULL OR competition_level = '';
