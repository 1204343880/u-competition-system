-- ============================================================
-- 学院专业管理数据初始化SQL
-- 结构：学校(100) -> 学院(200,300...) -> 专业(201,301...)
-- 排序：学校=1，学院从2开始连续，专业各自从1开始
-- ============================================================

TRUNCATE TABLE sys_dept;

-- ============================================================
-- 根节点：学校
-- ============================================================
INSERT INTO sys_dept VALUES (100, 0, '0', '学校', 1, '管理员', '15800000000', 'admin@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);

-- ============================================================
-- 二级：学院（parent_id=100, ancestors='0,100'）
-- order_num 从2开始连续递增
-- ============================================================
INSERT INTO sys_dept VALUES (200, 100, '0,100', '电气与信息工程学院', 2, '张三', '15800000001', 'dianqi@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (300, 100, '0,100', '人工智能学院', 3, '李四', '15800000002', 'ai@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (400, 100, '0,100', '大数据与统计学院', 4, '王五', '15800000003', 'bigdata@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (500, 100, '0,100', '机电工程学院', 5, '赵六', '15800000004', 'jidian@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (600, 100, '0,100', '材料科学与工程学院', 6, '钱七', '15800000005', 'cailiao@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (700, 100, '0,100', '智能建造与空间信息学院', 7, '孙八', '15800000006', 'jianzhu@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (800, 100, '0,100', '会计学院', 8, '周九', '15800000007', 'kuaiji@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (900, 100, '0,100', '经济学院', 9, '吴十', '15800000008', 'jingji@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1000, 100, '0,100', '管理学院', 10, '郑一', '15800000009', 'guanli@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1100, 100, '0,100', '法学与公共管理学院', 11, '王二', '15800000010', 'faxue@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1200, 100, '0,100', '语言与传播学院', 12, '刘三', '15800000011', 'yuyan@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1300, 100, '0,100', '艺术与设计学院', 13, '陈四', '15800000012', 'yishu@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1400, 100, '0,100', '马克思主义学院', 14, '杨五', '15800000013', 'makesi@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1500, 100, '0,100', '体育学院', 15, '黄六', '15800000014', 'tiyu@school.edu.cn', '0', '0', 'admin', sysdate(), '', null);

-- ============================================================
-- 三级：专业（各学院内部 order_num 从1开始连续递增）
-- ============================================================

-- 电气与信息工程学院 (ID=200, ancestors='0,100,200')
INSERT INTO sys_dept VALUES (201, 200, '0,100,200', '计算机科学与技术', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (202, 200, '0,100,200', '电子信息工程', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (203, 200, '0,100,200', '通信工程', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (204, 200, '0,100,200', '自动化', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (205, 200, '0,100,200', '物联网工程', 5, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (206, 200, '0,100,200', '人工智能', 6, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 人工智能学院 (ID=300, ancestors='0,100,300')
INSERT INTO sys_dept VALUES (301, 300, '0,100,300', '人工智能', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (302, 300, '0,100,300', '智能科学与技术', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (303, 300, '0,100,300', '数据科学与大数据技术', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (304, 300, '0,100,300', '机器人工程', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (305, 300, '0,100,300', '计算机科学与技术（AI方向）', 5, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 大数据与统计学院 (ID=400, ancestors='0,100,400')
INSERT INTO sys_dept VALUES (401, 400, '0,100,400', '数据科学与大数据技术', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (402, 400, '0,100,400', '统计学', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (403, 400, '0,100,400', '应用统计学', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (404, 400, '0,100,400', '信息与计算科学', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 机电工程学院 (ID=500, ancestors='0,100,500')
INSERT INTO sys_dept VALUES (501, 500, '0,100,500', '机械设计制造及其自动化', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (502, 500, '0,100,500', '材料成型及控制工程', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (503, 500, '0,100,500', '机械电子工程', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (504, 500, '0,100,500', '机器人工程', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 材料科学与工程学院 (ID=600, ancestors='0,100,600')
INSERT INTO sys_dept VALUES (601, 600, '0,100,600', '材料科学与工程', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (602, 600, '0,100,600', '金属材料工程', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (603, 600, '0,100,600', '高分子材料与工程', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (604, 600, '0,100,600', '新能源材料与器件', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 智能建造与空间信息学院 (ID=700, ancestors='0,100,700')
INSERT INTO sys_dept VALUES (701, 700, '0,100,700', '土木工程', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (702, 700, '0,100,700', '建筑学', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (703, 700, '0,100,700', '测绘工程', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (704, 700, '0,100,700', '地理信息科学', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (705, 700, '0,100,700', '智能建造', 5, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 会计学院 (ID=800, ancestors='0,100,800')
INSERT INTO sys_dept VALUES (801, 800, '0,100,800', '会计学', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (802, 800, '0,100,800', '审计学', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (803, 800, '0,100,800', '财务管理', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (804, 800, '0,100,800', '资产评估', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 经济学院 (ID=900, ancestors='0,100,900')
INSERT INTO sys_dept VALUES (901, 900, '0,100,900', '经济学', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (902, 900, '0,100,900', '金融学', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (903, 900, '0,100,900', '国际经济与贸易', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (904, 900, '0,100,900', '财政学', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 管理学院 (ID=1000, ancestors='0,100,1000')
INSERT INTO sys_dept VALUES (1001, 1000, '0,100,1000', '市场营销', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1002, 1000, '0,100,1000', '物流管理', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1003, 1000, '0,100,1000', '人力资源管理', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1004, 1000, '0,100,1000', '工商管理', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1005, 1000, '0,100,1000', '房地产开发与管理', 5, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 法学与公共管理学院 (ID=1100, ancestors='0,100,1100')
INSERT INTO sys_dept VALUES (1101, 1100, '0,100,1100', '法学', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1102, 1100, '0,100,1100', '行政管理', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1103, 1100, '0,100,1100', '公共事业管理', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1104, 1100, '0,100,1100', '城市管理', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 语言与传播学院 (ID=1200, ancestors='0,100,1200')
INSERT INTO sys_dept VALUES (1201, 1200, '0,100,1200', '汉语言文学', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1202, 1200, '0,100,1200', '英语', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1203, 1200, '0,100,1200', '广告学', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1204, 1200, '0,100,1200', '网络与新媒体', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1205, 1200, '0,100,1200', '传播学', 5, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 艺术与设计学院 (ID=1300, ancestors='0,100,1300')
INSERT INTO sys_dept VALUES (1301, 1300, '0,100,1300', '视觉传达设计', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1302, 1300, '0,100,1300', '环境设计', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1303, 1300, '0,100,1300', '产品设计', 3, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1304, 1300, '0,100,1300', '数字媒体艺术', 4, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 马克思主义学院 (ID=1400, ancestors='0,100,1400')
INSERT INTO sys_dept VALUES (1401, 1400, '0,100,1400', '思想政治教育（本科）', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1402, 1400, '0,100,1400', '马克思主义理论类（研究生）', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- 体育学院 (ID=1500, ancestors='0,100,1500')
INSERT INTO sys_dept VALUES (1501, 1500, '0,100,1500', '体育教育', 1, '', '', '', '0', '0', 'admin', sysdate(), '', null);
INSERT INTO sys_dept VALUES (1502, 1500, '0,100,1500', '社会体育指导与管理', 2, '', '', '', '0', '0', 'admin', sysdate(), '', null);

-- ============================================================
-- 更新菜单名称
-- ============================================================
UPDATE sys_menu SET menu_name = '专业管理', remark = '专业管理菜单' WHERE menu_id = 103;
