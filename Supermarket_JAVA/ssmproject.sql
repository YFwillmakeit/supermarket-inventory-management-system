/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.7.22-log : Database - ssmproject
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssmproject` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssmproject`;

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `goods_desc` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `product_time` date DEFAULT NULL,
  `shelf_life` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `expiration_time` int(11) DEFAULT NULL COMMENT '临近过期时间',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

/*Data for the table `goods` */

insert  into `goods`(`id`,`goods_name`,`goods_desc`,`product_time`,`shelf_life`,`type_id`,`expiration_time`,`state`) values (1,'苹果','苹果','2020-01-01',15,1,NULL,1),(2,'椰子','椰子','2020-01-01',20,1,NULL,0),(3,'梨子','梨子','2020-01-01',10,1,NULL,0),(4,'相机','数码','2020-01-01',1000,4,NULL,0),(5,'手机','数码','2020-01-01',2000,4,NULL,0),(6,'薯片','食品','2020-01-01',30,5,NULL,0),(7,'饮水机','家电','2020-01-01',1000,3,NULL,0),(8,'苹果','苹果','2020-01-01',15,1,NULL,0),(9,'苹果','苹果','2020-01-01',15,1,NULL,0),(11,'相机','数码','2020-01-01',1000,4,NULL,0),(12,'相机','数码','2020-01-01',1000,4,NULL,0),(13,'手机','数码','2020-01-01',2000,4,NULL,0),(14,'手机','数码','2020-01-01',2000,4,NULL,0),(15,'苹果','苹果','2020-07-14',15,1,NULL,0),(16,'苹果','苹果','2020-07-19',15,1,NULL,0),(17,'牛肉','牛肉','2020-07-19',15,5,NULL,0),(18,'羊肉','羊肉','2020-07-19',15,5,NULL,0),(19,'牛肉','牛肉','2020-07-01',15,5,NULL,0),(20,'苹果','苹果','2020-01-01',15,1,NULL,0),(25,'纸巾','纸巾','2020-02-03',300,2,NULL,0),(26,'湿纸巾','湿纸巾','2020-07-05',300,2,NULL,0),(27,'臭干子','吃的','2020-03-02',30,5,NULL,0),(28,'苹果','好','2020-01-01',30,1,NULL,0),(29,'牛肉干','牛肉干','2020-02-02',25,5,NULL,0),(30,'苹果','好得一','2020-01-01',30,1,NULL,0),(31,'苹果','ok','2020-01-02',30,1,NULL,0),(32,'苹果','ok','2020-01-02',31,1,NULL,0),(33,'aaa','5295','2010-01-01',111,6,NULL,1),(34,'aaa','11231231','2020-02-02',100,6,NULL,1),(35,'aaa','5295','2020-02-03',111,6,NULL,1),(36,'aaa','11231231','2020-02-02',100,6,NULL,1),(37,'aaa','5295','2020-02-02',111,6,NULL,0),(38,'aaa','afdsf','2020-01-02',1231,2,NULL,0),(39,'ab','asda','2020-02-02',12,6,NULL,0),(40,'苹果','苹果','2020-01-04',300,1,NULL,0),(41,'苹果','苹果','2020-01-04',300,1,NULL,0),(42,'苹果','苹果','2020-01-01',15,1,NULL,0),(43,'苹果','苹果','2020-07-23',15,1,NULL,0),(44,'牛肉','牛肉','2020-09-04',15,5,NULL,0),(45,'苹果','苹果','2020-07-13',15,1,NULL,0),(46,'苹果','苹果','2020-07-13',15,1,NULL,0),(47,'牛肉','牛肉','2020-07-07',15,5,NULL,0),(48,'鼠标','鼠标','2020-07-23',1000,4,NULL,1),(49,'鼠标','鼠标','2020-08-07',1000,4,NULL,1),(50,'电脑','发顺丰','2020-07-15',20000,4,NULL,0),(51,'华为手机','发顺丰','2020-06-30',30,4,NULL,0),(52,'牛肉','牛肉','2020-06-30',15,5,NULL,0),(53,'梨子','梨子','2020-07-19',10,1,NULL,0),(54,'华为手机','手机','2020-06-30',30,4,NULL,1);

/*Table structure for table `goods_type` */

DROP TABLE IF EXISTS `goods_type`;

CREATE TABLE `goods_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `goods_type` */

insert  into `goods_type`(`id`,`name`) values (1,'生鲜水果'),(2,'生活用品'),(3,'家电'),(4,'数码'),(5,'食品'),(6,'其他');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `menu` */

insert  into `menu`(`id`,`pid`,`name`,`icon`,`url`) values (1,0,'后端页面',NULL,'/main.html'),(2,0,'商品管理',NULL,'/');

/*Table structure for table `permission` */

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `permission_name` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '权限名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `permission` */

insert  into `permission`(`id`,`code`,`permission_name`) values (1,1,'用户管理'),(2,2,'商品管理'),(3,3,'出库管理'),(4,4,'入库管理');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `role` */

insert  into `role`(`id`,`rolename`) values (1,'销售经理'),(2,'销售主管'),(3,'客户经理'),(4,'品牌主管'),(5,'老板'),(6,'保洁阿姨'),(7,'aaa'),(8,'fasffs');

/*Table structure for table `role_permission` */

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `role_permission` */

insert  into `role_permission`(`id`,`role_id`,`permission_id`) values (9,2,4),(10,4,3),(11,5,2),(12,6,1),(13,1,1),(18,7,1),(20,8,4),(21,8,2),(22,3,4),(23,3,3);

/*Table structure for table `stock` */

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `goods_amount` int(11) DEFAULT NULL,
  `standard_amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `stock` */

insert  into `stock`(`id`,`goods_id`,`goods_amount`,`standard_amount`) values (1,1,2700,500),(3,3,500,500),(4,4,90,2000),(5,5,5,2000),(6,6,0,2500),(7,7,0,1500),(8,17,6346,2500),(9,18,0,2500),(10,25,0,1000),(11,26,0,1000),(12,27,0,2500),(13,29,0,2500),(14,33,141,3000),(15,39,0,3000),(16,48,0,2000),(17,50,0,2000),(18,54,200,2000);

/*Table structure for table `stock_change` */

DROP TABLE IF EXISTS `stock_change`;

CREATE TABLE `stock_change` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `time` date DEFAULT NULL,
  `type` int(11) NOT NULL COMMENT '0:出库1：入库',
  `user_id` int(11) NOT NULL COMMENT '库存操作操作人员id',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

/*Data for the table `stock_change` */

insert  into `stock_change`(`id`,`goods_id`,`amount`,`time`,`type`,`user_id`,`state`) values (1,8,1000,'2020-01-01',1,1,1),(2,9,70,'2020-01-05',0,1,1),(3,10,1000,'2020-01-02',1,1,1),(4,11,100,'2020-02-01',1,1,1),(5,12,10,'2020-07-15',0,1,1),(6,13,10,'2020-07-21',1,10,1),(7,14,5,'2020-07-21',0,1,0),(8,15,10,'2020-07-15',1,1,1),(9,16,10,'2020-07-20',1,1,0),(10,19,100,'2020-07-19',1,1,0),(11,20,50,'2020-07-21',0,1,0),(12,21,50,'2020-07-21',0,1,1),(13,22,50,'2020-06-21',0,1,1),(14,23,500,'2020-06-21',0,1,1),(15,24,500,'2020-06-21',0,1,1),(16,35,111,'2020-01-01',1,1,0),(17,37,30,'2020-07-20',1,10,1),(18,42,1000,'2020-01-01',1,1,0),(19,43,1000,'2020-01-01',1,1,0),(20,44,6546,'2020-08-09',1,1,1),(21,46,200,'2020-07-22',0,1,0),(22,47,500,'2020-07-20',0,1,0),(23,51,200,'2020-07-22',1,1,0),(24,52,200,'2020-07-14',1,9,0),(25,53,500,'2020-07-23',1,10,0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '123456',
  `role_id` int(11) NOT NULL,
  `head_pic` varchar(255) DEFAULT NULL,
  `state` int(255) DEFAULT '0' COMMENT '是否离职0：未离职1：已离职',
  `tel` varchar(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`role_id`,`head_pic`,`state`,`tel`,`email`,`address`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e',1,'1',0,NULL,NULL,NULL),(2,'刘海','e10adc3949ba59abbe56e057f20f883e',1,NULL,0,NULL,NULL,NULL),(3,'唐银岗','e10adc3949ba59abbe56e057f20f883e',2,NULL,0,NULL,NULL,NULL),(4,'胡佳祺','e10adc3949ba59abbe56e057f20f883e',3,NULL,0,NULL,NULL,NULL),(5,'邓攀','e10adc3949ba59abbe56e057f20f883e',4,NULL,0,NULL,NULL,NULL),(8,'人权为荣','e10adc3949ba59abbe56e057f20f883e',1,NULL,1,NULL,NULL,NULL),(9,'tyg','e10adc3949ba59abbe56e057f20f883e',1,NULL,0,NULL,NULL,NULL),(10,'hjq','fcea920f7412b5da7be0cf42b8c93759',2,NULL,1,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
