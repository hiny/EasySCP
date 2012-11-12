#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

install:
	cp ./easyscp_config_db.tpl $(SYSTEM_CONF)
	cp -R ./apache $(SYSTEM_CONF)
	cp -R ./awstats $(SYSTEM_CONF)
	cp -R ./database $(SYSTEM_CONF)
	cp -R ./fcgi $(SYSTEM_CONF)
	cp -R ./pdns $(SYSTEM_CONF)
	cp -R ./pma $(SYSTEM_CONF)
	cp -R ./postfix $(SYSTEM_CONF)
	cp -R ./roundcube $(SYSTEM_CONF)

uninstall:
	rm -rf $(SYSTEM_CONF)/easyscp_config_db.php
	rm -rf $(SYSTEM_CONF)/easyscp_config_db.tpl
	rm -rf $(SYSTEM_CONF)/apache
	rm -rf $(SYSTEM_CONF)/awstats
	rm -rf $(SYSTEM_CONF)/database
	rm -rf $(SYSTEM_CONF)/fcgi
	rm -rf $(SYSTEM_CONF)/pdns
	rm -rf $(SYSTEM_CONF)/pma
	rm -rf $(SYSTEM_CONF)/postfix
	rm -rf $(SYSTEM_CONF)/roundcube

.PHONY: install uninstall
