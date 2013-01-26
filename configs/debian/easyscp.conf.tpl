# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

#
# Misc config variables
#

BuildDate = 20130112

Version = 1.1.10

CodeName = Orpheus

DistName = Debian

DEFAULT_ADMIN_ADDRESS =

SERVER_HOSTNAME = debian

BASE_SERVER_IP = 127.0.0.1

BASE_SERVER_VHOST =

BASE_SERVER_VHOST_PREFIX = http://

MR_LOCK_FILE = /var/run/easyscp.lock

#
# File system variables
#

CMD_AWK = /usr/bin/awk

CMD_BZCAT = /bin/bzcat

CMD_BZIP = /bin/bzip2

CMD_CAT = /bin/cat

CMD_CHMOD = /bin/chmod

CMD_CHOWN = /bin/chown

CMD_CMP = /usr/bin/cmp

CMD_CP = /bin/cp

CMD_DF = /bin/df

CMD_DIFF = /usr/bin/diff

CMD_DU = /usr/bin/du

CMD_ECHO = /bin/echo

CMD_EGREP = /bin/egrep

CMD_GREP = /bin/grep

CMD_GROUPADD = /usr/sbin/groupadd

CMD_GROUPDEL = /usr/sbin/groupdel

CMD_GZCAT = /bin/zcat

CMD_GZIP = /bin/gzip

CMD_HOSTNAME = /bin/hostname

CMD_IFCONFIG = /sbin/ifconfig

CMD_IPTABLES = /sbin/iptables

CMD_LN = /bin/ln

CMD_LZMA = /usr/bin/lzma

CMD_MV = /bin/mv

CMD_MYSQL = /usr/bin/mysql

CMD_PHP = /usr/bin/php5

CMD_PS = /bin/ps

CMD_RM = /bin/rm

CMD_SED = /bin/sed

CMD_SHELL = /bin/sh

CMD_TAR = /bin/tar

CMD_TOUCH = /usr/bin/touch

CMD_USERADD = /usr/sbin/useradd

CMD_USERDEL = /usr/sbin/userdel

CMD_WC = /usr/bin/wc

CMD_XZ = /usr/bin/xz

PEAR_DIR = /usr/share/php

#
# SQL backend variables
#

# Don't change this one
DATABASE_TYPE = mysql

DATABASE_HOST = localhost

DATABASE_NAME = easyscp

DATABASE_PASSWORD =

DATABASE_USER = root

DATABASE_DIR = /var/lib/mysql

CMD_MYSQLDUMP = /usr/bin/mysqldump

DATABASE_UTF8 = yes

#
# Main variables
#

CONF_DIR = /etc/easyscp

LOG_DIR = /var/log/easyscp

PHP_STARTER_DIR = /var/www/fcgi

ROOT_DIR = /var/www/easyscp

ROOT_USER = root

ROOT_GROUP = root

GUI_ROOT_DIR = /var/www/easyscp/gui

APACHE_WWW_DIR = /var/www/virtual

SCOREBOARDS_DIR = /var/www/scoreboards

# Select Zipping Algorithm for Backups
# Make sure the selected Algorithm is installed
# and tar command supports "--$ZIP" -> will mostly work with bzip2 & gzip
# Supported: gzip, bzip2, lzma, xz
ZIP = bzip2

#
# PHP fcgi data
#

PHP_FCGID_CONF_FILE = fcgid.load

PHP5_FASTCGI_BIN = /usr/bin/php5-cgi

PHP_VERSION = 5

PHP_TIMEZONE =

#
# ProFTPd data
#

FTPD_CONF_FILE = /etc/proftpd/proftpd.conf

FTPD_CONF_DIR = /etc/proftpd/easyscp

#
# BIND data
#

BIND_CONF_FILE = /etc/bind/named.conf

BIND_DB_DIR = /var/cache/bind

SECONDARY_DNS =

#
# Resolver
#

RESOLVER_CONF_FILE = /etc/resolv.conf

LOCAL_DNS_RESOLVER =

#
# AWSTATS data
#

AWSTATS_ACTIVE = no

# could be 'dynamic' = 0 or 'static' = 1
AWSTATS_MODE = 0

AWSTATS_CACHE_DIR = /var/cache/awstats

AWSTATS_CONFIG_DIR = /etc/awstats

AWSTATS_ENGINE_DIR = /usr/lib/cgi-bin

AWSTATS_WEB_DIR = /usr/share/awstats

AWSTATS_ROOT_DIR = /var/www/easyscp/engine/awstats

AWSTATS_GROUP_AUTH = statistics

#
# APACHE data
#

APACHE_NAME = apache2

APACHE_RESTART_TRY = 3

APACHE_CONF_DIR = /etc/apache2

APACHE_LOG_DIR = /var/log/apache2

APACHE_BACKUP_LOG_DIR = /var/log/apache2/backup

APACHE_USERS_LOG_DIR = /var/log/apache2/users

APACHE_MODS_DIR = /etc/apache2/mods-available

APACHE_SITES_DIR = /etc/apache2/sites-available

APACHE_CUSTOM_SITES_CONFIG_DIR = /etc/apache2/easyscp

APACHE_SUEXEC_USER_PREF = vu

APACHE_SUEXEC_MIN_GID = 2000

APACHE_SUEXEC_MAX_GID = 29999

APACHE_SUEXEC_MIN_UID = 2000

APACHE_SUEXEC_MAX_UID = 29999

APACHE_USER = www-data

APACHE_GROUP = www-data

#
# Postfix MTA Data
#

POSTFIX_CONF_FILE = /etc/postfix/main.cf

POSTFIX_MASTER_CONF_FILE = /etc/postfix/master.cf

MTA_LOCAL_MAIL_DIR = /var/mail

MTA_VIRTUAL_MAIL_DIR = /var/mail/virtual

MTA_LOCAL_ALIAS_HASH = /etc/aliases

MTA_VIRTUAL_CONF_DIR = /etc/postfix/easyscp

MTA_VIRTUAL_ALIAS_HASH = /etc/postfix/easyscp/aliases

MTA_VIRTUAL_DMN_HASH = /etc/postfix/easyscp/domains

MTA_VIRTUAL_MAILBOX_HASH = /etc/postfix/easyscp/mailboxes

MTA_TRANSPORT_HASH = /etc/postfix/easyscp/transport

MTA_SENDER_ACCESS_HASH = /etc/postfix/easyscp/sender-access

MTA_MAILBOX_MIN_UID = 1004

MTA_MAILBOX_UID = 1004

MTA_MAILBOX_UID_NAME = vmail

MTA_MAILBOX_GID = 8

MTA_MAILBOX_GID_NAME = mail

MTA_SASLDB_FILE = /var/spool/postfix/etc/sasldb2

ETC_SASLDB_FILE = /etc/sasldb2

CMD_SASLDB_LISTUSERS2 = /usr/sbin/sasldblistusers2

CMD_SASLDB_PASSWD2 = /usr/sbin/saslpasswd2

CMD_POSTMAP = /usr/sbin/postmap

CMD_NEWALIASES = /usr/bin/newaliases

#
# Postgrey data
#

PORT_POSTGREY = 10023

#
# Courier data
#

AUTHLIB_CONF_DIR = /etc/courier

CMD_MAKEUSERDB = /usr/sbin/makeuserdb

#
# Crontab delayed tasks
#

BACKUP_HOUR = 23

BACKUP_MINUTE = 40

# Tells whether the EasySCP database and
# all /etc/easyscp/* files should be daily saved
BACKUP_EASYSCP = yes

# Tells whether all the customers' data should be daily saved
# Saved data depend of the domain properties (dmn|sql|all)
BACKUP_DOMAINS = yes

BACKUP_ROOT_DIR = /var/www/easyscp/engine/backup

CMD_CRONTAB = /usr/bin/crontab

#
# Service manager
#

# Either no or path to the amavis-daemon (usually: /etc/init.d/amavis)
CMD_AMAVIS = no

CMD_AUTHD = /etc/init.d/courier-authdaemon

CMD_FTPD = /etc/init.d/proftpd

CMD_HTTPD_CTL = /usr/sbin/apache2ctl

CMD_HTTPD = /etc/init.d/apache2

CMD_IMAP = /etc/init.d/courier-imap

CMD_IMAP_SSL = no

CMD_POSTGREY = /etc/init.d/postrey

CMD_POLICYD_WEIGHT = /etc/init.d/policyd-weight

CMD_MTA = /etc/init.d/postfix

CMD_NAMED = /etc/init.d/bind9

CMD_POP = /etc/init.d/courier-pop

CMD_POP_SSL = no

CMD_EASYSCPD = /etc/init.d/easyscp_daemon

CMD_EASYSCPN = /etc/init.d/easyscp_network

#
# Virtual traffic manager
#

CMD_PFLOGSUM = /usr/sbin/maillogconvert.pl

TRAFF_LOG_DIR = /var/log

FTP_TRAFF_LOG = /proftpd/ftp_traff.log

MAIL_TRAFF_LOG = mail.log

TRAFF_ROOT_DIR = /var/www/easyscp/engine/traffic

TOOLS_ROOT_DIR = /var/www/easyscp/engine/tools

QUOTA_ROOT_DIR = /var/www/easyscp/engine/quota

#
# AMaViS data
#

MAIL_LOG_INC_AMAVIS = 0

#
# GUI config
#

FTP_USERNAME_SEPARATOR = @

FTP_HOMEDIR = /var/www/virtual

MYSQL_PREFIX = no

# '' for MYSQL_PREFIX = no,
# 'infront' or 'behind' for MYSQL_PREFIX = yes
MYSQL_PREFIX_TYPE =

WEBMAIL_PATH = /webmail/

# Please, do not change it manually
# This entry is used for the update/recovery process
PMA_USER = pma

PMA_PATH = /pma/

FILEMANAGER_PATH = /ftp/

DATE_FORMAT = d.m.Y

RKHUNTER_LOG = /var/log/rkhunter.log

CHKROOTKIT_LOG = /var/log/chkrootkit.log

# Here you can set an additional anti-rootkit tool log file
OTHER_ROOTKIT_LOG =

#
# htaccess management
#

HTACCESS_USERS_FILE_NAME = .htpasswd

HTACCESS_GROUPS_FILE_NAME = .htgroup

HTPASSWD_CMD = /usr/bin/htpasswd2

#
# backup management
#

BACKUP_FILE_DIR = /var/www/easyscp/backups

#
# Exception Writers Observers
#
# Availables Writers are:
# - Mail
#
# Note: Other writers will be added later
#
GUI_EXCEPTION_WRITERS = mail

#
# Debug Mode (e.g. for developers)
# options: 0 = off, 1 = on
#

DEBUG = 0
