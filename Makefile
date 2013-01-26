#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

ifndef INST_PREF
        INST_PREF=/tmp/easyscp
endif

HOST_OS=debian

ROOT_CONF=$(INST_PREF)/etc

SYSTEM_ROOT=$(INST_PREF)/var/www/easyscp
SYSTEM_CONF=$(INST_PREF)/etc/easyscp
SYSTEM_LOG=$(INST_PREF)/var/log/easyscp
SYSTEM_APACHE_BACK_LOG=$(INST_PREF)/var/log/apache2/backup
SYSTEM_VIRTUAL=$(INST_PREF)/var/www/virtual
SYSTEM_AWSTATS=$(INST_PREF)/var/www/awstats
SYSTEM_FCGI=$(INST_PREF)/var/www/fcgi
SYSTEM_SCOREBOARDS=$(INST_PREF)/var/www/scoreboards
SYSTEM_MAIL_VIRTUAL=$(INST_PREF)/var/mail/virtual
SYSTEM_MAKE_DIRS=/bin/mkdir -p
SYSTEM_MAKE_FILE=/bin/touch

export

install:

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_ROOT)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_LOG)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_LOG)/easyscp-arpl-msgr
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_VIRTUAL)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_FCGI)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_SCOREBOARDS)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_AWSTATS)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_MAIL_VIRTUAL)
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_APACHE_BACK_LOG)

	cd ./configs && $(MAKE) install
	cd ./daemon && $(MAKE) install
	cd ./engine && $(MAKE) install
	cd ./gui && $(MAKE) install

uninstall:

	cd ./configs && $(MAKE) uninstall
	cd ./daemon && $(MAKE) uninstall
	cd ./engine && $(MAKE) uninstall
	cd ./gui && $(MAKE) uninstall

	rm -rf $(SYSTEM_CONF)
	rm -rf $(SYSTEM_ROOT)
	rm -rf $(SYSTEM_LOG)
	rm -rf $(SYSTEM_VIRTUAL)
	rm -rf $(SYSTEM_FCGI)
	rm -rf $(SYSTEM_SCOREBOARDS)
	rm -rf $(SYSTEM_MAIL_VIRTUAL)
	rm -rf $(SYSTEM_APACHE_BACK_LOG)

clean:

	rm -rf $(INST_PREF)

.PHONY: install uninstall clean
