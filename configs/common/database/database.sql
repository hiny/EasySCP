--
-- EasySCP a Virtual Hosting Control Panel
-- Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--
-- @link 		http://www.easyscp.net
-- @author 		EasySCP Team
-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(10) unsigned NOT NULL auto_increment,
  `admin_name` varchar(200) collate utf8_unicode_ci default NULL,
  `admin_pass` varchar(200) collate utf8_unicode_ci default NULL,
  `admin_type` varchar(10) collate utf8_unicode_ci default NULL,
  `domain_created` int(10) unsigned NOT NULL default '0',
  `customer_id` varchar(200) collate utf8_unicode_ci default '0',
  `created_by` int(10) unsigned default '0',
  `fname` varchar(200) collate utf8_unicode_ci default NULL,
  `lname` varchar(200) collate utf8_unicode_ci default NULL,
  `gender` varchar(1) collate utf8_unicode_ci default NULL,
  `firm` varchar(200) collate utf8_unicode_ci default NULL,
  `zip` varchar(10) collate utf8_unicode_ci default NULL,
  `city` varchar(200) collate utf8_unicode_ci default NULL,
  `state` varchar(200) collate utf8_unicode_ci default NULL,
  `country` varchar(200) collate utf8_unicode_ci default NULL,
  `email` varchar(200) collate utf8_unicode_ci default NULL,
  `phone` varchar(200) collate utf8_unicode_ci default NULL,
  `fax` varchar(200) collate utf8_unicode_ci default NULL,
  `street1` varchar(200) collate utf8_unicode_ci default NULL,
  `street2` varchar(200) collate utf8_unicode_ci default NULL,
  `uniqkey` varchar(255) collate utf8_unicode_ci default NULL,
  `uniqkey_time` timestamp NULL default NULL,
  UNIQUE KEY `admin_id` (`admin_id`),
  UNIQUE KEY `admin_name` (`admin_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autoreplies_log`
--

CREATE TABLE IF NOT EXISTS `autoreplies_log` (
  `time` DATETIME NOT NULL COMMENT 'Date and time of the sent autoreply',
  `from` VARCHAR( 255 ) NOT NULL COMMENT 'autoreply message sender',
  `to` VARCHAR( 255 ) NOT NULL COMMENT 'autoreply message recipient',
  INDEX ( `time` )
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_unicode_ci COMMENT = 'Sent autoreplies log table';

-- --------------------------------------------------------

--
-- Table structure for table `auto_num`
--

CREATE TABLE IF NOT EXISTS `auto_num` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `msg` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `name` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `value` longtext collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`name`, `value`) VALUES
('PORT_AMAVIS', '10024;tcp;AMaVis;0;1;localhost'),
('PORT_DNS', '53;tcp;DNS;1;0;'),
('PORT_FTP', '21;tcp;FTP;1;0;'),
('PORT_HTTP', '80;tcp;HTTP;1;0;'),
('PORT_HTTPS', '443;tcp;HTTPS;0;0;'),
('PORT_IMAP', '143;tcp;IMAP;1;0;'),
('PORT_IMAP-SSL', '993;tcp;IMAP-SSL;0;0;'),
('PORT_POLICYD-WEIGHT', '12525;tcp;POLICYD-WEIGHT;1;1;localhost'),
('PORT_POP3', '110;tcp;POP3;1;0;'),
('PORT_POP3-SSL', '995;tcp;POP3-SSL;0;0;'),
('PORT_POSTGREY', '10023;tcp;POSTGREY;1;1;localhost'),
('PORT_SMTP', '25;tcp;SMTP;1;0;'),
('PORT_SMTP-SSL', '465;tcp;SMTP-SSL;1;0;'),
('PORT_SPAMASSASSIN', '783;tcp;SPAMASSASSIN;0;1;localhost'),
('PORT_SSH', '22;tcp;SSH;1;1;'),
('PORT_TELNET', '23;tcp;TELNET;1;0;'),
('SHOW_COMPRESSION_SIZE', '1'),
('PREVENT_EXTERNAL_LOGIN_ADMIN', '1'),
('PREVENT_EXTERNAL_LOGIN_RESELLER', '1'),
('PREVENT_EXTERNAL_LOGIN_CLIENT', '1'),
('SSL_KEY',''),
('SSL_CERT',''),
('SSL_STATUS',0),
('MIGRATION_ENABLED',0),
('DATABASE_REVISION', '52');

-- --------------------------------------------------------

--
-- Table structure for table `custom_menus`
--

CREATE TABLE IF NOT EXISTS `custom_menus` (
  `menu_id` int(10) unsigned NOT NULL auto_increment,
  `menu_level` varchar(10) collate utf8_unicode_ci default NULL,
  `menu_name` varchar(255) collate utf8_unicode_ci default NULL,
  `menu_link` varchar(200) collate utf8_unicode_ci default NULL,
  `menu_target` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `menu_icon` varchar(200) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `domain_id` int(10) unsigned NOT NULL auto_increment,
  `domain_name` varchar(200) collate utf8_unicode_ci default NULL,
  `domain_gid` int(10) unsigned NOT NULL default '0',
  `domain_uid` int(10) unsigned NOT NULL default '0',
  `domain_admin_id` int(10) unsigned NOT NULL default '0',
  `domain_created_id` int(10) unsigned NOT NULL default '0',
  `domain_created` int(10) unsigned NOT NULL default '0',
  `domain_expires` int(10) unsigned NOT NULL default '0',
  `domain_last_modified` int(10) unsigned NOT NULL default '0',
  `domain_mailacc_limit` int(11) default NULL,
  `domain_ftpacc_limit` int(11) default NULL,
  `domain_traffic_limit` bigint(20) default NULL,
  `domain_sqld_limit` int(11) default NULL,
  `domain_sqlu_limit` int(11) default NULL,
  `domain_status` varchar(255) collate utf8_unicode_ci default NULL,
  `domain_alias_limit` int(11) default NULL,
  `domain_subd_limit` int(11) default NULL,
  `domain_ip_id` int(10) unsigned default NULL,
  `domain_disk_limit` bigint(20) unsigned default NULL,
  `domain_disk_usage` bigint(20) unsigned default NULL,
  `domain_php` varchar(15) collate utf8_unicode_ci default NULL,
  `domain_cgi` varchar(15) collate utf8_unicode_ci default NULL,
  `allowbackup` varchar(8) collate utf8_unicode_ci NOT NULL default 'full',
  `domain_dns` varchar(15) collate utf8_unicode_ci NOT NULL default 'no',
  `domain_ssl` varchar(15) collate utf8_unicode_ci NOT NULL default 'no',
  `ssl_key` varchar(5000) collate utf8_unicode_ci NULL default NULL,
  `ssl_cert` varchar(5000) collate utf8_unicode_ci NULL default NULL,
  `ssl_status` int(1) unsigned NOT NULL default '0',
  UNIQUE KEY `domain_id` (`domain_id`),
  UNIQUE KEY `domain_name` (`domain_name`),
  KEY `i_domain_admin_id` (`domain_admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domain_aliasses`
--

CREATE TABLE IF NOT EXISTS `domain_aliasses` (
  `alias_id` int(10) unsigned NOT NULL auto_increment,
  `domain_id` int(10) unsigned default NULL,
  `alias_name` varchar(200) collate utf8_unicode_ci default NULL,
  `alias_status` varchar(255) collate utf8_unicode_ci default NULL,
  `alias_mount` varchar(200) collate utf8_unicode_ci default NULL,
  `alias_ip_id` int(10) unsigned default NULL,
  `url_forward` varchar(200) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`alias_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domain_dns`
--

CREATE TABLE IF NOT EXISTS `domain_dns` (
  `domain_dns_id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) NOT NULL,
  `alias_id` int(11) NOT NULL,
  `domain_dns` varchar(50) collate utf8_unicode_ci NOT NULL,
  `domain_class` enum('IN','CH','HS') collate utf8_unicode_ci NOT NULL default 'IN',
  `domain_type` enum('A','AAAA','CERT','CNAME','DNAME','GPOS','KEY','KX','MX','NAPTR','NSAP','NS','NXT','PTR','PX','SIG','SRV','TXT') collate utf8_unicode_ci NOT NULL default 'A',
  `domain_text` varchar(128) collate utf8_unicode_ci NOT NULL,
  `protected` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no', 
  PRIMARY KEY  (`domain_dns_id`),
  UNIQUE KEY `domain_id` (`domain_id`,`alias_id`,`domain_dns`,`domain_class`,`domain_type`,`domain_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domain_traffic`
--

CREATE TABLE IF NOT EXISTS `domain_traffic` (
  `dtraff_id` int(10) unsigned NOT NULL auto_increment,
  `domain_id` int(10) unsigned default NULL,
  `dtraff_time` bigint(20) unsigned default NULL,
  `dtraff_web` bigint(20) unsigned default NULL,
  `dtraff_ftp` bigint(20) unsigned default NULL,
  `dtraff_mail` bigint(20) unsigned default NULL,
  `dtraff_pop` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`dtraff_id`),
  KEY `i_domain_id` (`domain_id`),
  KEY `i_dtraff_time` (`dtraff_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_tpls`
--

CREATE TABLE IF NOT EXISTS `email_tpls` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `owner_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(200) collate utf8_unicode_ci default NULL,
  `subject` varchar(200) collate utf8_unicode_ci default NULL,
  `message` text collate utf8_unicode_ci,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `error_pages`
--

CREATE TABLE IF NOT EXISTS `error_pages` (
  `ep_id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `error_401` text collate utf8_unicode_ci NOT NULL,
  `error_403` text collate utf8_unicode_ci NOT NULL,
  `error_404` text collate utf8_unicode_ci NOT NULL,
  `error_500` text collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`ep_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ftp_group`
--

CREATE TABLE IF NOT EXISTS `ftp_group` (
  `groupname` varchar(255) collate utf8_unicode_ci default NULL,
  `gid` int(10) unsigned NOT NULL default '0',
  `members` text collate utf8_unicode_ci,
  UNIQUE KEY `groupname` (`groupname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ftp_users`
--

CREATE TABLE IF NOT EXISTS `ftp_users` (
  `userid` varchar(255) collate utf8_unicode_ci default NULL,
  `passwd` varchar(255) collate utf8_unicode_ci default NULL,
  `net2ftppasswd` varchar(255) collate utf8_unicode_ci default NULL,
  `uid` int(10) unsigned NOT NULL default '0',
  `gid` int(10) unsigned NOT NULL default '0',
  `shell` varchar(255) collate utf8_unicode_ci default NULL,
  `homedir` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hosting_plans`
--

CREATE TABLE IF NOT EXISTS `hosting_plans` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `reseller_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `props` text collate utf8_unicode_ci,
  `description` text collate utf8_unicode_ci,
  `price` decimal(10,2) NOT NULL default '0.00',
  `setup_fee` decimal(10,2) NOT NULL default '0.00',
  `value` varchar(255) collate utf8_unicode_ci default NULL,
  `payment` varchar(255) collate utf8_unicode_ci default NULL,
  `status` int(10) unsigned NOT NULL default '0',
  `tos`	BLOB NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `htaccess`
--

CREATE TABLE IF NOT EXISTS `htaccess` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dmn_id` int(10) unsigned NOT NULL default '0',
  `user_id` varchar(255) collate utf8_unicode_ci default NULL,
  `group_id` varchar(255) collate utf8_unicode_ci default NULL,
  `auth_type` varchar(255) collate utf8_unicode_ci default NULL,
  `auth_name` varchar(255) collate utf8_unicode_ci default NULL,
  `path` varchar(255) collate utf8_unicode_ci default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `htaccess_groups`
--

CREATE TABLE IF NOT EXISTS `htaccess_groups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dmn_id` int(10) unsigned NOT NULL default '0',
  `ugroup` varchar(255) collate utf8_unicode_ci default NULL,
  `members` text collate utf8_unicode_ci,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `htaccess_users`
--

CREATE TABLE IF NOT EXISTS `htaccess_users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dmn_id` int(10) unsigned NOT NULL default '0',
  `uname` varchar(255) collate utf8_unicode_ci default NULL,
  `upass` varchar(255) collate utf8_unicode_ci default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `log_id` int(10) unsigned NOT NULL auto_increment,
  `log_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `log_message` varchar(250) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`log_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `session_id` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `ipaddr` varchar(40) collate utf8_unicode_ci default NULL,
  `lastaccess` int(10) unsigned default NULL,
  `login_count` tinyint(1) default '0',
  `captcha_count` tinyint(1) default '0',
  `user_name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_users`
--

CREATE TABLE IF NOT EXISTS `mail_users` (
  `mail_id` int(10) unsigned NOT NULL auto_increment,
  `mail_acc` varchar(200) collate utf8_unicode_ci default NULL,
  `mail_pass` varchar(150) collate utf8_unicode_ci default NULL,
  `mail_forward` text collate utf8_unicode_ci,
  `domain_id` int(10) unsigned default NULL,
  `mail_type` varchar(30) collate utf8_unicode_ci default NULL,
  `sub_id` int(10) unsigned default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `mail_auto_respond` tinyint(1) NOT NULL default '0',
  `mail_auto_respond_text` text collate utf8_unicode_ci,
  `quota` int(10) default '104857600',
  `mail_addr` varchar(200) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`mail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `plan_id` int(10) unsigned NOT NULL default '0',
  `date` int(10) unsigned NOT NULL default '0',
  `domain_name` varchar(200) collate utf8_unicode_ci default NULL,
  `customer_id` varchar(200) collate utf8_unicode_ci default NULL,
  `fname` varchar(200) collate utf8_unicode_ci default NULL,
  `lname` varchar(200) collate utf8_unicode_ci default NULL,
  `gender` varchar(1) collate utf8_unicode_ci default NULL,
  `firm` varchar(200) collate utf8_unicode_ci default NULL,
  `zip` varchar(10) collate utf8_unicode_ci default NULL,
  `city` varchar(200) collate utf8_unicode_ci default NULL,
  `state` varchar(200) collate utf8_unicode_ci default NULL,
  `country` varchar(200) collate utf8_unicode_ci default NULL,
  `email` varchar(200) collate utf8_unicode_ci default NULL,
  `phone` varchar(200) collate utf8_unicode_ci default NULL,
  `fax` varchar(200) collate utf8_unicode_ci default NULL,
  `street1` varchar(200) collate utf8_unicode_ci default NULL,
  `street2` varchar(200) collate utf8_unicode_ci default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_settings`
--

CREATE TABLE IF NOT EXISTS `orders_settings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `header` text collate utf8_unicode_ci,
  `footer` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotalimits`
--

CREATE TABLE IF NOT EXISTS `quotalimits` (
  `name` varchar(30) collate utf8_unicode_ci NOT NULL default '',
  `quota_type` enum('user','group','class','all') collate utf8_unicode_ci NOT NULL default 'user',
  `per_session` enum('false','true') collate utf8_unicode_ci NOT NULL default 'false',
  `limit_type` enum('soft','hard') collate utf8_unicode_ci NOT NULL default 'soft',
  `bytes_in_avail` float NOT NULL default '0',
  `bytes_out_avail` float NOT NULL default '0',
  `bytes_xfer_avail` float NOT NULL default '0',
  `files_in_avail` int(10) unsigned NOT NULL default '0',
  `files_out_avail` int(10) unsigned NOT NULL default '0',
  `files_xfer_avail` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotatallies`
--

CREATE TABLE IF NOT EXISTS `quotatallies` (
  `name` varchar(30) collate utf8_unicode_ci NOT NULL default '',
  `quota_type` enum('user','group','class','all') collate utf8_unicode_ci NOT NULL default 'user',
  `bytes_in_used` float NOT NULL default '0',
  `bytes_out_used` float NOT NULL default '0',
  `bytes_xfer_used` float NOT NULL default '0',
  `files_in_used` int(10) unsigned NOT NULL default '0',
  `files_out_used` int(10) unsigned NOT NULL default '0',
  `files_xfer_used` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reseller_props`
--

CREATE TABLE IF NOT EXISTS `reseller_props` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `reseller_id` int(10) unsigned NOT NULL default '0',
  `current_dmn_cnt` int(11) default NULL,
  `max_dmn_cnt` int(11) default NULL,
  `current_sub_cnt` int(11) default NULL,
  `max_sub_cnt` int(11) default NULL,
  `current_als_cnt` int(11) default NULL,
  `max_als_cnt` int(11) default NULL,
  `current_mail_cnt` int(11) default NULL,
  `max_mail_cnt` int(11) default NULL,
  `current_ftp_cnt` int(11) default NULL,
  `max_ftp_cnt` int(11) default NULL,
  `current_sql_db_cnt` int(11) default NULL,
  `max_sql_db_cnt` int(11) default NULL,
  `current_sql_user_cnt` int(11) default NULL,
  `max_sql_user_cnt` int(11) default NULL,
  `current_disk_amnt` int(11) default NULL,
  `max_disk_amnt` int(11) default NULL,
  `current_traff_amnt` int(11) default NULL,
  `max_traff_amnt` int(11) default NULL,
  `support_system` ENUM( 'yes', 'no' ) NOT NULL DEFAULT 'yes',
  `customer_id` varchar(200) collate utf8_unicode_ci default NULL,
  `reseller_ips` text collate utf8_unicode_ci,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server_ips`
--

CREATE TABLE IF NOT EXISTS `server_ips` (
  `ip_id` int(10) unsigned NOT NULL auto_increment,
  `ip_number` varchar(40) collate utf8_unicode_ci default NULL,
  `ip_domain` varchar(200) collate utf8_unicode_ci default NULL,
  `ip_alias` varchar(200) collate utf8_unicode_ci default NULL,
  `ip_card` varchar(255) collate utf8_unicode_ci default NULL,
  `ip_ssl_domain_id` int(10) default NULL,
  `ip_status` varchar(255) collate utf8_unicode_ci default NULL,
  UNIQUE KEY `ip_id` (`ip_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server_traffic`
--

CREATE TABLE IF NOT EXISTS `server_traffic` (
  `straff_id` int(10) unsigned NOT NULL auto_increment,
  `traff_time` int(10) unsigned default NULL,
  `bytes_in` bigint(20) unsigned default NULL,
  `bytes_out` bigint(20) unsigned default NULL,
  `bytes_mail_in` bigint(20) unsigned default NULL,
  `bytes_mail_out` bigint(20) unsigned default NULL,
  `bytes_pop_in` bigint(20) unsigned default NULL,
  `bytes_pop_out` bigint(20) unsigned default NULL,
  `bytes_web_in` bigint(20) unsigned default NULL,
  `bytes_web_out` bigint(20) unsigned default NULL,
  PRIMARY KEY  (`straff_id`),
  KEY `traff_time` (`traff_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sql_database`
--

CREATE TABLE IF NOT EXISTS `sql_database` (
  `sqld_id` int(10) unsigned NOT NULL auto_increment,
  `domain_id` int(10) unsigned default '0',
  `sqld_name` varchar(64) character set utf8 collate utf8_bin default 'n/a',
  UNIQUE KEY `sqld_id` (`sqld_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sql_user`
--

CREATE TABLE IF NOT EXISTS `sql_user` (
  `sqlu_id` int(10) unsigned NOT NULL auto_increment,
  `sqld_id` int(10) unsigned default '0',
  `sqlu_name` varchar(64) collate utf8_unicode_ci default 'n/a',
  `sqlu_pass` varchar(64) collate utf8_unicode_ci default 'n/a',
  UNIQUE KEY `sqlu_id` (`sqlu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `straff_settings`
--

CREATE TABLE IF NOT EXISTS `straff_settings` (
  `straff_max` int(10) unsigned default NULL,
  `straff_warn` int(10) unsigned default NULL,
  `straff_email` int(10) unsigned default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `straff_settings`
--

INSERT INTO `straff_settings` (`straff_max`, `straff_warn`, `straff_email`) VALUES (0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subdomain`
--

CREATE TABLE IF NOT EXISTS `subdomain` (
  `subdomain_id` int(10) unsigned NOT NULL auto_increment,
  `domain_id` int(10) unsigned default NULL,
  `subdomain_name` varchar(200) collate utf8_unicode_ci default NULL,
  `subdomain_mount` varchar(200) collate utf8_unicode_ci default NULL,
  `subdomain_url_forward` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subdomain_status` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`subdomain_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subdomain_alias`
--

CREATE TABLE IF NOT EXISTS `subdomain_alias` (
  `subdomain_alias_id` int(10) unsigned NOT NULL auto_increment,
  `alias_id` int(10) unsigned default NULL,
  `subdomain_alias_name` varchar(200) collate utf8_unicode_ci default NULL,
  `subdomain_alias_mount` varchar(200) collate utf8_unicode_ci default NULL,
  `subdomain_alias_url_forward` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subdomain_alias_status` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`subdomain_alias_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE IF NOT EXISTS `tickets` (
  `ticket_id` int(10) unsigned NOT NULL auto_increment,
  `ticket_level` int(10) default NULL,
  `ticket_from` int(10) unsigned default NULL,
  `ticket_to` int(10) unsigned default NULL,
  `ticket_status` int(10) unsigned default NULL,
  `ticket_reply` int(10) unsigned default NULL,
  `ticket_urgency` int(10) unsigned default NULL,
  `ticket_date` int(10) unsigned default NULL,
  `ticket_subject` varchar(255) collate utf8_unicode_ci default NULL,
  `ticket_message` text collate utf8_unicode_ci,
  PRIMARY KEY  (`ticket_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_gui_props`
--

CREATE TABLE IF NOT EXISTS `user_gui_props` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `lang` varchar(255) collate utf8_unicode_ci default '',
  `layout` varchar(255) collate utf8_unicode_ci default '',
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
