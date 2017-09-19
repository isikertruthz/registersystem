DROP TABLE IF EXISTS `tbl_student`;
CREATE TABLE `tbl_student` (
	`student_id` varchar(11) NOT NULL,
	`student_name` varchar(40) DEFAULT NULL,
	`class_id` varchar(11) DEFAULT '0',
	`speciality_id` varchar(11) DEFAULT '0',
	`bedchamber_id` varchar(11) DEFAULT '0',
	`payAmount` int(11) DEFAULT '0',
	`pay_ok` int(1) DEFAULT '0' COMMENT '0未缴费 1已缴费',
	`register_date` datetime DEFAULT NULL,
	PRIMARY KEY (`student_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_admin_user`;
CREATE TABLE `tbl_admin_user` (
	`admin_username` varchar(40) NOT NULL,
	`admin_password` varchar(40) DEFAULT NULL,
	`admin_userrole` int(10) DEFAULT '0' COMMENT '0管理员 1普通用户',
	`register_date` datetime DEFAULT NULL,
	PRIMARY KEY (`admin_username`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_class`;
CREATE TABLE `tbl_class` (
	`class_id` varchar(11) NOT NULL,
	`class_name` varchar(40) DEFAULT NULL,
	PRIMARY KEY (`class_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_speciality`;
CREATE TABLE `tbl_speciality` (
	`speciality_id` varchar(11) NOT NULL,
	`speciality_name` varchar(40) DEFAULT NULL,
	PRIMARY KEY (`speciality_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tbl_bedchamber`;
CREATE TABLE `tbl_bedchamber` (
	`bedchamber_id` varchar(11) NOT NULL,
	`bedchamber_name` varchar(40) DEFAULT NULL,
	PRIMARY KEY (`bedchamber_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `tbl_student` ADD CONSTRAINT `pk_student_class` FOREIGN KEY (`class_id`) REFERENCES `tbl_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `tbl_student` ADD CONSTRAINT `pk_student_speciality` FOREIGN KEY (`speciality_id`) REFERENCES `tbl_speciality` (`speciality_id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `tbl_student` ADD CONSTRAINT `pk_student_bedchamber` FOREIGN KEY (bedchamber_id) REFERENCES `tbl_bedchamber` (`bedchamber_id`) ON DELETE CASCADE ON UPDATE CASCADE;


