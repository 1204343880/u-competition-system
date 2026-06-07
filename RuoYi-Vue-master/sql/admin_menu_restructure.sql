-- Admin 菜单重组（幂等版本，可重复执行）
REPLACE INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`remark`)
VALUES (2000,'竞赛管理',0,1,'competition',NULL,NULL,1,0,'M','0','0','','component','admin',NOW(),'竞赛管理父目录');

REPLACE INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`remark`)
VALUES (2010,'知识库管理',0,3,'knowledge-manage',NULL,NULL,1,0,'M','0','0','','education','admin',NOW(),'知识库管理父目录');

REPLACE INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`remark`)
VALUES (2001,'竞赛发布',2000,1,'index','system/competition/index','CompetitionManage',1,0,'C','0','0','system:competition:list','edit','admin',NOW(),'竞赛发布-CRUD');

REPLACE INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`remark`)
VALUES (2002,'成绩管理',2000,4,'result','system/competition/result','CompetitionResult',1,0,'C','0','0','system:competition:manage','form','admin',NOW(),'成绩录入+审核');

UPDATE `sys_menu` SET `parent_id`=2000,`order_num`=2 WHERE `menu_id`=3063;
UPDATE `sys_menu` SET `parent_id`=2000,`order_num`=3 WHERE `menu_id`=3064;
UPDATE `sys_menu` SET `parent_id`=2000,`order_num`=5 WHERE `menu_id`=3065;
UPDATE `sys_menu` SET `parent_id`=2010,`order_num`=1 WHERE `menu_id`=3061;
UPDATE `sys_menu` SET `parent_id`=2010,`order_num`=2 WHERE `menu_id`=3062;
DELETE FROM `sys_menu` WHERE `menu_id`=3060;
UPDATE `sys_menu` SET `order_num`=5 WHERE `menu_id`=1;
UPDATE `sys_menu` SET `visible`='0' WHERE `menu_id` IN (3000,3010,3020,3030,3040,3050,3070);
