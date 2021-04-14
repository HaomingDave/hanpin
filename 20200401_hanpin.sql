-- --------------------------------------------------------
-- 主机:                           localhost
-- 服务器版本:                        5.7.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 hanpin 的数据库结构
CREATE DATABASE IF NOT EXISTS `hanpin` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hanpin`;

-- 导出  表 hanpin.fa_admin 结构
CREATE TABLE IF NOT EXISTS `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- 正在导出表  hanpin.fa_admin 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_admin` DISABLE KEYS */;
INSERT INTO `fa_admin` (`id`, `username`, `nickname`, `password`, `salt`, `avatar`, `email`, `loginfailure`, `logintime`, `loginip`, `createtime`, `updatetime`, `token`, `status`) VALUES
	(1, 'admin', 'Admin', 'fde270ec1ce510de56745c51aec333df', '79b58a', '/assets/img/avatar.png', '532988500@qq.com', 0, 1585711306, '127.0.0.1', 1492186163, 1585711306, 'f475ff1b-3ba7-4da3-9f49-6f5e28a67d9c', 'normal');
/*!40000 ALTER TABLE `fa_admin` ENABLE KEYS */;

-- 导出  表 hanpin.fa_admin_log 结构
CREATE TABLE IF NOT EXISTS `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='管理员日志表';

-- 正在导出表  hanpin.fa_admin_log 的数据：~41 rows (大约)
/*!40000 ALTER TABLE `fa_admin_log` DISABLE KEYS */;
INSERT INTO `fa_admin_log` (`id`, `admin_id`, `username`, `url`, `title`, `content`, `ip`, `useragent`, `createtime`) VALUES
	(1, 1, 'admin', '/QPpNbWlorZ.php/index/login?url=%2FQPpNbWlorZ.php', '登录', '{"url":"\\/QPpNbWlorZ.php","__token__":"31c1cdd9b43ab4f557843d779552b675","username":"admin","captcha":"wkfp"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585567750),
	(2, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/del/ids/121', '权限管理 菜单规则 删除', '{"action":"del","ids":"121","params":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569393),
	(3, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569393),
	(4, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/edit/ids/103?dialog=1', '权限管理 菜单规则 编辑', '{"dialog":"1","__token__":"b28b4454eb1b85d8b405e737f30be36e","row":{"ismenu":"1","pid":"0","name":"project","title":"\\u9879\\u76ee\\u7ba1\\u7406","icon":"fa fa-circle-o","weigh":"0","condition":"","remark":"","status":"normal"},"ids":"103"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569925),
	(5, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569925),
	(6, 1, 'admin', '/QPpNbWlorZ.php/ajax/weigh', '', '{"ids":"1,2,6,7,8,3,5,9,10,11,12,4,66,67,73,79,103,85,94,112,130,139","changeid":"103","pid":"0","field":"weigh","orderway":"desc","table":"auth_rule","pk":"id"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569937),
	(7, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569937),
	(8, 1, 'admin', '/QPpNbWlorZ.php/ajax/weigh', '', '{"ids":"1,2,6,7,8,3,5,9,10,11,12,4,66,67,73,79,103,85,94,112,130,139","changeid":"103","pid":"0","field":"weigh","orderway":"desc","table":"auth_rule","pk":"id"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569949),
	(9, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569949),
	(10, 1, 'admin', '/QPpNbWlorZ.php/ajax/weigh', '', '{"ids":"1,2,6,7,8,3,5,9,10,11,12,4,66,67,73,79,103,85,94,112,130,139","changeid":"103","pid":"0","field":"weigh","orderway":"desc","table":"auth_rule","pk":"id"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569965),
	(11, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585569966),
	(12, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/edit/ids/139?dialog=1', '权限管理 菜单规则 编辑', '{"dialog":"1","__token__":"a09de501c932167142e321ccf0666c33","row":{"ismenu":"1","pid":"103","name":"project_record","title":"\\u9879\\u76ee\\u8bb0\\u5f55","icon":"fa fa-circle-o","weigh":"0","condition":"","remark":"","status":"normal"},"ids":"139"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585570019),
	(13, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585570019),
	(14, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/edit/ids/130?dialog=1', '权限管理 菜单规则 编辑', '{"dialog":"1","__token__":"e298c6d460f7f1377477604431aa23b6","row":{"ismenu":"1","pid":"103","name":"project_check","title":"\\u65bd\\u5de5\\u524d\\u68c0\\u67e5","icon":"fa fa-circle-o","weigh":"0","condition":"","remark":"","status":"normal"},"ids":"130"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585570050),
	(15, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585570051),
	(16, 1, 'admin', '/QPpNbWlorZ.php/index/login?url=%2FQPpNbWlorZ.php', '登录', '{"url":"\\/QPpNbWlorZ.php","__token__":"3692384982aaf5bd33e950cbd0a1ea5a","username":"admin","captcha":"gjyg"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585710282),
	(17, 1, 'admin', '/QPpNbWlorZ.php/index/login?url=%2FQPpNbWlorZ.php', '登录', '{"url":"\\/QPpNbWlorZ.php","__token__":"4edd7bbed26fe6dc0859985ff2ffe58c","username":"admin","captcha":"vuur"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585711306),
	(18, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/del/ids/85,94,103,130,139,112', '权限管理 菜单规则 删除', '{"action":"del","ids":"85,94,103,130,139,112","params":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585717908),
	(19, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585717908),
	(20, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u5546","contacts":"\\u9f9a\\u5148\\u751f","mobile":"133","address":"","order":"0"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585718470),
	(21, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u5546","contacts":"222","mobile":"22","address":"","order":"0"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585718821),
	(22, 1, 'admin', '/QPpNbWlorZ.php/auth/rule/del/ids/148,157,166,175,184,193', '权限管理 菜单规则 删除', '{"action":"del","ids":"148,157,166,175,184,193","params":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585719744),
	(23, 1, 'admin', '/QPpNbWlorZ.php/index/index', '', '{"action":"refreshmenu"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585719744),
	(24, 1, 'admin', '/QPpNbWlorZ.php/supplier/restore/ids/2,1', '供货商管理 还原', '{"action":"restore","ids":"2,1","params":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720132),
	(25, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u6d4b\\u8bd5\\u8054\\u7cfb\\u4eba","mobile":"13327732264","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720189),
	(26, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u8054\\u7cfb\\u4eba","mobile":"13327763322","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720254),
	(27, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u8054\\u7cfb\\u4eba","mobile":"13327762222","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720297),
	(28, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u8054\\u7cfb\\u4eba","mobile":"13327762222","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720307),
	(29, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u8054\\u7cfb\\u4eba","mobile":"13327762222","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720336),
	(30, 1, 'admin', '/QPpNbWlorZ.php/supplier/add?dialog=1', '供货商管理 添加', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u55462","contacts":"\\u8054\\u7cfb\\u4eba","mobile":"13327762222","address":"","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720378),
	(31, 1, 'admin', '/QPpNbWlorZ.php/supplier/restore/ids/3', '供货商管理 还原', '{"action":"restore","ids":"3","params":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585720630),
	(32, 1, 'admin', '/QPpNbWlorZ.php/supplier/edit/ids/2?dialog=1', '供货商管理 编辑', '{"dialog":"1","row":{"name":"\\u6d4b\\u8bd5\\u4f9b\\u8d27\\u5546","contacts":"222","mobile":"13327763225","address":"","order":"2","status":"normal"},"ids":"2"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585721012),
	(33, 1, 'admin', '/QPpNbWlorZ.php/material/add?dialog=1', '材料管理 添加', '{"dialog":"1","row":{"name":"\\u6750\\u65991","model":"AC0000","specifications":"000000","brand":"\\u6750\\u6599\\u54c1\\u724c","unit":"0","order":"0","status":"normal"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585722008),
	(34, 1, 'admin', '/QPpNbWlorZ.php/material/edit/ids/1?dialog=1', '材料管理 编辑', '{"dialog":"1","row":{"name":"\\u6750\\u65991","model":"AC0000","specifications":"000000","brand":"\\u6750\\u6599\\u54c1\\u724c","unit":"22","order":"33","status":"normal"},"ids":"1"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585722027),
	(35, 1, 'admin', '/QPpNbWlorZ.php/supplier/selectpage', '供货商管理', '{"q_word":[""],"pageNumber":"1","pageSize":"10","andOr":"AND","orderBy":[["name","ASC"]],"searchTable":"tbl","showField":"name","keyField":"id","searchField":["name"],"name":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725416),
	(36, 1, 'admin', '/QPpNbWlorZ.php/supplier/selectpage', '供货商管理', '{"q_word":[""],"pageNumber":"1","pageSize":"10","andOr":"AND","orderBy":[["name","ASC"]],"searchTable":"tbl","showField":"name","keyField":"id","searchField":["name"],"name":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725419),
	(37, 1, 'admin', '/QPpNbWlorZ.php/material/selectpage', '材料管理', '{"q_word":[""],"pageNumber":"1","pageSize":"10","andOr":"AND","orderBy":[["name","ASC"]],"searchTable":"tbl","showField":"name","keyField":"id","searchField":["name"],"name":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725501),
	(38, 1, 'admin', '/QPpNbWlorZ.php/supplier/selectpage', '供货商管理', '{"q_word":[""],"pageNumber":"1","pageSize":"10","andOr":"AND","orderBy":[["name","ASC"]],"searchTable":"tbl","showField":"name","keyField":"id","searchField":["name"],"name":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725503),
	(39, 1, 'admin', '/QPpNbWlorZ.php/material_purchase/add?dialog=1', '材料采购 添加', '{"dialog":"1","row":{"mp_numer":"22222","mp_type":"22","mp_type_cn":"22","mp_ghs_id":"2","mp_cl_id":"1","mp_budget_quantity":"0","mp_purchased_quantity":"0","mp_sq_quantity":"0","mp_unit":"0","mp_total":"0.00","mp_applicant":"333","mp_applicant_time":"2020-04-01 15:18:19","mp_auditor":"","mp_audit_time":"2020-04-01 15:18:19","mp_fhrqr":"","mp_fh_time":"2020-04-01 15:18:19","mp_cwqr":"","mp_cwqr_time":"2020-04-01 15:18:19","mp_ysje":"0.00","mp_dfje":"0.00","mp_yfje":"0.00","mp_remark":"","order":"0"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725520),
	(40, 1, 'admin', '/QPpNbWlorZ.php/supplier/selectpage', '供货商管理', '{"searchTable":"tbl","searchKey":"id","searchValue":"2","orderBy":[["name","ASC"]],"showField":"name","keyField":"id","keyValue":"2","searchField":["name"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725569),
	(41, 1, 'admin', '/QPpNbWlorZ.php/material/selectpage', '材料管理', '{"searchTable":"tbl","searchKey":"id","searchValue":"1","orderBy":[["name","ASC"]],"showField":"name","keyField":"id","keyValue":"1","searchField":["name"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 1585725569);
/*!40000 ALTER TABLE `fa_admin_log` ENABLE KEYS */;

-- 导出  表 hanpin.fa_attachment 结构
CREATE TABLE IF NOT EXISTS `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) DEFAULT NULL COMMENT '创建日期',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` int(10) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='附件表';

-- 正在导出表  hanpin.fa_attachment 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_attachment` DISABLE KEYS */;
INSERT INTO `fa_attachment` (`id`, `admin_id`, `user_id`, `url`, `imagewidth`, `imageheight`, `imagetype`, `imageframes`, `filesize`, `mimetype`, `extparam`, `createtime`, `updatetime`, `uploadtime`, `storage`, `sha1`) VALUES
	(1, 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 21859, 'image/png', '', 1499681848, 1499681848, 1499681848, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
/*!40000 ALTER TABLE `fa_attachment` ENABLE KEYS */;

-- 导出  表 hanpin.fa_attachments 结构
CREATE TABLE IF NOT EXISTS `fa_attachments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `foreignid` bigint(20) DEFAULT NULL COMMENT '外键id',
  `code` varchar(50) DEFAULT NULL COMMENT '标识',
  `origname` varchar(200) DEFAULT NULL COMMENT '附件原始名',
  `suffix` varchar(50) DEFAULT NULL COMMENT '附件后缀',
  `serpath` varchar(500) DEFAULT NULL COMMENT '服务器路径',
  `thumbpath` varchar(500) DEFAULT NULL COMMENT '略缩图路径',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `createtime` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `create_userid` bigint(20) DEFAULT NULL COMMENT '用户id',
  `create_username` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `default_flag` int(11) DEFAULT '0' COMMENT '封面图 0 否 1是',
  `deletetime` int(10) DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

-- 正在导出表  hanpin.fa_attachments 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_attachments` ENABLE KEYS */;

-- 导出  表 hanpin.fa_attachments_type 结构
CREATE TABLE IF NOT EXISTS `fa_attachments_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID  ',
  `att_type` varchar(50) DEFAULT NULL COMMENT '附件类型 ',
  `code` varchar(50) DEFAULT NULL COMMENT '标识',
  `name` varchar(500) DEFAULT NULL COMMENT '类型名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件分类表';

-- 正在导出表  hanpin.fa_attachments_type 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_attachments_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_attachments_type` ENABLE KEYS */;

-- 导出  表 hanpin.fa_auth_group 结构
CREATE TABLE IF NOT EXISTS `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='分组表';

-- 正在导出表  hanpin.fa_auth_group 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `fa_auth_group` DISABLE KEYS */;
INSERT INTO `fa_auth_group` (`id`, `pid`, `name`, `rules`, `createtime`, `updatetime`, `status`) VALUES
	(1, 0, 'Admin group', '*', 1490883540, 149088354, 'normal'),
	(2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1490883540, 1505465692, 'normal'),
	(3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1490883540, 1502205322, 'normal'),
	(4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1490883540, 1502205350, 'normal'),
	(5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1490883540, 1502205344, 'normal');
/*!40000 ALTER TABLE `fa_auth_group` ENABLE KEYS */;

-- 导出  表 hanpin.fa_auth_group_access 结构
CREATE TABLE IF NOT EXISTS `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限分组表';

-- 正在导出表  hanpin.fa_auth_group_access 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_auth_group_access` DISABLE KEYS */;
INSERT INTO `fa_auth_group_access` (`uid`, `group_id`) VALUES
	(1, 1);
/*!40000 ALTER TABLE `fa_auth_group_access` ENABLE KEYS */;

-- 导出  表 hanpin.fa_auth_rule 结构
CREATE TABLE IF NOT EXISTS `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='节点表';

-- 正在导出表  hanpin.fa_auth_rule 的数据：~136 rows (大约)
/*!40000 ALTER TABLE `fa_auth_rule` DISABLE KEYS */;
INSERT INTO `fa_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES
	(1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', 'Dashboard tips', 1, 1497429920, 1497429920, 143, 'normal'),
	(2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', 1, 1497429920, 1497430169, 137, 'normal'),
	(3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', 'Category tips', 1, 1497429920, 1497429920, 119, 'normal'),
	(4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', 1, 1502035509, 1502035509, 0, 'normal'),
	(5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', 1, 1497429920, 1497430092, 99, 'normal'),
	(6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', 'Config tips', 1, 1497429920, 1497430683, 60, 'normal'),
	(7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', 1, 1497429920, 1497430699, 53, 'normal'),
	(8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', 1, 1497429920, 1497429920, 34, 'normal'),
	(9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', 'Admin tips', 1, 1497429920, 1497430320, 118, 'normal'),
	(10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', 'Admin log tips', 1, 1497429920, 1497430307, 113, 'normal'),
	(11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', 1, 1497429920, 1497429920, 109, 'normal'),
	(12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', 1, 1497429920, 1497430581, 104, 'normal'),
	(13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 136, 'normal'),
	(14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 135, 'normal'),
	(15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 133, 'normal'),
	(16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 134, 'normal'),
	(17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 132, 'normal'),
	(18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 52, 'normal'),
	(19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 51, 'normal'),
	(20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 50, 'normal'),
	(21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 49, 'normal'),
	(22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 48, 'normal'),
	(23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', 'Attachment tips', 0, 1497429920, 1497429920, 59, 'normal'),
	(24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 58, 'normal'),
	(25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 57, 'normal'),
	(26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 56, 'normal'),
	(27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 55, 'normal'),
	(28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 54, 'normal'),
	(29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 33, 'normal'),
	(30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 32, 'normal'),
	(31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 31, 'normal'),
	(32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 30, 'normal'),
	(33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 29, 'normal'),
	(34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 28, 'normal'),
	(35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', 'Category tips', 0, 1497429920, 1497429920, 142, 'normal'),
	(36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 141, 'normal'),
	(37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 140, 'normal'),
	(38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 139, 'normal'),
	(39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 138, 'normal'),
	(40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', 0, 1497429920, 1497429920, 117, 'normal'),
	(41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 116, 'normal'),
	(42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 115, 'normal'),
	(43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 114, 'normal'),
	(44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', 0, 1497429920, 1497429920, 112, 'normal'),
	(45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 111, 'normal'),
	(46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 110, 'normal'),
	(47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', 'Group tips', 0, 1497429920, 1497429920, 108, 'normal'),
	(48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 107, 'normal'),
	(49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 106, 'normal'),
	(50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 105, 'normal'),
	(51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', 0, 1497429920, 1497429920, 103, 'normal'),
	(52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 102, 'normal'),
	(53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 101, 'normal'),
	(54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 100, 'normal'),
	(55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', 'Addon tips', 0, 1502035509, 1502035509, 0, 'normal'),
	(56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal'),
	(66, 'file', 0, 'user', 'User', 'fa fa-list', '', '', 1, 1516374729, 1516374729, 0, 'normal'),
	(67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', 1, 1516374729, 1516374729, 0, 'normal'),
	(68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', 1, 1516374729, 1516374729, 0, 'normal'),
	(74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', 1, 1516374729, 1516374729, 0, 'normal'),
	(80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal'),
	(85, 'file', 0, 'project', '项目', 'fa fa-circle-o\r', '', '', 1, 1585719907, 1585719907, 0, 'normal'),
	(86, 'file', 85, 'project/index', '查看', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(87, 'file', 85, 'project/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(88, 'file', 85, 'project/add', '添加', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(89, 'file', 85, 'project/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(90, 'file', 85, 'project/del', '删除', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(91, 'file', 85, 'project/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(92, 'file', 85, 'project/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(93, 'file', 85, 'project/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585719907, 1585719983, 0, 'normal'),
	(94, 'file', 0, 'project_check', '施工前检查管理', 'fa fa-circle-o\r', '', '', 1, 1585720003, 1585720003, 0, 'normal'),
	(95, 'file', 94, 'project_check/index', '查看', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(96, 'file', 94, 'project_check/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(97, 'file', 94, 'project_check/add', '添加', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(98, 'file', 94, 'project_check/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(99, 'file', 94, 'project_check/del', '删除', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(100, 'file', 94, 'project_check/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(101, 'file', 94, 'project_check/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(102, 'file', 94, 'project_check/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585720003, 1585720003, 0, 'normal'),
	(103, 'file', 0, 'project_record', '项目记录', 'fa fa-circle-o\r', '', '', 1, 1585720020, 1585720020, 0, 'normal'),
	(104, 'file', 103, 'project_record/index', '查看', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(105, 'file', 103, 'project_record/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(106, 'file', 103, 'project_record/add', '添加', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(107, 'file', 103, 'project_record/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(108, 'file', 103, 'project_record/del', '删除', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(109, 'file', 103, 'project_record/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(110, 'file', 103, 'project_record/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(111, 'file', 103, 'project_record/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585720020, 1585720020, 0, 'normal'),
	(112, 'file', 0, 'material_purchase', '材料采购', 'fa fa-circle-o\r', '', '', 1, 1585720042, 1585720042, 0, 'normal'),
	(113, 'file', 112, 'material_purchase/index', '查看', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(114, 'file', 112, 'material_purchase/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(115, 'file', 112, 'material_purchase/add', '添加', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(116, 'file', 112, 'material_purchase/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(117, 'file', 112, 'material_purchase/del', '删除', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(118, 'file', 112, 'material_purchase/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(119, 'file', 112, 'material_purchase/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(120, 'file', 112, 'material_purchase/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585720042, 1585720042, 0, 'normal'),
	(121, 'file', 0, 'supplier', '供货商管理', 'fa fa-circle-o\r', '', '', 1, 1585720047, 1585720047, 0, 'normal'),
	(122, 'file', 121, 'supplier/index', '查看', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(123, 'file', 121, 'supplier/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(124, 'file', 121, 'supplier/add', '添加', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(125, 'file', 121, 'supplier/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(126, 'file', 121, 'supplier/del', '删除', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(127, 'file', 121, 'supplier/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(128, 'file', 121, 'supplier/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(129, 'file', 121, 'supplier/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585720047, 1585720047, 0, 'normal'),
	(130, 'file', 0, 'material', '材料管理', 'fa fa-circle-o\r', '', '', 1, 1585720050, 1585720050, 0, 'normal'),
	(131, 'file', 130, 'material/index', '查看', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(132, 'file', 130, 'material/recyclebin', '回收站', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(133, 'file', 130, 'material/add', '添加', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(134, 'file', 130, 'material/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(135, 'file', 130, 'material/del', '删除', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(136, 'file', 130, 'material/destroy', '真实删除', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(137, 'file', 130, 'material/restore', '还原', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal'),
	(138, 'file', 130, 'material/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1585720050, 1585720050, 0, 'normal');
/*!40000 ALTER TABLE `fa_auth_rule` ENABLE KEYS */;

-- 导出  表 hanpin.fa_category 结构
CREATE TABLE IF NOT EXISTS `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) NOT NULL DEFAULT '',
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- 正在导出表  hanpin.fa_category 的数据：~13 rows (大约)
/*!40000 ALTER TABLE `fa_category` DISABLE KEYS */;
INSERT INTO `fa_category` (`id`, `pid`, `type`, `name`, `nickname`, `flag`, `image`, `keywords`, `description`, `diyname`, `createtime`, `updatetime`, `weigh`, `status`) VALUES
	(1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1495262190, 1495262190, 1, 'normal'),
	(2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1495262244, 1495262244, 2, 'normal'),
	(3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1495262288, 1495262288, 3, 'normal'),
	(4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1495262317, 1495262317, 4, 'normal'),
	(5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1495262336, 1499681850, 5, 'normal'),
	(6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1495262357, 1495262357, 6, 'normal'),
	(7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1495262391, 1495262391, 7, 'normal'),
	(8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1495262424, 1495262424, 8, 'normal'),
	(9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1495262456, 1495262456, 9, 'normal'),
	(10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1495262487, 1495262487, 10, 'normal'),
	(11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1495262515, 1495262515, 11, 'normal'),
	(12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1497015727, 1497015727, 12, 'normal'),
	(13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1497015738, 1497015738, 13, 'normal');
/*!40000 ALTER TABLE `fa_category` ENABLE KEYS */;

-- 导出  表 hanpin.fa_config 结构
CREATE TABLE IF NOT EXISTS `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `content` text NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='系统配置';

-- 正在导出表  hanpin.fa_config 的数据：~17 rows (大约)
/*!40000 ALTER TABLE `fa_config` DISABLE KEYS */;
INSERT INTO `fa_config` (`id`, `name`, `group`, `title`, `tip`, `type`, `value`, `content`, `rule`, `extend`) VALUES
	(1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '我的网站', '', 'required', ''),
	(2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', ''),
	(3, 'cdnurl', 'basic', 'Cdn url', '如果静态资源使用第三方云储存请配置该值', 'string', '', '', '', ''),
	(4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', ''),
	(5, 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', ''),
	(6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', ''),
	(7, 'languages', 'basic', 'Languages', '', 'array', '{"backend":"zh-cn","frontend":"zh-cn"}', '', 'required', ''),
	(8, 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', ''),
	(9, 'categorytype', 'dictionary', 'Category type', '', 'array', '{"default":"Default","page":"Page","article":"Article","test":"Test"}', '', '', ''),
	(10, 'configgroup', 'dictionary', 'Config group', '', 'array', '{"basic":"Basic","email":"Email","dictionary":"Dictionary","user":"User","example":"Example"}', '', '', ''),
	(11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '["Please select","SMTP","Mail"]', '', ''),
	(12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', ''),
	(13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', ''),
	(14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', ''),
	(15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码）', 'string', 'password', '', '', ''),
	(16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '["None","TLS","SSL"]', '', ''),
	(17, 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '');
/*!40000 ALTER TABLE `fa_config` ENABLE KEYS */;

-- 导出  表 hanpin.fa_ems 结构
CREATE TABLE IF NOT EXISTS `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮箱验证码表';

-- 正在导出表  hanpin.fa_ems 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_ems` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_ems` ENABLE KEYS */;

-- 导出  表 hanpin.fa_material 结构
CREATE TABLE IF NOT EXISTS `fa_material` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '材料名称',
  `model` varchar(100) NOT NULL COMMENT '材料型号',
  `specifications` varchar(100) NOT NULL COMMENT '材料规格',
  `brand` varchar(100) NOT NULL COMMENT '材料品牌',
  `unit` decimal(18,0) NOT NULL DEFAULT '0' COMMENT '单价',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='材料表';

-- 正在导出表  hanpin.fa_material 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `fa_material` DISABLE KEYS */;
INSERT INTO `fa_material` (`id`, `name`, `model`, `specifications`, `brand`, `unit`, `order`, `status`, `createtime`, `deletetime`) VALUES
	(1, '材料1', 'AC0000', '000000', '材料品牌', 22, 33, 'normal', 1585722008, NULL);
/*!40000 ALTER TABLE `fa_material` ENABLE KEYS */;

-- 导出  表 hanpin.fa_material_purchase 结构
CREATE TABLE IF NOT EXISTS `fa_material_purchase` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mp_numer` varchar(20) NOT NULL COMMENT '编号',
  `mp_type` int(10) NOT NULL COMMENT '类型id',
  `mp_type_cn` varchar(100) NOT NULL COMMENT '类型中文',
  `mp_ghs_id` int(10) NOT NULL DEFAULT '0' COMMENT '供货商',
  `mp_cl_id` int(10) NOT NULL DEFAULT '0' COMMENT '材料',
  `mp_budget_quantity` int(10) NOT NULL DEFAULT '0' COMMENT '预算数量',
  `mp_purchased_quantity` int(10) NOT NULL DEFAULT '0' COMMENT '已购数量',
  `mp_sq_quantity` int(10) DEFAULT '0' COMMENT '申请数量',
  `mp_unit` decimal(18,0) NOT NULL DEFAULT '0' COMMENT '单价',
  `mp_total` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '合计价',
  `mp_applicant` varchar(100) NOT NULL COMMENT '申请人',
  `mp_applicant_time` int(11) NOT NULL DEFAULT '0' COMMENT '申请日期',
  `mp_auditor` varchar(100) DEFAULT NULL COMMENT '审核人',
  `mp_audit_time` int(11) DEFAULT '0' COMMENT '审核日期',
  `mp_fhrqr` varchar(100) DEFAULT NULL COMMENT '发货人',
  `mp_fh_time` int(11) DEFAULT '0' COMMENT '发货日期',
  `mp_cwqr` varchar(100) DEFAULT NULL COMMENT '财务确认',
  `mp_cwqr_time` int(11) DEFAULT '0' COMMENT '财务确认时间',
  `mp_ysje` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '预算金额',
  `mp_dfje` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '待付金额',
  `mp_yfje` decimal(18,2) DEFAULT '0.00' COMMENT '已付金额',
  `mp_remark` text COMMENT '备注',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `mp_numer` (`mp_numer`),
  KEY `mp_ghs_id` (`mp_ghs_id`),
  KEY `mp_cl_id` (`mp_cl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='材料采购';

-- 正在导出表  hanpin.fa_material_purchase 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_material_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_material_purchase` ENABLE KEYS */;

-- 导出  表 hanpin.fa_project 结构
CREATE TABLE IF NOT EXISTS `fa_project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '项目名',
  `manager` varchar(100) NOT NULL COMMENT '项目经理',
  `mobile` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) DEFAULT NULL COMMENT '结束时间',
  `gong_qi` varchar(100) NOT NULL COMMENT '工期',
  `image` varchar(200) DEFAULT NULL COMMENT '缩略图',
  `progress` varchar(200) DEFAULT NULL COMMENT '项目进度',
  `introduction` text COMMENT '项目描述',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目';

-- 正在导出表  hanpin.fa_project 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_project` ENABLE KEYS */;

-- 导出  表 hanpin.fa_project_check 结构
CREATE TABLE IF NOT EXISTS `fa_project_check` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '项目名',
  `sgtxgt` enum('是','否') NOT NULL DEFAULT '是' COMMENT '施工图、效果图',
  `check_remark1` text COMMENT '备      注',
  `sgjdb` enum('是','否') NOT NULL DEFAULT '是' COMMENT '施工进度表',
  `check_remark2` text COMMENT '备      注',
  `sgzcwd` enum('是','否') NOT NULL DEFAULT '是' COMMENT '施工组织计划文档',
  `check_remark3` text COMMENT '备      注',
  `gywd` enum('是','否') NOT NULL DEFAULT '是' COMMENT '相对应施工工艺文档',
  `check_remark4` text COMMENT '备      注',
  `sxgcl` enum('是','否') NOT NULL DEFAULT '是' COMMENT '熟悉本项目的预算范围及工程量',
  `check_remark5` text COMMENT '备      注',
  `clxyzb` enum('是','否') NOT NULL DEFAULT '是' COMMENT '材料小样准备',
  `check_remark6` text COMMENT '备      注',
  `ysfwhgcl` enum('是','否') NOT NULL DEFAULT '是' COMMENT '下包方合同、及下包的预算范围及工程量',
  `check_remark7` text COMMENT '备      注',
  `wmsdqz` enum('是','否') NOT NULL DEFAULT '是' COMMENT '下包方安全、消防协议、安全文明宣导签章',
  `check_remark8` text COMMENT '备      注',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `FK_fa_project_check_fa_project` FOREIGN KEY (`pid`) REFERENCES `fa_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='施工前检查表';

-- 正在导出表  hanpin.fa_project_check 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_project_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_project_check` ENABLE KEYS */;

-- 导出  表 hanpin.fa_project_record 结构
CREATE TABLE IF NOT EXISTS `fa_project_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) unsigned NOT NULL COMMENT '项目ID',
  `report` varchar(100) NOT NULL COMMENT '项目汇报人',
  `updatetime` int(11) DEFAULT NULL COMMENT '更新时间',
  `remark` text COMMENT '备注',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `FK_fa_project_record_fa_project` FOREIGN KEY (`pid`) REFERENCES `fa_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目记录';

-- 正在导出表  hanpin.fa_project_record 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_project_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_project_record` ENABLE KEYS */;

-- 导出  表 hanpin.fa_sms 结构
CREATE TABLE IF NOT EXISTS `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信验证码表';

-- 正在导出表  hanpin.fa_sms 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_sms` ENABLE KEYS */;

-- 导出  表 hanpin.fa_supplier 结构
CREATE TABLE IF NOT EXISTS `fa_supplier` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '供货商名称',
  `contacts` varchar(100) NOT NULL COMMENT '联系人',
  `mobile` varchar(50) NOT NULL COMMENT '联系方式',
  `address` varchar(500) DEFAULT NULL COMMENT '联系地址',
  `order` int(10) DEFAULT '0' COMMENT '排序',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='供货商表';

-- 正在导出表  hanpin.fa_supplier 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `fa_supplier` DISABLE KEYS */;
INSERT INTO `fa_supplier` (`id`, `name`, `contacts`, `mobile`, `address`, `order`, `status`, `createtime`, `deletetime`) VALUES
	(1, '测试供货商', '龚先生', '133', '', 0, 'normal', 1585718470, NULL),
	(2, '测试供货商', '222', '13327763225', '', 2, 'normal', 1585718821, NULL),
	(3, '测试供货商2', '联系人', '13327762222', '', 0, 'normal', 1585720378, NULL);
/*!40000 ALTER TABLE `fa_supplier` ENABLE KEYS */;

-- 导出  表 hanpin.fa_test 结构
CREATE TABLE IF NOT EXISTS `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) NOT NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) NOT NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) NOT NULL DEFAULT '' COMMENT '省市',
  `json` varchar(255) DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) DEFAULT NULL COMMENT '刷新时间(int)',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='测试表';

-- 正在导出表  hanpin.fa_test 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_test` DISABLE KEYS */;
INSERT INTO `fa_test` (`id`, `admin_id`, `category_id`, `category_ids`, `week`, `flag`, `genderdata`, `hobbydata`, `title`, `content`, `image`, `images`, `attachfile`, `keywords`, `description`, `city`, `json`, `price`, `views`, `startdate`, `activitytime`, `year`, `times`, `refreshtime`, `createtime`, `updatetime`, `deletetime`, `weigh`, `switch`, `status`, `state`) VALUES
	(1, 0, 12, '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', '{"a":"1","b":"2"}', 0.00, 0, '2017-07-10', '2017-07-10 18:24:45', '2017', '18:24:45', 1499682285, 1499682526, 1499682526, NULL, 0, 1, 'normal', '1');
/*!40000 ALTER TABLE `fa_test` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user 结构
CREATE TABLE IF NOT EXISTS `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) NOT NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) NOT NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) NOT NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) DEFAULT NULL COMMENT '加入时间',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) NOT NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- 正在导出表  hanpin.fa_user 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_user` DISABLE KEYS */;
INSERT INTO `fa_user` (`id`, `group_id`, `username`, `nickname`, `password`, `salt`, `email`, `mobile`, `avatar`, `level`, `gender`, `birthday`, `bio`, `money`, `score`, `successions`, `maxsuccessions`, `prevtime`, `logintime`, `loginip`, `loginfailure`, `joinip`, `jointime`, `createtime`, `updatetime`, `token`, `status`, `verification`) VALUES
	(1, 1, 'admin', 'admin', 'c13f62012fd6a8fdf06b3452a94430e5', 'rpR6Bv', 'admin@163.com', '13888888888', '', 0, 0, '2017-04-15', '', 0.00, 0, 1, 1, 1516170492, 1516171614, '127.0.0.1', 0, '127.0.0.1', 1491461418, 0, 1516171614, '', 'normal', '');
/*!40000 ALTER TABLE `fa_user` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user_group 结构
CREATE TABLE IF NOT EXISTS `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员组表';

-- 正在导出表  hanpin.fa_user_group 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_user_group` DISABLE KEYS */;
INSERT INTO `fa_user_group` (`id`, `name`, `rules`, `createtime`, `updatetime`, `status`) VALUES
	(1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1515386468, 1516168298, 'normal');
/*!40000 ALTER TABLE `fa_user_group` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user_money_log 结构
CREATE TABLE IF NOT EXISTS `fa_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员余额变动表';

-- 正在导出表  hanpin.fa_user_money_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_user_money_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_money_log` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user_rule 结构
CREATE TABLE IF NOT EXISTS `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='会员规则表';

-- 正在导出表  hanpin.fa_user_rule 的数据：~12 rows (大约)
/*!40000 ALTER TABLE `fa_user_rule` DISABLE KEYS */;
INSERT INTO `fa_user_rule` (`id`, `pid`, `name`, `title`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES
	(1, 0, 'index', '前台', '', 1, 1516168079, 1516168079, 1, 'normal'),
	(2, 0, 'api', 'API接口', '', 1, 1516168062, 1516168062, 2, 'normal'),
	(3, 1, 'user', '会员模块', '', 1, 1515386221, 1516168103, 12, 'normal'),
	(4, 2, 'user', '会员模块', '', 1, 1515386221, 1516168092, 11, 'normal'),
	(5, 3, 'index/user/login', '登录', '', 0, 1515386247, 1515386247, 5, 'normal'),
	(6, 3, 'index/user/register', '注册', '', 0, 1515386262, 1516015236, 7, 'normal'),
	(7, 3, 'index/user/index', '会员中心', '', 0, 1516015012, 1516015012, 9, 'normal'),
	(8, 3, 'index/user/profile', '个人资料', '', 0, 1516015012, 1516015012, 4, 'normal'),
	(9, 4, 'api/user/login', '登录', '', 0, 1515386247, 1515386247, 6, 'normal'),
	(10, 4, 'api/user/register', '注册', '', 0, 1515386262, 1516015236, 8, 'normal'),
	(11, 4, 'api/user/index', '会员中心', '', 0, 1516015012, 1516015012, 10, 'normal'),
	(12, 4, 'api/user/profile', '个人资料', '', 0, 1516015012, 1516015012, 3, 'normal');
/*!40000 ALTER TABLE `fa_user_rule` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user_score_log 结构
CREATE TABLE IF NOT EXISTS `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分变动表';

-- 正在导出表  hanpin.fa_user_score_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_score_log` ENABLE KEYS */;

-- 导出  表 hanpin.fa_user_token 结构
CREATE TABLE IF NOT EXISTS `fa_user_token` (
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `expiretime` int(10) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员Token表';

-- 正在导出表  hanpin.fa_user_token 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `fa_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
