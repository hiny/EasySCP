#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

ROOT_POSTFIX_CONF=$(ROOT_CONF)/postfix

export

install:

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)/postfix
	$(SYSTEM_MAKE_DIRS) $(ROOT_POSTFIX_CONF)
	$(SYSTEM_MAKE_DIRS) $(ROOT_POSTFIX_CONF)/easyscp

	cp ./main.cf $(SYSTEM_CONF)/postfix/main.cf
	cp ./master.cf $(SYSTEM_CONF)/postfix/master.cf

uninstall:

	rm -rf $(SYSTEM_CONF)/postfix
	rm -rf $(ROOT_POSTFIX_CONF)/easyscp
