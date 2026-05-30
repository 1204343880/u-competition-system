-- =============================================
-- 学科竞赛管理系统 - 数据库初始化脚本
-- 版本：1.0
-- 日期：2026-05-28
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1、部门表（学院/专业）
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept (
  dept_id           bigint(20)      not null auto_increment    comment '部门id',
  parent_id         bigint(20)      default 0                  comment '父部门id',
  ancestors         varchar(50)     default ''                 comment '祖级列表',
  dept_name         varchar(30)     default ''                 comment '部门名称',
  order_num         int(4)          default 0                  comment '显示顺序',
  leader            varchar(20)     default null               comment '负责人',
  phone             varchar(11)     default null               comment '联系电话',
  email             varchar(50)     default null               comment '邮箱',
  status            char(1)         default '0'                comment '部门状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (dept_id)
) engine=innodb auto_increment=200 comment = '部门表';

-- ----------------------------
-- 初始化-部门表数据（学院/专业）
-- ----------------------------
insert into sys_dept values(100,  0,   '0',          '人工智能学院',   1, '张三', '15888888888', 'ai@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(101,  100, '0,100',      '计算机科学与技术', 1, '李四', '15888888889', 'cs@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(102,  100, '0,100',      '软件工程', 2, '王五', '15888888890', 'se@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(103,  100, '0,100',      '人工智能', 3, '赵六', '15888888891', 'ai@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(200,  0,   '0',          '电气工程学院',   2, '孙七', '15888888892', 'ee@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(201,  200, '0,200',      '电气工程及其自动化', 1, '周八', '15888888893', 'eea@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(202,  200, '0,200',      '自动化', 2, '吴九', '15888888894', 'auto@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(300,  0,   '0',          '机械工程学院',   3, '郑十', '15888888895', 'me@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(301,  300, '0,300',      '机械设计制造及其自动化', 1, '钱十一', '15888888896', 'md@tlxy.edu.cn', '0', '0', 'admin', sysdate(), '', null);


-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
  user_id           bigint(20)      not null auto_increment    comment '用户ID',
  dept_id           bigint(20)      default null               comment '部门ID',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  avatar            varchar(100)    default ''                 comment '头像地址',
  password          varchar(100)    default ''                 comment '密码',
  status            char(1)         default '0'                comment '账号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录IP',
  login_date        datetime                                   comment '最后登录时间',
  pwd_update_date   datetime                                   comment '密码最后更新时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- 默认密码：admin123（BCrypt加密）
-- ----------------------------
insert into sys_user values(1,  NULL, 'admin', 'admin', '00', 'admin@tlxy.edu.cn', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '超级管理员');
insert into sys_user values(2,  101, 'teacher01', '张老师', '00', 'teacher01@tlxy.edu.cn', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '计算机学院老师');
insert into sys_user values(3,  101, 'student01', '李四同学', '00', 'student01@tlxy.edu.cn', '15777777777', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '计算机学院学生');
insert into sys_user values(4,  201, 'teacher02', '王老师', '00', 'teacher02@tlxy.edu.cn', '15888888889', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '电气工程学院老师');
insert into sys_user values(5,  201, 'student02', '赵同学', '00', 'student02@tlxy.edu.cn', '15999999999', '2', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), sysdate(), 'admin', sysdate(), '', null, '电气工程学院学生');


-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
drop table if exists sys_post;
create table sys_post
(
  post_id       bigint(20)      not null auto_increment    comment '岗位ID',
  post_code     varchar(64)     not null                   comment '岗位编码',
  post_name     varchar(50)     not null                   comment '岗位名称',
  post_sort     int(4)          not null                   comment '显示顺序',
  status        char(1)         not null                   comment '状态（0正常 1停用）',
  create_by     varchar(64)     default ''                 comment '创建者',
  create_time   datetime                                   comment '创建时间',
  update_by     varchar(64)     default ''			       comment '更新者',
  update_time   datetime                                   comment '更新时间',
  remark        varchar(500)    default null               comment '备注',
  primary key (post_id)
) engine=innodb comment = '岗位信息表';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values(1, 'dean',    '院长',      1, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(2, 'director','系主任',    2, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(3, 'teacher', '教师',      3, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(4, 'student', '学生',      4, '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id            bigint(20)      not null auto_increment    comment '角色ID',
  role_name          varchar(30)     not null                   comment '角色名称',
  role_key           varchar(100)    not null                   comment '角色权限字符串',
  role_sort          int(4)          not null                   comment '显示顺序',
  data_scope         char(1)         default '1'                comment '数据范围（1全部数据权限 2自定数据权限 3本部门数据权限 4本部门及以下数据权限）',
  menu_check_strictly  tinyint(1)     default 1                 comment '菜单树选择项是否关联显示',
  dept_check_strictly  tinyint(1)     default 1                 comment '部门树选择项是否关联显示',
  status             char(1)         not null                   comment '角色状态（0正常 1停用）',
  del_flag           char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by          varchar(64)     default ''                 comment '创建者',
  create_time        datetime                                   comment '创建时间',
  update_by          varchar(64)     default ''                 comment '更新者',
  update_time        datetime                                   comment '更新时间',
  remark             varchar(500)    default null               comment '备注',
  primary key (role_id)
) engine=innodb auto_increment=100 comment = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values(1, '超级管理员', 'admin',     1, '1', 1, 1, '0', '0', 'admin', sysdate(), '', null, '超级管理员');
insert into sys_role values(2, '老师',       'teacher',   2, '2', 1, 1, '0', '0', 'admin', sysdate(), '', null, '老师');
insert into sys_role values(100, '学生',     'student',   3, '1', 1, 1, '0', '0', 'admin', sysdate(), '', null, '学生');


-- ----------------------------
-- 5、菜单信息表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id            bigint(20)      not null auto_increment    comment '菜单ID',
  menu_name          varchar(50)     not null                   comment '菜单名称',
  parent_id          bigint(20)      default 0                  comment '父菜单ID',
  order_num          int(4)          default 0                  comment '显示顺序',
  path               varchar(200)    default ''                 comment '路由地址',
  component          varchar(255)    default ''                 comment '组件路径',
  query              varchar(255)    default ''                 comment '路由参数',
  is_frame           int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache           int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  route_name         varchar(255)    default ''                 comment '路由名称',
  menu_type          char(1)         default ''                 comment '菜单类型（M目录 C菜单 F按钮）',
  visible            char(1)         default '0'                comment '菜单状态（0显示 1隐藏）',
  status             char(1)         default '0'                comment '菜单状态（0正常 1停用）',
  perms              varchar(100)    default ''                 comment '权限标识',
  icon               varchar(100)    default ''                 comment '菜单图标',
  create_by          varchar(64)     default ''                 comment '创建者',
  create_time        datetime                                   comment '创建时间',
  update_by          varchar(64)     default ''                 comment '更新者',
  update_time        datetime                                   comment '更新时间',
  remark             varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=100 comment = '菜单权限表';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
insert into sys_menu values('1', '系统管理', '0', '1', 'system',           null, '', 1, 0, 'M', '0', '0', '', 'system',   'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values('2', '竞赛管理', '0', '2', 'competition',      null, '', 1, 0, 'M', '0', '0', '', 'Trophy',   'admin', sysdate(), '', null, '竞赛管理目录');

-- 系统管理子菜单
insert into sys_menu values('100',  '用户管理', '1',   '1', 'user',       'system/user/index',        '', 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'admin', sysdate(), '', null, '用户管理菜单');
insert into sys_menu values('101',  '角色管理', '1',   '2', 'role',       'system/role/index',        '', 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'admin', sysdate(), '', null, '角色管理菜单');
insert into sys_menu values('102',  '菜单管理', '1',   '3', 'menu',       'system/menu/index',        '', 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'admin', sysdate(), '', null, '菜单管理菜单');
insert into sys_menu values('103',  '学院专业', '1',   '4', 'dept',       'system/dept/index',        '', 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'admin', sysdate(), '', null, '学院专业管理菜单');
insert into sys_menu values('104',  '身份管理', '1',   '5', 'post',       'system/post/index',        '', 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'admin', sysdate(), '', null, '身份管理菜单');
insert into sys_menu values('105',  '字典管理', '1',   '6', 'dict',       'system/dict/index',        '', 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'admin', sysdate(), '', null, '字典管理菜单');
insert into sys_menu values('106',  '参数设置', '1',   '7', 'config',     'system/config/index',      '', 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'admin', sysdate(), '', null, '参数设置菜单');
insert into sys_menu values('107',  '通知公告', '1',   '8', 'notice',     'system/notice/index',      '', 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'admin', sysdate(), '', null, '通知公告菜单');

-- 竞赛管理子菜单
insert into sys_menu values('200',  '竞赛列表', '2',   '1', 'list',       'competition/list/index',   '', 1, 0, 'C', '0', '0', 'competition:list:list',   'List',          'admin', sysdate(), '', null, '竞赛列表菜单');
insert into sys_menu values('201',  '我的竞赛', '2',   '2', 'my',         'competition/my/index',     '', 1, 0, 'C', '0', '0', 'competition:my:list',     'User',          'admin', sysdate(), '', null, '我的竞赛菜单');
insert into sys_menu values('202',  '竞赛报名', '2',   '3', 'apply',      'competition/apply/index',  '', 1, 0, 'C', '0', '0', 'competition:apply:list',  'Edit',          'admin', sysdate(), '', null, '竞赛报名管理菜单');

-- 竞赛列表菜单按钮
insert into sys_menu values('2004', '竞赛列表查询', '200', '1', '', '', '', 1, 0, 'F', '0', '0', 'competition:list:query',    '#', 'admin', sysdate(), '', null, '');

-- 用户管理按钮
insert into sys_menu values('1000', '用户查询', '100', '1', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1001', '用户新增', '100', '2', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1002', '用户修改', '100', '3', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1003', '用户删除', '100', '4', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1004', '用户导出', '100', '5', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1005', '用户导入', '100', '6', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1006', '重置密码', '100', '7', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd',       '#', 'admin', sysdate(), '', null, '');

-- 角色管理按钮
insert into sys_menu values('1007', '角色查询', '101', '1', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1008', '角色新增', '101', '2', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1009', '角色修改', '101', '3', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1010', '角色删除', '101', '4', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1011', '角色导出', '101', '5', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export',         '#', 'admin', sysdate(), '', null, '');

-- 菜单管理按钮
insert into sys_menu values('1012', '菜单查询', '102', '1', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1013', '菜单新增', '102', '2', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1014', '菜单修改', '102', '3', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1015', '菜单删除', '102', '4', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove',         '#', 'admin', sysdate(), '', null, '');

-- 学院专业管理按钮
insert into sys_menu values('1016', '学院查询', '103', '1', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1017', '学院新增', '103', '2', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1018', '学院修改', '103', '3', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1019', '学院删除', '103', '4', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove',         '#', 'admin', sysdate(), '', null, '');

-- 身份管理按钮
insert into sys_menu values('1020', '身份查询', '104', '1', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1021', '身份新增', '104', '2', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1022', '身份修改', '104', '3', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1023', '身份删除', '104', '4', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove',         '#', 'admin', sysdate(), '', null, '');

-- 字典管理按钮
insert into sys_menu values('1025', '字典查询', '105', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1026', '字典新增', '105', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1027', '字典修改', '105', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1028', '字典删除', '105', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove',         '#', 'admin', sysdate(), '', null, '');

-- 参数设置按钮
insert into sys_menu values('1030', '参数查询', '106', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1031', '参数新增', '106', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1032', '参数修改', '106', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1033', '参数删除', '106', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove',       '#', 'admin', sysdate(), '', null, '');

-- 通知公告按钮
insert into sys_menu values('1035', '公告查询', '107', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1036', '公告新增', '107', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1037', '公告修改', '107', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1038', '公告删除', '107', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove',       '#', 'admin', sysdate(), '', null, '');

-- 竞赛列表按钮
insert into sys_menu values('2000', '竞赛查询', '200', '1', '', '', '', 1, 0, 'F', '0', '0', 'competition:list:query',    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2001', '竞赛新增', '200', '2', '', '', '', 1, 0, 'F', '0', '0', 'competition:list:add',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2002', '竞赛修改', '200', '3', '', '', '', 1, 0, 'F', '0', '0', 'competition:list:edit',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2003', '竞赛删除', '200', '4', '', '', '', 1, 0, 'F', '0', '0', 'competition:list:remove',   '#', 'admin', sysdate(), '', null, '');

-- 我的竞赛按钮
insert into sys_menu values('2010', '我的竞赛查询', '201', '1', '', '', '', 1, 0, 'F', '0', '0', 'competition:my:query',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2011', '报名竞赛', '201', '2', '', '', '', 1, 0, 'F', '0', '0', 'competition:my:add',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2012', '取消报名', '201', '3', '', '', '', 1, 0, 'F', '0', '0', 'competition:my:cancel',   '#', 'admin', sysdate(), '', null, '');

-- 竞赛报名管理按钮
insert into sys_menu values('2020', '报名查询', '202', '1', '', '', '', 1, 0, 'F', '0', '0', 'competition:apply:query',  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2021', '审核通过', '202', '2', '', '', '', 1, 0, 'F', '0', '0', 'competition:apply:pass',  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2022', '审核拒绝', '202', '3', '', '', '', 1, 0, 'F', '0', '0', 'competition:apply:reject', '#', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 6、用户和角色关联表
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户ID',
  role_id   bigint(20) not null comment '角色ID',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');   -- admin -> 超级管理员
insert into sys_user_role values ('2', '2');   -- teacher01 -> 老师
insert into sys_user_role values ('3', '100'); -- student01 -> 学生
insert into sys_user_role values ('4', '2');   -- teacher02 -> 老师
insert into sys_user_role values ('5', '100'); -- student02 -> 学生


-- ----------------------------
-- 7、角色和菜单关联表
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色ID',
  menu_id   bigint(20) not null comment '菜单ID',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------

-- 超级管理员（角色ID=1）- 所有权限
insert into sys_role_menu values ('1', '1');
insert into sys_role_menu values ('1', '2');
insert into sys_role_menu values ('1', '100');
insert into sys_role_menu values ('1', '101');
insert into sys_role_menu values ('1', '102');
insert into sys_role_menu values ('1', '103');
insert into sys_role_menu values ('1', '104');
insert into sys_role_menu values ('1', '105');
insert into sys_role_menu values ('1', '106');
insert into sys_role_menu values ('1', '107');
insert into sys_role_menu values ('1', '200');
insert into sys_role_menu values ('1', '201');
insert into sys_role_menu values ('1', '202');
insert into sys_role_menu values ('1', '1000');
insert into sys_role_menu values ('1', '1001');
insert into sys_role_menu values ('1', '1002');
insert into sys_role_menu values ('1', '1003');
insert into sys_role_menu values ('1', '1004');
insert into sys_role_menu values ('1', '1005');
insert into sys_role_menu values ('1', '1006');
insert into sys_role_menu values ('1', '1007');
insert into sys_role_menu values ('1', '1008');
insert into sys_role_menu values ('1', '1009');
insert into sys_role_menu values ('1', '1010');
insert into sys_role_menu values ('1', '1011');
insert into sys_role_menu values ('1', '1012');
insert into sys_role_menu values ('1', '1013');
insert into sys_role_menu values ('1', '1014');
insert into sys_role_menu values ('1', '1015');
insert into sys_role_menu values ('1', '1016');
insert into sys_role_menu values ('1', '1017');
insert into sys_role_menu values ('1', '1018');
insert into sys_role_menu values ('1', '1019');
insert into sys_role_menu values ('1', '1020');
insert into sys_role_menu values ('1', '1021');
insert into sys_role_menu values ('1', '1022');
insert into sys_role_menu values ('1', '1023');
insert into sys_role_menu values ('1', '1025');
insert into sys_role_menu values ('1', '1026');
insert into sys_role_menu values ('1', '1027');
insert into sys_role_menu values ('1', '1028');
insert into sys_role_menu values ('1', '1030');
insert into sys_role_menu values ('1', '1031');
insert into sys_role_menu values ('1', '1032');
insert into sys_role_menu values ('1', '1033');
insert into sys_role_menu values ('1', '1035');
insert into sys_role_menu values ('1', '1036');
insert into sys_role_menu values ('1', '1037');
insert into sys_role_menu values ('1', '1038');
insert into sys_role_menu values ('1', '2000');
insert into sys_role_menu values ('1', '2001');
insert into sys_role_menu values ('1', '2002');
insert into sys_role_menu values ('1', '2003');
insert into sys_role_menu values ('1', '2010');
insert into sys_role_menu values ('1', '2011');
insert into sys_role_menu values ('1', '2012');
insert into sys_role_menu values ('1', '2020');
insert into sys_role_menu values ('1', '2021');
insert into sys_role_menu values ('1', '2022');

-- 老师（角色ID=2）- 部分权限
insert into sys_role_menu values ('2', '2');
insert into sys_role_menu values ('2', '100');
insert into sys_role_menu values ('2', '103');
insert into sys_role_menu values ('2', '200');
insert into sys_role_menu values ('2', '201');
insert into sys_role_menu values ('2', '202');
insert into sys_role_menu values ('2', '1000');
insert into sys_role_menu values ('2', '2000');
insert into sys_role_menu values ('2', '2001');
insert into sys_role_menu values ('2', '2002');
insert into sys_role_menu values ('2', '2010');
insert into sys_role_menu values ('2', '2011');
insert into sys_role_menu values ('2', '2012');
insert into sys_role_menu values ('2', '2020');
insert into sys_role_menu values ('2', '2021');
insert into sys_role_menu values ('2', '2022');

-- 学生（角色ID=100）- 竞赛相关权限
insert into sys_role_menu values ('100', '2');
insert into sys_role_menu values ('100', '200');
insert into sys_role_menu values ('100', '201');
insert into sys_role_menu values ('100', '2000');
insert into sys_role_menu values ('100', '2010');
insert into sys_role_menu values ('100', '2011');
insert into sys_role_menu values ('100', '2012');


-- ----------------------------
-- 8、用户和岗位关联表
-- ----------------------------
drop table if exists sys_user_post;
create table sys_user_post (
  user_id   bigint(20) not null comment '用户ID',
  post_id   bigint(20) not null comment '岗位ID',
  primary key(user_id, post_id)
) engine=innodb comment = '用户和岗位关联表';

-- ----------------------------
-- 初始化-用户和岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');   -- admin -> 院长
insert into sys_user_post values ('2', '3');   -- teacher01 -> 教师
insert into sys_user_post values ('3', '4');   -- student01 -> 学生
insert into sys_user_post values ('4', '3');   -- teacher02 -> 教师
insert into sys_user_post values ('5', '4');   -- student02 -> 学生


-- ----------------------------
-- 9、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type (
  dict_id          bigint(20)      not null auto_increment    comment '字典主键',
  dict_name        varchar(100)    not null                   comment '字典名称',
  dict_type        varchar(100)    not null                   comment '字典类型',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_id),
  unique key uk_dict_type (dict_type)
) engine=innodb auto_increment=100 comment = '字典类型表';

-- ----------------------------
-- 初始化-字典类型表数据
-- ----------------------------
insert into sys_dict_type values('1', '用户性别', 'sys_user_sex', '0', 'admin', sysdate(), '', null, '用户性别');
insert into sys_dict_type values('2', '系统状态', 'sys_normal_disable', '0', 'admin', sysdate(), '', null, '系统状态');
insert into sys_dict_type values('3', '竞赛状态', 'competition_status', '0', 'admin', sysdate(), '', null, '竞赛状态');
insert into sys_dict_type values('4', '审核状态', 'audit_status', '0', 'admin', sysdate(), '', null, '审核状态');
insert into sys_dict_type values('5', '竞赛类别', 'competition_category', '0', 'admin', sysdate(), '', null, '竞赛类别');


-- ----------------------------
-- 10、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data (
  dict_code        bigint(20)      not null auto_increment    comment '字典编码',
  dict_sort        int(4)          default 0                  comment '字典排序',
  dict_label       varchar(100)    not null                   comment '字典标签',
  dict_value       varchar(100)    not null                   comment '字典键值',
  dict_type        varchar(100)    not null                   comment '字典类型',
  css_class        varchar(100)    default ''                 comment '样式属性（其他样式扩展）',
  list_class       varchar(100)    default ''                 comment '表格回显样式',
  is_default       char(1)         default 'N'                comment '是否默认（Y是 N否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_code)
) engine=innodb auto_increment=1000 comment = '字典数据表';

-- ----------------------------
-- 初始化-字典数据表数据
-- ----------------------------
insert into sys_dict_data values('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('4', '1', '正常', '0', 'sys_normal_disable', '', '', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('5', '2', '停用', '1', 'sys_normal_disable', '', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('6', '1', '报名中', '0', 'competition_status', 'success', '', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('7', '2', '进行中', '1', 'competition_status', 'warning', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('8', '3', '已结束', '2', 'competition_status', 'info', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('9', '1', '待审核', '0', 'audit_status', 'info', '', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('10', '2', '通过', '1', 'audit_status', 'success', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('11', '3', '拒绝', '2', 'audit_status', 'danger', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('12', '1', '学科竞赛', '01', 'competition_category', '', '', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('13', '2', '创新创业', '02', 'competition_category', '', '', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values('14', '3', '技能竞赛', '03', 'competition_category', '', '', 'N', '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 11、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
  config_id        bigint(20)      not null auto_increment    comment '参数主键',
  config_name      varchar(100)    not null                   comment '参数名称',
  config_key       varchar(100)    not null                   comment '参数键名',
  config_value     varchar(500)    not null                   comment '参数键值',
  config_type      char(1)         default 'N'                comment '系统内置（Y是 N否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (config_id),
  unique key uk_config_key (config_key)
) engine=innodb auto_increment=100 comment = '参数配置表';

-- ----------------------------
-- 初始化-参数配置表数据
-- ----------------------------
insert into sys_config values('1', '系统名称', 'sys.name', '学科竞赛管理系统', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_config values('2', '系统简介', 'sys.title', '铜陵学院学科竞赛管理平台', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_config values('3', '上传路径', 'sys.upload.path', '/home/ruoyi/uploadPath', 'Y', '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 12、通知公告表
-- ----------------------------
drop table if exists sys_notice;
create table sys_notice (
  notice_id        bigint(20)      not null auto_increment    comment '公告ID',
  notice_title     varchar(50)     not null                   comment '公告标题',
  notice_type      char(1)         default '1'                comment '公告类型（1通知 2公告）',
  notice_content   longtext                                   comment '公告内容',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (notice_id)
) engine=innodb auto_increment=100 comment = '通知公告表';

-- ----------------------------
-- 初始化-通知公告表数据
-- ----------------------------
insert into sys_notice values('1', '欢迎使用学科竞赛管理系统', '1', '<p>欢迎使用铜陵学院学科竞赛管理平台！</p><p>本系统用于管理和组织各类学科竞赛活动。</p><p>如有任何问题，请联系管理员。</p>', '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 13、竞赛信息表
-- ----------------------------
drop table if exists competition;
create table competition (
  competition_id        bigint(20)      not null auto_increment    comment '竞赛ID',
  competition_name      varchar(100)    not null                   comment '竞赛名称',
  category             varchar(50)     default ''                 comment '竞赛类别',
  category_name        varchar(50)     default ''                 comment '类别名称',
  description          varchar(500)    default ''                 comment '竞赛描述',
  apply_start_time     datetime                                   comment '报名开始时间',
  apply_end_time       datetime                                   comment '报名结束时间',
  start_time           datetime                                   comment '竞赛开始时间',
  end_time             datetime                                   comment '竞赛结束时间',
  status               char(1)         default '0'                comment '竞赛状态（0报名中 1进行中 2已结束）',
  organizer            varchar(100)    default ''                 comment '主办方',
  host                 varchar(100)    default ''                 comment '承办方',
  max_participants     int(11)         default 0                  comment '参赛人数限制',
  current_participants int(11)         default 0                  comment '当前报名人数',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  primary key (competition_id)
) engine=innodb auto_increment=100 comment = '竞赛信息表';

-- ----------------------------
-- 初始化-竞赛信息表数据
-- ----------------------------
insert into competition (competition_name, category, category_name, description, apply_start_time, apply_end_time, start_time, end_time, status, organizer, host, max_participants)
VALUES ('全国大学生数学建模竞赛', '01', '学科竞赛', '全国大学生数学建模竞赛是由教育部高等教育司和中国工业与应用数学学会共同主办的面向全国大学生的群众性科技活动。', 
        '2026-06-01 00:00:00', '2026-09-15 23:59:59', '2026-09-20 08:00:00', '2026-09-23 18:00:00', '0', '教育部', '中国工业与应用数学学会', 50000);

insert into competition (competition_name, category, category_name, description, apply_start_time, apply_end_time, start_time, end_time, status, organizer, host, max_participants)
VALUES ('中国大学生计算机设计大赛', '01', '学科竞赛', '中国大学生计算机设计大赛是面向全国高校在校学生的科技类竞赛活动。', 
        '2026-05-01 00:00:00', '2026-07-31 23:59:59', '2026-08-15 08:00:00', '2026-08-20 18:00:00', '0', '教育部', '中国高等教育学会', 30000);

insert into competition (competition_name, category, category_name, description, apply_start_time, apply_end_time, start_time, end_time, status, organizer, host, max_participants)
VALUES ('互联网+大学生创新创业大赛', '02', '创新创业', '中国国际"互联网+"大学生创新创业大赛是由教育部等多部委共同主办的国家级创新创业赛事。', 
        '2026-04-01 00:00:00', '2026-06-30 23:59:59', '2026-07-15 08:00:00', '2026-07-20 18:00:00', '1', '教育部', '各高校', 100000);

insert into competition (competition_name, category, category_name, description, apply_start_time, apply_end_time, start_time, end_time, status, organizer, host, max_participants)
VALUES ('全国大学生电子设计竞赛', '03', '技能竞赛', '全国大学生电子设计竞赛是面向全国大学生的电子信息类学科竞赛。', 
        '2026-03-01 00:00:00', '2026-08-31 23:59:59', '2026-09-08 08:00:00', '2026-09-11 18:00:00', '2', '教育部', '高等学校电子信息类专业教学指导委员会', 20000);


-- ----------------------------
-- 14、竞赛报名表
-- ----------------------------
drop table if exists competition_apply;
create table competition_apply (
  apply_id             bigint(20)      not null auto_increment    comment '报名ID',
  competition_id       bigint(20)      not null                   comment '竞赛ID',
  user_id              bigint(20)      not null                   comment '用户ID',
  user_name            varchar(30)     not null                   comment '用户名称',
  nick_name            varchar(30)     not null                   comment '用户昵称',
  team_name            varchar(50)     default ''                 comment '团队名称',
  team_members         varchar(200)    default ''                 comment '团队成员',
  apply_time           datetime                                   comment '报名时间',
  audit_status         char(1)         default '0'                comment '审核状态（0待审核 1通过 2拒绝）',
  audit_time           datetime                                   comment '审核时间',
  audit_remark         varchar(500)    default ''                 comment '审核意见',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  primary key (apply_id)
) engine=innodb comment = '竞赛报名表';

-- ----------------------------
-- 初始化-竞赛报名表数据
-- ----------------------------
insert into competition_apply (competition_id, user_id, user_name, nick_name, team_name, team_members, apply_time, audit_status)
VALUES (100, 3, 'student01', '李四同学', '创新团队', '李四同学,张三同学,王五同学', sysdate(), '1');

insert into competition_apply (competition_id, user_id, user_name, nick_name, team_name, team_members, apply_time, audit_status)
VALUES (100, 5, 'student02', '赵同学', '智慧队', '赵同学,钱同学,孙同学', sysdate(), '0');

insert into competition_apply (competition_id, user_id, user_name, nick_name, team_name, team_members, apply_time, audit_status)
VALUES (101, 3, 'student01', '李四同学', '代码先锋队', '李四同学', sysdate(), '1');


SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- SQL脚本执行完成
-- 系统默认账户：
--   用户名: admin  密码: admin123
--   用户名: teacher01  密码: admin123
--   用户名: student01  密码: admin123
-- =============================================