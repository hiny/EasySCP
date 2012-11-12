#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

export

install:
	if test $(HOST_OS) = opensuse ; then \
		cp ./easyscp.conf $(SYSTEM_CONF) ; \
		cd ./amavisd && $(MAKE) install ; cd .. ; \
		cd ./apache && $(MAKE) install ; cd .. ; \
		cd ./courier && $(MAKE) install ; cd .. ; \
		cd ./cron.d && $(MAKE) install ; cd .. ; \
		cd ./init.d && $(MAKE) install ; cd .. ; \
		cd ./logrotate && $(MAKE) install ; cd .. ; \
		cd ./postfix && $(MAKE) install ; cd .. ; \
		cd ./proftpd && $(MAKE) install ; cd .. ; \
	fi

uninstall:
	if test $(HOST_OS) = opensuse ; then \
		rm -rf $(SYSTEM_CONF)/easyscp.conf ;  \
		cd ./amavisd && $(MAKE) uninstall ; cd.. ; \
		cd ./apache && $(MAKE) uninstall ; cd .. ; \
		cd ./courier && $(MAKE) uninstall ; cd .. ; \
		cd ./cron.d && $(MAKE) uninstall ; cd .. ; \
		cd ./init.d && $(MAKE) uninstall ; cd .. ; \
		cd ./logrotate && $(MAKE) uninstall ; cd .. ; \
		cd ./postfix && $(MAKE) uninstall ; cd .. ; \
		cd ./proftpd && $(MAKE) uninstall ; cd .. ; \
	fi
