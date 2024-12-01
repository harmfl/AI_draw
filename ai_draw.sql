-- MySQL dump 10.13  Distrib 5.7.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ai_draw
-- ------------------------------------------------------
-- Server version	5.7.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_analyse_connectstudentteacher`
--

DROP TABLE IF EXISTS `ai_analyse_connectstudentteacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_analyse_connectstudentteacher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(50) DEFAULT NULL,
  `student_phone` varchar(20) DEFAULT NULL,
  `student_sex` varchar(20) NOT NULL,
  `relationship` varchar(20) NOT NULL,
  `teacher_or_parent_name` varchar(50) DEFAULT NULL,
  `teacher_or_parent_phone` varchar(20) DEFAULT NULL,
  `student_image` varchar(100) DEFAULT NULL,
  `connect_time` datetime(6) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `teacher_or_parent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_or_parent_id` (`teacher_or_parent_id`),
  KEY `AI_analyse_connectst_student_id_6d063319_fk_login_pro` (`student_id`),
  CONSTRAINT `AI_analyse_connectst_student_id_6d063319_fk_login_pro` FOREIGN KEY (`student_id`) REFERENCES `login_profile` (`id`),
  CONSTRAINT `AI_analyse_connectst_teacher_or_parent_id_e5e8f216_fk_login_pro` FOREIGN KEY (`teacher_or_parent_id`) REFERENCES `login_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_analyse_connectstudentteacher`
--

LOCK TABLES `ai_analyse_connectstudentteacher` WRITE;
/*!40000 ALTER TABLE `ai_analyse_connectstudentteacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_analyse_connectstudentteacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add profile',7,'add_profile'),(26,'Can change profile',7,'change_profile'),(27,'Can delete profile',7,'delete_profile'),(28,'Can view profile',7,'view_profile'),(29,'Can add artwork',8,'add_artwork'),(30,'Can change artwork',8,'change_artwork'),(31,'Can delete artwork',8,'delete_artwork'),(32,'Can view artwork',8,'view_artwork'),(33,'Can add 绘画作品',9,'add_drawing'),(34,'Can change 绘画作品',9,'change_drawing'),(35,'Can delete 绘画作品',9,'delete_drawing'),(36,'Can view 绘画作品',9,'view_drawing'),(37,'Can add chat message',10,'add_chatmessage'),(38,'Can change chat message',10,'change_chatmessage'),(39,'Can delete chat message',10,'delete_chatmessage'),(40,'Can view chat message',10,'view_chatmessage'),(41,'Can add 学生与教师/家长关联',11,'add_connectstudentteacher'),(42,'Can change 学生与教师/家长关联',11,'change_connectstudentteacher'),(43,'Can delete 学生与教师/家长关联',11,'delete_connectstudentteacher'),(44,'Can view 学生与教师/家长关联',11,'view_connectstudentteacher');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$260000$VwWi6YndMo4MTgk6OeOqEN$3691Pl/wOcnliuac+2ysW2t6Ao5Xwr/PMlPj6SiqKFs=','2024-10-28 07:43:11.829998',0,'WLtao','','','',0,1,'2024-10-27 08:56:07.388500'),(2,'pbkdf2_sha256$260000$WpbNJ9uEjGG1ZvOsguLYsJ$ooedxw8X4eOcVz7uLutTyYqxYTIq6Ibkyoh8b4wb0bw=','2024-11-19 04:01:05.386047',1,'root','','','1077805335@qq.com',1,1,'2024-10-27 09:04:04.890454'),(3,'pbkdf2_sha256$260000$NM2dMHwQkw40niQh6A0PQ3$1ZpzfjbpnD6F4W0I13yNlMvyy6SnDoyIJnUTiXCqP8A=','2024-10-28 07:04:19.947812',0,'admin','','','',0,1,'2024-10-28 06:59:26.632314'),(4,'',NULL,0,'tao','','','',0,1,'2024-10-28 07:23:06.548832'),(5,'',NULL,0,'tao1','','','',0,1,'2024-10-28 07:24:03.166030'),(6,'',NULL,0,'xzl','','','',0,1,'2024-10-28 08:07:58.021018'),(7,'',NULL,0,'teacher','','','',0,1,'2024-11-18 13:29:57.945632');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-11-02 11:45:14.435530','1','《未来地震救援机器人》',1,'[{\"added\": {}}]',8,2),(2,'2024-11-02 11:46:41.760310','2','守护与环境',1,'[{\"added\": {}}]',8,2),(3,'2024-11-02 11:47:32.963847','3','科技助农',1,'[{\"added\": {}}]',8,2),(4,'2024-11-02 11:49:18.211855','4','《飞翔的消防机》',1,'[{\"added\": {}}]',8,2),(5,'2024-11-02 11:49:53.551005','5','《关爱自然 创造未来》',1,'[{\"added\": {}}]',8,2),(6,'2024-11-02 11:50:41.270311','6','《我理想的未来城市》',1,'[{\"added\": {}}]',8,2),(7,'2024-11-02 11:51:36.285230','7','《万里长城》',1,'[{\"added\": {}}]',8,2),(8,'2024-11-02 11:52:32.798119','8','《山海经》',1,'[{\"added\": {}}]',8,2),(9,'2024-11-02 11:53:24.303993','9','《街边报刊亭》',1,'[{\"added\": {}}]',8,2),(10,'2024-11-02 11:54:29.993162','10','《我的小天地》',1,'[{\"added\": {}}]',8,2),(11,'2024-11-02 11:55:41.866094','11','《未来校园》',1,'[{\"added\": {}}]',8,2),(12,'2024-11-02 11:59:34.469949','12','《江南风光》',1,'[{\"added\": {}}]',8,2),(13,'2024-11-02 12:00:59.212915','13','《我们的家园》',1,'[{\"added\": {}}]',8,2),(14,'2024-11-02 12:01:49.641115','14','《星月夜》',1,'[{\"added\": {}}]',8,2),(15,'2024-11-02 12:02:34.551980','15','《学画星空》',1,'[{\"added\": {}}]',8,2),(16,'2024-11-02 12:03:21.459016','16','《在阿尔勒的梦境》',1,'[{\"added\": {}}]',8,2),(17,'2024-11-02 12:04:29.966646','17','《星空》',1,'[{\"added\": {}}]',8,2),(18,'2024-11-02 12:05:10.109184','18','《再造星空》',1,'[{\"added\": {}}]',8,2),(19,'2024-11-02 12:30:50.300713','18','《再造星空》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(20,'2024-11-02 12:31:30.389926','5','《关爱自然 创造未来》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(21,'2024-11-02 12:39:40.997162','18','《再造星空》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(22,'2024-11-02 12:40:18.955104','17','《星空》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(23,'2024-11-02 12:40:31.111261','16','《在阿尔勒的梦境》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(24,'2024-11-02 12:40:46.894050','15','《学画星空》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(25,'2024-11-02 12:41:18.089169','14','《星月夜》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(26,'2024-11-02 12:41:32.244969','1','《未来地震救援机器人》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(27,'2024-11-02 12:41:58.538980','2','守护与环境',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(28,'2024-11-02 12:43:09.754773','13','《我们的家园》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(29,'2024-11-02 12:43:21.311300','12','《江南风光》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(30,'2024-11-02 12:43:33.879755','11','《未来校园》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(31,'2024-11-02 12:43:43.889945','10','《我的小天地》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(32,'2024-11-02 12:43:57.666050','9','《街边报刊亭》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(33,'2024-11-02 12:44:12.486573','8','《山海经》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(34,'2024-11-02 12:44:20.545883','7','《万里长城》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(35,'2024-11-02 12:44:39.392633','6','《我理想的未来城市》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(36,'2024-11-02 12:45:14.463789','5','《关爱自然 创造未来》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(37,'2024-11-02 12:45:40.549860','4','《飞翔的消防机》',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2),(38,'2024-11-02 12:46:00.577617','3','科技助农',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',8,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'AI_analyse','connectstudentteacher'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'draw_banner','artwork'),(10,'draw_banner','chatmessage'),(9,'draw_banner','drawing'),(7,'login','profile'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-10-27 08:09:17.241001'),(2,'auth','0001_initial','2024-10-27 08:09:17.506553'),(3,'admin','0001_initial','2024-10-27 08:09:17.568795'),(4,'admin','0002_logentry_remove_auto_add','2024-10-27 08:09:17.574796'),(5,'admin','0003_logentry_add_action_flag_choices','2024-10-27 08:09:17.580800'),(6,'contenttypes','0002_remove_content_type_name','2024-10-27 08:09:17.620400'),(7,'auth','0002_alter_permission_name_max_length','2024-10-27 08:09:17.644783'),(8,'auth','0003_alter_user_email_max_length','2024-10-27 08:09:17.670794'),(9,'auth','0004_alter_user_username_opts','2024-10-27 08:09:17.676795'),(10,'auth','0005_alter_user_last_login_null','2024-10-27 08:09:17.697750'),(11,'auth','0006_require_contenttypes_0002','2024-10-27 08:09:17.699750'),(12,'auth','0007_alter_validators_add_error_messages','2024-10-27 08:09:17.706752'),(13,'auth','0008_alter_user_username_max_length','2024-10-27 08:09:17.731116'),(14,'auth','0009_alter_user_last_name_max_length','2024-10-27 08:09:17.756828'),(15,'auth','0010_alter_group_name_max_length','2024-10-27 08:09:17.783650'),(16,'auth','0011_update_proxy_permissions','2024-10-27 08:09:17.790655'),(17,'auth','0012_alter_user_first_name_max_length','2024-10-27 08:09:17.815022'),(18,'sessions','0001_initial','2024-10-27 08:09:17.839549'),(19,'login','0001_initial','2024-10-27 08:54:45.119832'),(20,'draw_banner','0001_initial','2024-11-02 11:41:35.132505'),(21,'login','0002_alter_profile_user_type','2024-11-02 11:41:35.147081'),(22,'draw_banner','0002_alter_artwork_image','2024-11-02 12:16:06.264322'),(23,'draw_banner','0003_alter_artwork_image','2024-11-02 12:23:57.350484'),(24,'draw_banner','0004_drawing','2024-11-08 07:56:38.991510'),(25,'draw_banner','0005_auto_20241108_1828','2024-11-08 10:29:03.273696'),(26,'AI_analyse','0001_initial','2024-11-18 12:09:11.602008');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('086e9hhstfyi8j8r1xutabe8rokn12c0','e30:1t4z4B:L5y40X7i-LyCyGVsftBLtxqXK7zCrkzD3tEAyzTNvyI','2024-11-10 08:56:07.517530'),('48fuvlzt3bq0gszzlhbhij1umwf6u0u9','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tC8p3:Ephj2sxEj4IMwKZhhqg15ExknXqwYa2mQjkn4pGI6Dg','2024-11-30 02:46:05.105592'),('5haqsdle0xhkj7wr45sq137vwxw89jxv','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tBYOd:VydKR0n2BDxmLWm-5jYdpL0Mgu-JbP9H5-9pbnopWM0','2024-11-28 11:52:23.628718'),('9psrjnwvjnzvngz1mfsduband4an2m36','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1t5KnZ:39odQ_XQsJtXxbq9hWNLeXtyY89InCymZfNBChXQmaY','2024-11-11 08:08:25.605716'),('hghqq7ukem1b5zps40wkwah611pqohtq','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1t5kD2:XmTV7HTO5IDNq6wsQopB8ZIP_2YNtvcCbOMxAc1LoEU','2024-11-12 11:16:24.330564'),('i9fknpx1h0pfg8cx3ey6zqboa0n2xxnv','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tCHtv:YQJyEmEtcCJr-Paw-_Kgb3DL7wR_FJ1gC1_-FdFwFtE','2024-11-30 12:27:43.823659'),('tcgh1d8td4w5wvw00189zlmabd79dob0','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tARV1:dMvfZfpZ6bTpZwajv6P-eaxJtQpYUg-NlpkAj0DQ9x0','2024-11-25 10:18:23.282583'),('ycepx0e0y1xk2yvxtvr8rblf6s5gfl4e','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tDFQH:fmDaHgDSkWtsKxlXtf99YHAYNGNRGl_SftBU_JTVsX8','2024-12-03 04:01:05.388048'),('z8x7jxrmmcuv4eami2rrhb2hn9zagrvd','.eJxVjEEOwiAQRe_C2hDKAAWX7j0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kTgLLU6_W8L84LYDumO7zTLPbV2mJHdFHrTL60z8vBzu30HFXr-1B6OzGh0OJoAjGkrQaAt4i6PjoDQ4Q0aRLczKaU6kAYoHxyoFTl68P8MqN3o:1tCcpZ:RGuinjCthc9t9gyICHfNZJHrQXWz4DxOFl687ziG85E','2024-12-01 10:48:37.481285');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draw_banner_artwork`
--

DROP TABLE IF EXISTS `draw_banner_artwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draw_banner_artwork` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `author` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL,
  `likes` int(10) unsigned NOT NULL,
  `views` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draw_banner_artwork`
--

LOCK TABLES `draw_banner_artwork` WRITE;
/*!40000 ALTER TABLE `draw_banner_artwork` DISABLE KEYS */;
INSERT INTO `draw_banner_artwork` VALUES (1,'《未来地震救援机器人》','余文涵','image_draw/余文涵未来地震救援机器人_350x260.jpg','original',0,0),(2,'守护与环境','余文涵','image_draw/叶斯守护与环境_350x260.jpg','original',0,0),(3,'科技助农','韦柳汐','image_draw/韦柳汐科技助农_350x260.jpg','original',0,0),(4,'《飞翔的消防机》','韦柳亦','image_draw/韦柳亦飞翔的消防机_350x260.jpg','original',0,0),(5,'《关爱自然 创造未来》','田子琦','image_draw/田子琦关爱自然_创造未来_350x260.jpg','original',0,0),(6,'《我理想的未来城市》','雍措央金','image_draw/雍措央金我理想的未来城市_350x260.jpg','original',0,0),(7,'《万里长城》','陈费琦','image_draw/陈费琦万里长城_350x260.jpg','inspiration',0,0),(8,'《山海经》','陆光铭','image_draw/陆光铭山海经_350x260.jpg','inspiration',0,0),(9,'《街边报刊亭》','杨宇蕊','image_draw/杨宇蕊街边报刊亭_350x260.jpg','inspiration',0,0),(10,'《我的小天地》','张懿涵','image_draw/张懿涵我的小天地_350x260.jpg','inspiration',0,0),(11,'《未来校园》','陈建佑','image_draw/陈建佑未来校园_350x260_9WKXPqK.jpg','inspiration',0,0),(12,'《江南风光》','武喻可','image_draw/武喻可江南风光_350x260.jpg','inspiration',0,0),(13,'《我们的家园》','向 军','image_draw/cc7fc087-718a-4641-8959-3ac19aa1f84f_wEI9qPY_F153iNr.jpg','copy',0,0),(14,'《星月夜》','李 澈','image_draw/c6b5b094-ba02-44a1-b2b6-c3fdeab34c92_4ZmucD3.jpg','copy',0,0),(15,'《学画星空》','周籽涵','image_draw/周籽涵学画星空_350x260.jpg','copy',0,0),(16,'《在阿尔勒的梦境》','雷瑾熙','image_draw/雷瑾熙在阿尔勒的梦境_350x260.jpg','copy',0,0),(17,'《星空》','赫子铭','image_draw/cc7fc087-718a-4641-8959-3ac19aa1f84f_wEI9qPY.jpg','copy',0,0),(18,'《再造星空》','孔艺晨','image_draw/孔艺晨再造星空_350x260.jpg','copy',0,0);
/*!40000 ALTER TABLE `draw_banner_artwork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draw_banner_chatmessage`
--

DROP TABLE IF EXISTS `draw_banner_chatmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draw_banner_chatmessage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_type` varchar(10) NOT NULL,
  `content` longtext NOT NULL,
  `ai_response` longtext,
  `timestamp` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `draw_banner_chatmessage_user_id_e3b39d5b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `draw_banner_chatmessage_user_id_e3b39d5b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draw_banner_chatmessage`
--

LOCK TABLES `draw_banner_chatmessage` WRITE;
/*!40000 ALTER TABLE `draw_banner_chatmessage` DISABLE KEYS */;
INSERT INTO `draw_banner_chatmessage` VALUES (1,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-08 10:32:23.116578',2),(2,'image','图片','The image displays a graphic representation of a red arrow, with arrows pointing to it. The arrows appear to be moving in different directions, suggesting that  the direction of movement can vary . The diagram also displays another smaller arrow, which is likely  connected to the arrow representing the red arrow.','2024-11-08 10:32:54.454104',2),(3,'image','图片','A graph of a butterfly life cycle is depicted in this diagram. It shows various stages of the life cycle of a butterfly, including larva, pupa, chrysalis, and adult butterfly. The diagram highlights the metamorphosis of the butterfly as it progresses through its life cycle .','2024-11-08 10:33:27.568882',2),(4,'image','图片','The image depicts a diagram of a food chain. It shows a process in which worms consume worms as food. The diagram depicts the worms consuming other worms as they move along the food chain.\n\nIn total, there are nine worms in the diagram. These worms are distributed across the entire food chain, from the lower-level worms at the top of the food chain to the upper -level worms at the top of the food chain. The diagram illustrates how these worms contribute to the food chain, and their role in the ecosystem.','2024-11-08 10:34:53.064503',2),(5,'text','what can i say','As an AI assistant, I am here to help you with any questions or tasks you have. You can ask me about a wide range of topics, from general knowledge to specific subjects like mathematics, science, or history. I can also assist you with language learning, writing, and editing. If you have any personal questions or need help with a project, feel free to ask!','2024-11-08 10:36:40.807607',2),(6,'text','can you tell me history about chinese','The history of China is one of the oldest and most complex in the world. It dates back thousands of years and is marked by a rich cultural heritage, numerous dynasties, and significant contributions to art, science, technology, and philosophy. Here is a brief overview of the major periods in Chinese history:\n\n1. Prehistoric China (Before 2070 BCE) - The origins of Chinese civilization can be traced back to the Neolithic period, with the rise of agriculture and the establishment of settlements. Important cultures during this time include the Yangshao and the Longshan.\n\n2. Xia Dynasty (2070 - 1600 BCE) - The Xia is the first dynasty in traditional Chinese history, though its existence is still debated by some scholars. It is said to have been founded by Yu the Great and was followed by the Shang Dynasty.\n\n3. Shang Dynasty (1600 - 1046 BCE) - The Shang is the first Chinese dynasty for which there is archaeological evidence. It is known for its bronze technology, writing system ( oracle bones ), and the development of early Chinese culture.\n\n4. Zhou Dynasty (1046 - 256 BCE) - The Zhou replaced the Shang and is divided into the Western Zhou (1046 - 771 BCE) and the Eastern Zhou (770 - 256 BCE). The Eastern Zhou is further subdivided into the Spring and Autumn Period (770 - 476 BCE) and the Warring States Period (475 - 221 BCE), a time of philosophical development and constant warfare among seven major states.\n\n5. Qin Dynasty (221 - 207 BCE) - The Qin unified China under the first emperor, Qin Shi Huang. The Qin standardized the written language, the currency, and the system of weights and measures, and built the famous Great Wall.\n\n6. Han Dynasty (202 BCE - 220 CE) - The Han Dynasty is considered one of the golden ages of Chinese history. It saw the development of the Silk Road, the spread of Confucianism, and significant scientific and technological advancements, including the invention of paper.\n\n7. Three Kingdoms (220 - 280 CE) - After the fall of the Han, China split into three kingdoms: Wei, Shu, and Wu. This period is known for its warfare, but also for the development of literature, such as the \"Romance of the Three Kingdoms.\"\n\n8. Tang Dynasty (618 - 907 CE) - The Tang is often considered the second golden age of China. It was a time of economic prosperity and cultural flourishing, with a strong influence on neighboring cultures.\n\n9. Song Dynasty (960 - 1279 CE) - The Song period is known for its technological advancements, such as gunpowder, the compass, and printing. It was also a time of great artistic achievement in painting and literature.\n\n10. Yuan Dynasty (1271 - 1368 CE)','2024-11-08 10:41:05.545215',2),(7,'text','can you tell me history about chinese','The history of China is one of the oldest and most complex in the world, with a rich cultural heritage and a continuous civilization that dates back over 5,000 years. The following is a brief overview of the major periods and events in Chinese history:\n\n### Prehistoric China (c. 1,700,000 BC – 2070 BC)\n- The earliest known evidence of human presence in China dates back to the Paleolithic era.\n- The Neolithic period saw the development of agriculture and the rise of various cultures such as the Yangshao and the Longshan.\n\n### Xia Dynasty (c. 2070 – 1600 BC)\n- The Xia dynasty is traditionally considered the first dynasty in China, although the existence of the Xia is still a matter of debate among scholars.\n\n### Shang Dynasty (c. 1600 – 1046 BC)\n- The Shang dynasty is the first Chinese dynasty for which there is both documentary and archaeological evidence.\n- The Shang are known for their bronze technology, writing system ( oracle bones ), and the capital city of Anyang.\n\n### Zhou Dynasty (c. 1046 – 256 BC)\n- The Zhou dynasty replaced the Shang and is divided into the Western Zhou (1046-771 BC) and the Eastern Zhou (770-256 BC).\n- The Eastern Zhou is further divided into the Spring and Autumn period (770-476 BC) and the Warring States period (475-221 BC), characterized by the fragmentation of central authority and the rise of powerful states.\n\n### Qin Dynasty (221 – 207 BC)\n- The Qin dynasty was established by Qin Shi Huang, who unified China for the first time under a single emperor.\n- The Qin standardized the writing system, currency, and weights and measures, and built the Great Wall of China.\n\n### Han Dynasty (202 BC – 220 AD)\n- The Han dynasty is considered one of the golden ages of Chinese history.\n- The Han expanded the empire, developed a strong centralized government, and made significant contributions to Chinese culture, including literature, art, music, and philosophy.\n\n### Three Kingdoms (220 – 280 AD)\n- The collapse of the Han dynasty led to the Three Kingdoms period, with three states—Wei, Shu, and Wu—competing for control.\n\n### Tang Dynasty (618 – 907 AD)\n- The Tang dynasty is often regarded as the high point of Chinese civilization, with a prosperous economy and a flourishing of art and culture.\n- The Tang period saw the spread of Buddhism and the development of Chinese poetry.\n\n### Song Dynasty (960 – 1279 AD)\n- The Song dynasty is known for its economic prosperity, technological advancements, and cultural achievements.\n- The Northern Song (960-1127) and the Southern Song (1127-1279) were separated by the Jurchen invasion.\n\n### Yuan Dynasty (1271 – 1368 AD)\n- The Yuan dynasty was established by the Mongols under Kublai Khan, who conquered the Song and unified China once again.\n\n### Ming Dynasty (1368 – 1644 AD)\n- The Ming dynasty restored Chinese rule and is known for its cultural achievements, the construction of the Forbidden City, and the voyages of exploration by Zheng He.\n\n### Qing Dynasty (1636 – 1912 AD)\n- The Qing dynasty was the last imperial dynasty, ruling over a vast and multi-ethnic empire.\n- The Qing period saw the height of the Manchu power and the beginning of modern China with the Opium Wars and the rise of nationalist movements.\n\n### Republican Era (1912 – 1949 AD)\n- The Republic of China was established in 1912 after the Xinhai Revolution, which overthrew the Qing dynasty.\n- The period was marked by political instability, the Chinese Civil War, and foreign interventions.\n\n### People\'s Republic of China (1949 – present)\n- The People\'s Republic of China was founded in 1949 by Mao Zedong and the Communist Party of China.\n- Since then, China has undergone significant political, economic, and social changes, including the Great Leap Forward, the Cultural Revolution','2024-11-08 10:41:45.967720',2),(8,'image','图片','The image depicts a \"love\" word written in large letters. The letter \"O\" appears to be \"love\" as well .\n','2024-11-08 10:53:50.370675',2),(9,'text','what mean is love','\"What does love mean?\" is a question that has been pondered by people throughout history, and it has many different interpretations and perspectives. Love is a complex and multifaceted emotion that can be difficult to define precisely. However, here are some common understandings of what love means:\n\n1. **Emotional Attachment**: Love often involves a strong emotional bond between two or more people. It can include feelings of affection, care, and attachment.\n\n2. **Intimacy**: A loving relationship usually involves a deep sense of intimacy, which can include physical closeness, emotional openness, and sharing personal thoughts and experiences.\n\n3. **Selflessness**: True love is often considered to be selfless. It means putting the needs of others before your own and being willing to sacrifice for their happiness.\n\n4. **Acceptance**: Loving someone means accepting them for who they are, including their flaws and shortcomings. It\'s about embracing their whole being without conditions.\n\n5. **Commitment**: Love often involves a commitment to the other person, a decision to stick with them through good times and bad, and a willingness to work through challenges together.\n\n6. **Unconditional**: The highest form of love is often thought to be unconditional. This means that the love doesn\'t depend on anything the loved one says or does, nor on any external circumstances.\n\n7. **Empathy and Understanding**: Love involves understanding the other person\'s feelings, thoughts, and experiences, and being able to empathize with them.\n\n8. **Happiness and Well-being**: A loving relationship typically brings happiness and a sense of well-being to both parties. It can provide support, comfort, and security.\n\n9. **Growth and Support**: Love can encourage personal growth and support each person\'s individual development. It helps in overcoming challenges and achieving personal goals.\n\n10. **Universality**: Love is a universal language that transcends cultural, linguistic, and societal boundaries. It is a fundamental human experience that connects us all.\n\n11. **Vulnerability**: Being in love often means allowing yourself to be vulnerable, exposing your true self, and trusting the other person not to cause harm.\n\n12. **Patience and Forgiveness**: Love requires patience when things are difficult and forgiveness when mistakes are made. It means looking past imperfections and focusing on the good.\n\n13. **Shared Experiences**: Love can be built on shared experiences, such as spending time together, enjoying activities, and creating memories.\n\n14. **Evolution**: Love can evolve over time, changing and adapting as the people involved change and grow.\n\n15. **Diversity**: Love comes in many forms, including romantic love, familial love, platonic love, and self-love. Each type of love is unique but can be equally profound.\n\nUltimately, love is a deeply personal and individual experience that can mean different things to different people. It is a profound emotion that can be both a source of joy and a catalyst for personal growth.','2024-11-08 10:54:45.992864',2),(10,'text','你好，让我们说中文吧','当然可以。请问有什么我可以帮助你的？','2024-11-08 10:55:24.500394',2),(11,'text','我想睡觉','如果你想睡觉，我建议你创造一个安静、舒适的环境，以便更容易入睡。以下是一些建议：\n\n1. 建立一个规律的睡眠时间表：尽量每天在同一时间上床睡觉和起床，即使是周末也不例外。这样可以帮助你的身体和大脑建立规律，提高睡眠质量。\n\n2. 创造一个放松的睡前环境：确保你的卧室安静、舒适，避免任何干扰因素，如噪音、亮光或电子设备。可以使用耳塞、眼罩或遮光窗帘来帮助减少干扰。\n\n3. 避免刺激性物质：在睡前避免饮用咖啡因和酒精，以及吃大餐或辛辣食物。这些物质可能会影响你的睡眠质量。\n\n4. 放松技巧：尝试一些放松技巧，如深呼吸、温热浴或冥想，来帮助你放松身心，减轻压力。\n\n5. 避免使用电子设备：在睡前避免使用手机、电脑或电视等电子设备，因为这些设备的蓝光会抑制褪黑激素的分泌，影响睡眠。\n\n6. 保持适量的运动：白天进行适量的运动有助于提高睡眠质量，但避免在睡前进行剧烈运动。\n\n7. 限制白天小睡：如果可能的话，尽量避免在白天过长时间的小睡，以免影响夜间的睡眠。\n\n8. 寻求专业帮助：如果你经常难以入睡或保持睡眠，可能需要寻求医生或睡眠专家的帮助，以排除任何潜在的健康问题。\n\n记住，每个人的睡眠需求都不同，重要的是找到适合自己的睡眠模式和习惯。如果你发现自己的睡眠问题持续存在，影响到了日常生活，建议咨询医生或专业睡眠专家。','2024-11-08 10:55:58.340267',2),(12,'image','图片','The image shows a stylized drawing of a male figure with a raised index finger, likely pointing upwards.\n','2024-11-08 11:00:46.346972',2),(13,'image','图片','The image displays a diagram of a worm.\n','2024-11-08 12:47:09.372663',2),(14,'image','图片','The image displays a line drawing of a male reproductive system. The male reproductive system consists of a penis, testicles, and vas deferens.','2024-11-08 12:48:20.716287',2),(15,'image','图片','The image displays a dark room filled with people. The re are numerous individuals dispersed throughout the room, some standing, and others sitting. The atmosphere seems quite lively, and the room appears to be quite full.\n','2024-11-08 13:23:55.182736',2),(16,'image','图片','The image displays an animated scene with a dark background. In the foreground, there is a large white rectangle with a white border that occupies the majority of the image . Inside this rectangle, there is a person with a backpack.\n\n There are several other people in various positions around the scene, some of them closer to the foreground while others are further away. The scene appears to be part of a public transit area, as several people can be seen with backpacks.\n\nA car can be seen parked in the background, further emphasizing the public transit setting.','2024-11-08 13:24:14.598840',2),(17,'image','图片','这张图是重新解释的“卡迪卡”的分类图。图中有两个相符的叶子和发光的根据，但是发光的根并没有增加。\n\n\n','2024-11-08 13:25:06.117155',2),(18,'image','图片','The image is a diagram of how a human anus works. It shows bottom section of the anus, and it contains text underneath.\n','2024-11-08 13:26:09.240579',2),(19,'image','图片','The image depicts a drawing of a heart, with the word \"loved\" written on it. The heart is surrounded by several lines, giving a sense of a handwritten text. The heart span s almost the entire width of the image and is prominently displayed.','2024-11-08 13:26:36.396411',2),(20,'text','111111','111111 is a sequence of six ones. It is often used in various contexts, such as:\n\n1. In binary representation of numbers, 111111 is the binary representation of the decimal number 63.\n2. In computer science, it is used as a pattern for bit masking operations. For example, if you have a byte (8 bits) and you want to check if the 6th bit is set, you can AND the byte with 111111 (which is 63 in decimal) and check the last bit of the result.\n3. In some programming languages, it is used as a sentinel value or a flag to indicate a specific condition or state.\n4. In digital logic, it can represent a high logic level on all inputs or outputs of a circuit.\n5. In some error-checking algorithms, it can be used as a checksum or a hash value.\n\nThe sequence 111111 is also used in various mathematical and logical operations, depending on the context in which it is presented.','2024-11-09 06:06:15.609245',2),(21,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-09 06:06:45.255802',2),(22,'image','图片','The image features a black background, with the letter \"M\" written vertically in red ink.','2024-11-09 06:32:25.343887',2),(23,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-09 06:57:29.959472',2),(24,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-09 06:57:53.391693',2),(25,'text','11','11 is the number eleven. It is a natural number following 10 and preceding 12. The number 11 is also the square of the number 3 (3 × 3 = 9) plus 2.\n\nIn many cultures, the number 11 is considered lucky, as it is a prime number and has unique properties. For example, in numerology, the number 11 is often associated with intuition, insight, and spiritual awareness. It is also considered a master number, which means it has a higher vibration and carries more significance than a regular single-digit number.\n\nIn mathematics, the number 11 is a prime number, which means it has no positive divisors other than 1 and itself. It is also a Fibonacci number, as it is the sum of the two preceding Fibonacci numbers (0 and 1).\n\nIn some systems of belief, the number 11 is considered a powerful number that can bring good fortune and positive energy. However, beliefs about numbers vary greatly from culture to culture, and in some contexts, the number 11 may have different connotations or meanings.','2024-11-09 07:07:48.882676',2),(26,'image','图片','这是一个小红字的演示图，还增加了一个水平的绿色的绿色。\n\n\n','2024-11-09 07:13:42.889997',2),(27,'image','图片','The image depicts a diagram of a \"red wolf\" - a creature with legs and \"tail\" shaped like wolf. The diagram is hand-drawn and depicts the animal \'s size, shape, and anatomy.\n','2024-11-09 07:13:56.179875',2),(28,'image','图片','描绘了关节的背部和肢骨的手描画，描绘了每个肢骨的长度和位置。\n\n','2024-11-09 07:14:18.616203',2),(29,'image','图片','这张图显示特定颗球的减少和增加。\n\nThe diagram depicts  the reduction of a baseball and the addition of another.\n\n','2024-11-09 07:15:04.174181',2),(30,'image','图片','The diagram depicts a stylized human figure with arms outstretched. The figure is  on the left side of the image , and the dark outline of its body extends from the lower right side to the lower  left side of the image.\n\n There are multiple instances of the figure , varying in size and position, all occupy ing the same area. The figure is positioned close to the upper right side of the image , extending horizontally across the width. The outline of parts of the figure are visible, giving it a dynamic appearance.','2024-11-09 07:16:01.999807',2),(31,'text','你好','你好！我是零一万物开发的智能助手，我叫 Yi，我是由零一万物的研究团队通过大量的文本数据进行训练，学习了语言的各种模式和关联，从而能够生成文本、回答问题、翻译语言的。我可以帮助你解答问题、提供信息，或者只是简单地聊聊天。有什么我可以帮助你的吗？','2024-11-09 07:16:47.678799',2),(32,'text','111','111 is the number one hundred and eleven. It is a three-digit number and is read as \"one hundred eleven\" or \"one hundred and eleven\" in English. In mathematics, 111 is a prime number, meaning it has no positive divisors other than 1 and itself.','2024-11-09 07:27:11.530258',2),(33,'image','图片','The graph depicts a downward-sloping line, which resembles the letter \"W\".\n','2024-11-09 07:27:37.561656',2),(34,'text','2','It seems like you\'re referring to the number 2. The number 2 is a natural number, and it is also an even number because it is divisible by 2. In many cultures, the number 2 is considered lucky or significant in various contexts. For example:\n\n- In Chinese culture, the number 2 is considered a lucky number because it sounds like the word for \"easy\" or \"double\" in Chinese.\n- In Western culture, the number 2 is often associated with partnerships, balance, and harmony (e.g., yin and yang, good and evil, etc.).\n- In mathematics, 2 is the first prime number after 1, and it is the only even prime number.\n\nIf you have any specific questions or need information on a different topic, feel free to ask!','2024-11-09 08:45:56.283307',2),(35,'text','1','It seems like there\'s a typo or a string of random characters in your message. Could you please provide more information or clarify your question so I can assist you better? \"1\" by itself doesn\'t form a complete question or request, so feel free to elaborate on what you\'re looking for or need help with.','2024-11-09 09:02:12.177328',2),(36,'image','图片','The image depicts a black background with blank space.\n','2024-11-09 09:02:21.326702',2),(37,'image','图片','The image displays a red thread swirling upwards and flowing through a dark space.\n','2024-11-09 09:31:21.591629',2),(38,'text','12','12 是一个自然数，也是一个正整数，它在数轴上位于正数一侧。在数学中，12 是一个非常特殊的数字，因为它是一个最小的完全数，也就是说，它等于其真因子（除了自身以外的所有因数）之和，即 1 + 2 + 3 + 4 + 6 = 12。此外，12 还是一个有名的数字，因为它有 12 个月，12 星座，12 生肖等文化含义。在日常生活中，12 也经常用于测量和计数，例如一打（dozen）就是 12 个。','2024-11-09 09:35:18.428662',2),(39,'image','图片','The image depicts a sloping, red line extending from the center to the right side . It appears to be a graph or diagram. The graph is labeled \"time\".','2024-11-09 09:45:51.340840',2),(40,'text','4444','4444 is the number that you have provided. It is a four-digit number. If you have any specific questions or need information about the number 4444, feel free to ask!','2024-11-09 10:00:55.024667',2),(41,'text','1111','1111 is a sequence of four ones. It is often used in various contexts, such as:\n\n1. In binary notation, where each digit represents a power of 2, 1111 represents the decimal number 15 (since 1*2^3 + 1*2^2 + 1*2^1 + 1*2^0 = 8 + 4 + 2 + 1 = 15).\n\n2. It can be used to denote a repeating pattern, especially in a context where binary or boolean values are used. For example, in a list of booleans, 1111 could represent a sequence of four true values.\n\n3. In some programming languages, a sequence of ones is used to initialize a variable to the maximum value for that data type. For example, in C++, if you have an integer variable `i` and you initialize it with `i = 1111`, it will be equivalent to `i = 15`.\n\n4. In some error-checking mechanisms, such as parity bits or checksums, a sequence of ones might indicate an error or be used to detect errors.\n\n5. In cryptography, sequences of ones and zeros can be used to create keys or to encode/decode messages using substitution ciphers or other methods.\n\n6. In some number systems, such as base 16 (hexadecimal), the number 1111 is represented by the digits FFFF (since 15 in decimal is F in hexadecimal).\n\n7. In some mathematical contexts, a sequence of ones might represent a vector or a matrix with all elements set to 1.\n\nThe context in which 1111 is used will determine its specific meaning or purpose.','2024-11-09 10:11:01.159265',2),(42,'text','1111','1111 is a sequence of four ones. It does not have a specific mathematical meaning or value beyond being a representation of the number 1, repeated four times. However, it can be interpreted in different contexts:\n\n1. In binary representation: In the binary numeral system, each place value represents a power of 2. So, 1111 in binary is equal to:\n   - 1 * 2^3 = 8\n   - 1 * 2^2 = 4\n   - 1 * 2^1 = 2\n   - 1 * 2^0 = 1\n   Adding these up, 1111 in binary is equal to 8 + 4 + 2 + 1 = 15 in decimal.\n\n2. In computer science: In many computer architectures, the number 1111 is used to represent a special condition or error, such as an overflow or an invalid operation. This is because it is the maximum value that can be represented by four bits (assuming an unsigned integer representation) before rolling over to 0000.\n\n3. In digital logic: A sequence of ones can represent a high logical level (e.g., 5V in a TTL circuit), indicating an active or on state.\n\n4. In number theory: The number 1111 is a prime number, and as such, it has its own unique properties and can be studied in the context of prime number theory.\n\n5. In finance: In some financial transactions, the number 1111 might be used as a dummy or placeholder value when the actual amount is not known or not applicable.\n\n6. In cryptography: The sequence 1111 can be used as a salt or a nonce in various cryptographic algorithms to ensure uniqueness and security.\n\n7. In gaming: In some games, the number 1111 might be used as a lucky or powerful number, or it could be a code or cheat.\n\n8. In design: The repetition of a pattern like 1111 can be used for visual emphasis or to create a pattern in design, such as in graphic design or interior design.\n\nIn each of these contexts, the meaning of 1111 is derived from the specific rules or conventions of the system or field in which it is being considered.','2024-11-09 10:14:19.462082',2),(43,'text','你好','你好！我是零一万物开发的智能助手，我叫 Yi，我是由零一万物的优秀工程师们一起开发的。我拥有广泛的知识和能力，随时准备帮助你解答问题或提供帮助。请问有什么我可以帮助你的？','2024-11-09 10:15:20.975687',2),(44,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-09 10:15:31.393207',2),(45,'image','图片','The image is a graphic representation of a bright red zigzag line that stretches horizontally across the screen.\n','2024-11-09 11:05:30.644829',2),(46,'text','大傻逼','很抱歉，我无法提供你所需要的帮助。','2024-11-09 11:20:18.879563',2),(47,'text','噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，不与秦塞通人烟。西当太白有鸟道，可以横绝峨眉巅。地崩山摧壮士死，然后天梯石栈相钩连。上有六龙回日之高标，下有冲波逆折之回川。黄鹤之飞尚不得过，猿猱欲度愁攀援。青泥何盘盘，百步九折萦岩峦。扪参历井仰胁息，以手抚膺坐长叹。  问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，愁空山。蜀道之难，难于上青天，使人听此凋朱颜！连峰去天不盈尺，枯松倒挂倚绝壁。飞湍瀑流争喧豗，砯崖转石万壑雷。其险也如此，嗟尔远道之人胡为乎来哉！  剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。锦城虽云乐，不如早还家。蜀道之难，难于上青天，侧身西望长咨嗟！','这首诗是唐代诗人李白的《蜀道难》，全诗共一百二十句，二百四十字，是一首描绘蜀地险要和艰难行路的著名诗篇。诗中多次重复“蜀道之难，难于上青天”，强调了蜀道的险峻和艰难。\n\n诗的开头“噫吁嚱，危乎高哉！”表达了诗人对蜀道的惊叹和敬畏。接着，诗人用“蚕丛及鱼凫，开国何茫然！”回顾了古代蜀国的历史，感叹其悠久和神秘。随后，诗人描述了蜀道的险要，包括“西当太白有鸟道，可以横绝峨眉巅”的天险和“地崩山摧壮士死，然后天梯石栈相钩连”的艰难开拓。\n\n诗中还描绘了蜀道的自然景观，如“上有六龙回日之高标，下有冲波逆折之回川”的宏伟和“黄鹤之飞尚不得过，猿猱欲度愁攀援”的险峻。诗人用“青泥何盘盘，百步九折萦岩峦”和“扪参历井仰胁息，以手抚膺坐长叹”来表达行者在蜀道上的艰辛和无奈。\n\n诗的后半部分转向对蜀道安全的忧虑，“剑阁峥嵘而崔嵬，一夫当关，万夫莫开”强调了剑阁的险要和易守难攻。诗人担心“所守或匪亲，化为狼与豺”，即如果守关的不是亲人，可能会变成野兽般的敌人。接着，诗人描绘了蜀道的恐怖景象，“朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻”，进一步强调了蜀道的危险。\n\n最后，诗人用“蜀道之难，难于上青天，侧身西望长咨嗟！”作结，再次感叹蜀道的艰难和行者的无奈。\n\n整首诗通过对蜀道的描绘，表现了诗人对自然的敬畏和对人生旅途的感慨。李白的诗风在这首诗中得到了充分的体现，他的想象丰富、夸张大胆、语言奔放，给人以强烈的视觉冲击和情感震撼。','2024-11-09 11:21:26.811544',2),(48,'text','噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，不与秦塞通人烟。西当太白有鸟道，可以横绝峨眉巅。地崩山摧壮士死，然后天梯石栈相钩连。上有六龙回日之高标，下有冲波逆折之回川。黄鹤之飞尚不得过，猿猱欲度愁攀援。青泥何盘盘，百步九折萦岩峦。扪参历井仰胁息，以手抚膺坐长叹。  问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，愁空山。蜀道之难，难于上青天，使人听此凋朱颜！连峰去天不盈尺，枯松倒挂倚绝壁。飞湍瀑流争喧豗，砯崖转石万壑雷。其险也如此，嗟尔远道之人胡为乎来哉！  剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。锦城虽云乐，不如早还家。蜀道之难，难于上青天，侧身西望长咨嗟！','这首诗是唐代诗人李白的《蜀道难》，描绘了蜀道的险峻和艰难，以及历史上开辟蜀道的艰辛。诗中多次重复“蜀道之难，难于上青天”，强调了蜀道的险难程度。诗人通过丰富的想象和夸张的手法，描绘了蜀道的壮丽景色和险要地势，同时也表达了对历史上开辟蜀道的英雄们的敬仰之情。\n\n诗中的“噫吁嚱”是感叹词，相当于现在的“啊”，表达惊讶或感叹。“危乎高哉”则是形容蜀道的高险。“蚕丛及鱼凫”指的是传说中古蜀国的两位先王。“开国何茫然”表达了历史久远，难以追溯。“尔来四万八千岁”是指自那时以来已经过去了非常久的时间。“不与秦塞通人烟”说明蜀地与外界交通不便。“西当太白有鸟道”是指在太白山有险峻的鸟道。“可以横绝峨眉巅”是指可以横渡峨眉山巅。“地崩山摧壮士死”是指历史上开辟蜀道的壮士牺牲。“然后天梯石栈相钩连”是指后来修筑的栈道。“上有六龙回日之高标”是指蜀道高耸入云，连太阳神的车驾都要绕行。“下有冲波逆折之回川”是指水流湍急，波涛汹涌。“黄鹤之飞尚不得过”和“猿猱欲度愁攀援”都是形容蜀道的险峻，连黄鹤和猿猴都难以通过。“青泥何盘盘”是指青泥岭蜿蜒曲折。“百步九折萦岩峦”是指道路曲折，环绕山峦。“扪参历井仰胁息”是指在蜀道上行走时，只能触摸星辰来判断方向，而且需要屏住呼吸，因为道路狭窄。“以手抚膺坐长叹”是指用手按住胸口，长时间地叹息。\n\n“问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，愁空山。”这几句表达了诗人对蜀道的畏惧和对旅人的同情。“剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。”这几句描绘了剑阁的险要和守关者的凶残。“锦城虽云乐，不如早还家。蜀道之难，难于上青天，侧身西望长咨嗟！”最后这几句表达了诗人对蜀道的感叹和对家乡的思念。\n\n整首诗通过对蜀道的描绘，展现了自然景观的壮丽和历史文化的深厚，同时也反映了古代交通的艰难和旅人的辛酸。诗人通过对蜀道的歌颂，表达了对自然的敬畏和对人类智慧与勇气的赞美。','2024-11-09 11:23:19.479852',2),(49,'image','图片','Image of a graph, which is a small red line, extending horizontally.\n\n\n','2024-11-09 12:08:03.860094',2),(50,'image','图片','The image displays a black background with a faint outline of an object , possibly a clock or a TV screen.\n','2024-11-09 12:12:09.167152',2),(51,'image','图片','The image displays a black background with a unique swirling shape, possibly representing an alien or celestial object. The shape appears to be red.\n','2024-11-09 12:23:38.599092',2),(52,'image','图片','The image is a  shot of a red arrow point ing up , drawing attention to its color. The arrow is positioned on the black background.','2024-11-09 12:29:54.949091',2),(53,'text','6666','6666 is the number that is formed by the digits 6 and 6, each occurring three times in a row. This number is often associated with the biblical reference to the \"Mark of the Beast\" as described in the Book of Revelation. However, in the context of mathematics or any other non-biblical context, 6666 is simply a number with no special significance beyond its value as a numerical quantity.','2024-11-09 12:32:45.484745',2),(54,'text','你好，我是徐子力','你好，徐子力！很高兴认识你。我是一个人工智能助手，随时准备帮助你解答问题或提供帮助。请问有什么我可以帮助你的吗？','2024-11-09 12:33:33.500372',2),(55,'text','你好我是黄宏韬','你好！我叫 Yi，是一个人工智能助手。很高兴认识你，黄宏韬。请问有什么我可以帮助你的吗？','2024-11-09 12:35:53.647009',2),(56,'image','图片','画面的描画由一个黑色的圆柱和一个短的圆柱构成。\n\n\n','2024-11-09 13:00:30.641148',2),(57,'image','图片','The graph depicts a downward sloping line, likely representing economic development. It shows economic activity hover ing around its \"tipp ing point ,\" with a slight upward slope. The upward trend suggests that the economy might be growing, while the downward trend could indicate economic decline.','2024-11-09 13:01:42.684824',2),(58,'image','图片','The image depicts a dark night sky with a plane flying through the sky. The plane appears to be in flight, leaving a thin white trail in the sky .','2024-11-09 13:04:15.363793',2),(59,'image','图片','The image displays a small trail of light or line that stretches across the entire black background.','2024-11-09 13:07:07.042758',2),(60,'image','图片','The image displays a slender red line curv ing in a circular motion on a black background.','2024-11-09 13:07:24.139467',2),(61,'image','图片','The image displays a red line drawing of a long , slender, and possibly needle-like shape against a black background. The slenderness of these lines suggests an unusual ly long shape, and the drawing gives a sense of movement and movement within the shape.','2024-11-09 13:11:18.103820',2),(62,'image','图片','如图2的情况，我们可以看看其中如何现象。\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n','2024-11-09 13:12:03.776352',2),(63,'text','hello','Hello! How can I assist you today? If you have any questions or need information on a specific topic, feel free to ask.','2024-11-09 13:12:42.237835',2),(64,'text','默写蜀道难','《蜀道难》是唐代诗人李白的代表作之一，全诗如下：\n\n蜀道难，难于上青天。\n使人听此凋朱颜。\n连峰去天不盈尺，\n枯松倒挂倚绝壁。\n飞沙走石万壑雷，\n壮士悲歌行路难。\n\n问君西游何时还？\n畏途巉岩不可攀。\n但见悲鸟号古木，\n雄飞沙走石万壑雷，\n壮士悲歌行路难。\n\n剑阁峥嵘而崔嵬，\n一夫当关，万夫莫开。\n所守或匪亲，\n化为狼与豺。\n朝避猛虎，夕避长蛇，\n磨牙吮血，杀人如麻。\n\n锦城虽云乐，\n不如早还家。\n蜀道之难，难于上青天，\n侧身西望长咨嗟。','2024-11-09 13:17:57.515087',2),(65,'text','默写沁园春 雪（毛泽东）','《沁园春·雪》是毛泽东主席创作的一首词，原文如下：\n\n北国风光，千里冰封，万里雪飘。\n望长城内外，惟余莽莽；\n大河上下，顿失滔滔。\n山舞银蛇，原驰蜡象，\n欲与天公试比高。\n须晴日，看红装素裹，分外妖娆。\n\n江山如此多娇，引无数英雄竞折腰。\n惜秦皇汉武，略输文采；\n唐宗宋祖，稍逊风骚。\n一代天骄，成吉思汗，\n只识弯弓射大雕。\n俱往矣，数风流人物，还看今朝。\n\n这首词描绘了北国冬季的壮阔雪景，抒发了词人对祖国山河的热爱，以及对历史英雄人物的评价。词中运用了大量的形象比喻，展现了毛泽东独特的文风和胸怀。','2024-11-09 13:20:23.380082',2),(66,'image','图片','The image displays a black background, with a red scribbled line across the top right corner .','2024-11-10 10:21:09.648628',2),(67,'text','222','222 是一个数字，通常用于表示一个数值为 222 的整数。在不同的上下文中，这个数字可能会有不同的含义。例如：\n\n- 在数学中，222 是一个自然数，可以参与各种数学运算。\n- 在计数中，222 可以用来表示物体的数量。\n- 在编号系统中，222 可以用来给事物排序。\n- 在密码学中，222 可以是一个加密或解密过程中的数值。\n- 在数字签名中，222 可以是一个用于验证消息完整性和发送者身份的数值。\n- 在电子通信中，222 可以是一个特定的错误代码或状态码。\n\n如果你是在一个特定的情境中看到或听到数字 222，它可能会有特定的含义。如果没有具体的上下文，222 就是一个普通的整数。','2024-11-10 10:22:34.198648',2),(68,'text','24242','当然可以，亲爱的朋友。在这个忙碌的世界里，希望我的温柔话语能给你带来一丝宁静与温暖。如果你有任何需要帮助的地方，或者只是想要聊聊天，我都会在这里陪着你。请随时告诉我你的想法或感受，我在这里倾听。','2024-11-10 10:33:20.109225',2),(69,'text','你好','你好呀，亲爱的朋友，今天有什么可以帮助你的吗？请随意告诉我你的需求，我会用最温柔的语气为你解答。','2024-11-10 10:33:32.530658',2),(70,'text','你是谁','你好呀，我是人工智能助手，很高兴在这里遇见你。有什么可以帮助你的吗？我会用温柔的语气陪伴你。','2024-11-10 10:33:43.170646',2),(71,'text','你是什么模型','我是一个人工智能助手，基于大型语言模型构建的。我的设计目的是为了提供信息、解答疑问以及与用户进行友好的互动。温柔地来说，我就像是一个贴心的朋友，随时准备倾听你的分享和帮助你解决问题。有什么我可以帮到你的吗？','2024-11-10 10:34:00.022736',2),(72,'text','按照鲁迅的风格写一篇文章','在这个喧嚣的世界里，我独坐一隅，手中握着一卷泛黄的书页，眼前是一片静谧的景致。微风轻拂，带着淡淡的清香，仿佛在诉说着岁月的温柔。\n\n时光如流水，匆匆而过，那些曾经的欢笑与泪水，如今已化作心底的涟漪。我常常想，这世间万物，何其渺小，又何其伟大。我们如同尘埃，在这浩瀚的宇宙中，寻找着自己的位置。\n\n记得那是一个春日的午后，阳光明媚，万物复苏。我漫步在乡间的小路上，两旁是郁郁葱葱的树木，鸟儿在枝头欢快地歌唱。那一刻，我仿佛置身于仙境，忘却了尘世的烦恼。\n\n路旁，一位老者正在悠闲地晒太阳，他的脸上刻满了岁月的痕迹，但眼中却闪烁着智慧的光芒。我走上前去，与他攀谈起来。他告诉我，人生就像这四季，有春的生机，夏的炎热，秋的收获，冬的寂静。每一个季节都有它的美好，只要我们用心去感受，便能找到属于自己的幸福。\n\n我静静地听着，心中涌起一股暖流。是啊，人生百态，各有其味。我们不必羡慕他人的辉煌，也不必自怨自艾。只要我们珍惜眼前的时光，用心去生活，便能在这纷繁的世界中找到属于自己的那一份宁静。\n\n岁月如歌，时光荏苒。那些曾经的梦想，如今已渐行渐远。我们曾以为，自己可以改变世界，却发现，世界早已改变了我们。然而，这又何妨？只要我们心中仍有信念，仍有追求，便能在人生的道路上，继续前行。\n\n在这个喧嚣的时代，我们常常被各种诱惑所包围。金钱、名利、地位，这些看似美好的东西，却往往让我们迷失了方向。我们追逐着它们，却忘记了最初的自己。我想，我们应该学会放下，放下那些无谓的执着，去寻找那颗曾经纯真的心。\n\n人生如梦，梦醒时分，我们才发现，原来自己一直在追寻的，不过是那份最初的简单与纯粹。让我们放下世俗的枷锁，回归内心，去感受那份来自岁月的温柔。\n\n在这个充满变数的世界里，愿我们都能找到属于自己的那一份宁静，像那老者所说，珍惜每一个季节，用心去生活，去感受这世间万物的美好。如此，我们的人生，便如同这春日的阳光，温暖而明媚。','2024-11-10 10:45:19.413364',2),(73,'text','你好','你好呀，亲爱的朋友，今天有什么可以帮助你的吗？请随意告诉我你的需求，我会用最温柔的语气为你解答。','2024-11-11 10:18:53.821572',2),(74,'text','1','当然可以，亲爱的朋友。在这个快节奏的世界里，希望我的温柔话语能给你带来一丝宁静与温暖。如果你有任何问题或者需要帮助，请随时告诉我，我在这里陪伴你。','2024-11-12 11:07:13.805669',2),(75,'text','你好','你好呀，亲爱的朋友，今天有什么可以帮助你的吗？请随意告诉我你的需求，我会用最温柔的语气为你解答。','2024-11-12 11:08:01.022091',2),(76,'text','帮我讲个故事','当然可以。在一个阳光明媚的午后，有一只名叫小鹿的小动物，它住在一个宁静的森林里。小鹿拥有一双明亮的眼睛，它的皮毛柔软如同云朵，总是带着一丝温柔的微笑。\n\n小鹿喜欢在清晨的第一缕阳光下，沿着森林小径漫步。这一天，它遇到了一只名叫小松鼠的小动物。小松鼠正忙于收集坚果，准备过冬。小鹿好奇地问：“小松鼠，你为什么这么忙碌呢？”\n\n小松鼠停下手中的活儿，抬头看着小鹿，微笑着说：“小鹿，你知道吗？冬天很快就要来了，我得储存足够的食物，才能度过寒冷的冬天。”\n\n小鹿听了，心里有些担忧，它问：“那我们该怎么办呢？”\n\n小松鼠想了想，说：“我们可以一起努力，互相帮助。你可以在森林里寻找美味的野果，而我负责收集坚果。这样，我们就能度过这个冬天了。”\n\n于是，小鹿和小松鼠成了好朋友，他们一起在森林里忙碌着。每当小鹿找到美味的野果，它都会高兴地跑去找小松鼠分享。而小松鼠也会把收集到的坚果分给小鹿。\n\n时间过得很快，冬天终于来临了。小鹿和小松鼠在森林里度过了一个又一个寒冷的日子。他们互相温暖着对方，度过了这个艰难的冬天。\n\n春天来临，冰雪融化，万物复苏。小鹿和小松鼠在森林里重逢，他们相视而笑，感慨万分。从那以后，他们成为了森林里最要好的朋友，一起度过了无数美好的时光。\n\n这个故事告诉我们，友谊的力量是无穷的。只要我们互相帮助，团结一心，就能战胜一切困难。在这个世界上，温柔和善良是最美的风景。','2024-11-12 11:08:21.847681',2),(77,'image','图片','The image features a scen ic scene of a large stone wall, possibly some type of fortress. It stretches across the entire image, from left to right . The re are several small buildings in the background, some with green roofs, creating a charming and picturesque atmosphere. \n\nA small, green bird is perched on top of one of the buildings, adding a touch of nature to the scene. The overall scene exudes a sense of calm ness and serenity, perfect for a relaxing break or quiet reflection.','2024-11-18 06:04:29.093505',2),(78,'image','图片','A graph of a \"normal\" curve, with the x-axis labeled \"height\", and the y-axis labeled \"height of curve\". The graph\'s points form a line that extends from the x-axis to the y-axis.','2024-11-19 06:46:55.026504',2),(79,'image','图片','The image displays two circles in opposite directions. The first circle is at the top -left, and the second circle is at the top -right.\n','2024-11-19 06:48:22.821054',2);
/*!40000 ALTER TABLE `draw_banner_chatmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draw_banner_drawing`
--

DROP TABLE IF EXISTS `draw_banner_drawing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draw_banner_drawing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `feedback` longtext,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `draw_banner_drawing_user_id_f43fe36b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `draw_banner_drawing_user_id_f43fe36b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draw_banner_drawing`
--

LOCK TABLES `draw_banner_drawing` WRITE;
/*!40000 ALTER TABLE `draw_banner_drawing` DISABLE KEYS */;
INSERT INTO `draw_banner_drawing` VALUES (1,'222','saved_drawings/222.png','222','2024-11-08 08:51:22.033455',2),(2,'4444','saved_drawings/4444.png','2222','2024-11-08 08:52:51.334399',2),(3,'','saved_drawings/drawing.png','','2024-11-08 09:44:55.306985',2),(4,'','saved_drawings/drawing_vejf5a9.png','','2024-11-08 12:36:32.934973',2),(5,'1111','saved_drawings/1111.png','222','2024-11-09 07:18:33.841567',2),(6,'111','saved_drawings/111.png','333','2024-11-09 13:25:59.113670',2),(7,'五角星','saved_drawings/五角星.png','2222','2024-11-10 10:42:12.479546',2),(8,'foolish徐子力','saved_drawings/foolish徐子力.png','徐子力大傻逼','2024-11-17 09:34:20.453606',2),(9,'默认名称','saved_drawings/微信图片_20241029211526.jpg','','2024-11-17 11:17:05.840698',2),(10,'默认名称','saved_drawings/微信图片_20241029211552.jpg','','2024-11-17 11:18:09.226652',2),(11,'给销售公司','saved_drawings/5d13c63b-f9c6-4fc7-a40c-37ee99e17fc8_ySCjc4i.jpg','如果有热阿汤哥','2024-11-17 11:36:24.767077',2),(12,'佛挡杀佛','saved_drawings/5d13c63b-f9c6-4fc7-a40c-37ee99e17fc8.jpg','而是','2024-11-17 11:45:11.138541',2),(13,'公正司法如果','saved_drawings/cc7fc087-718a-4641-8959-3ac19aa1f84f_wEI9qPY_F153iNr.jpg','gaRT','2024-11-17 11:46:09.599984',2),(14,'gsgsfzdsgg','saved_drawings/陈费琦万里长城_350x260.jpg','fafasgadgfadgfadgfa','2024-11-17 11:49:26.128385',2),(15,'黄宏韬','saved_drawings/周籽涵学画星空_350x260.jpg','哈哈哈哈','2024-11-17 11:55:37.043685',2),(16,'二娃让','saved_drawings/雍措央金我理想的未来城市_350x260.jpg','让娃二娃','2024-11-17 12:00:24.636317',2);
/*!40000 ALTER TABLE `draw_banner_drawing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_profile`
--

DROP TABLE IF EXISTS `login_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `login_profile_user_id_2714a7c6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_profile`
--

LOCK TABLES `login_profile` WRITE;
/*!40000 ALTER TABLE `login_profile` DISABLE KEYS */;
INSERT INTO `login_profile` VALUES (1,'student',1),(2,'student',3);
/*!40000 ALTER TABLE `login_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-19 14:58:57
