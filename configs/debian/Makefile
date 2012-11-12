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
	if test $(HOST_OS) = debian  ; then \
		cp ./easyscp.conf $(SYSTEM_CONF) ; \
		(cd ./apache && $(MAKE) install &); \
		(cd ./courier && $(MAKE) install &); \
		(cd ./cron.d && $(MAKE) install &); \
		(cd ./init.d && $(MAKE) install &); \
		(cd ./logrotate && $(MAKE) install); \
		(cd ./postfix && $(MAKE) install &); \
		(cd ./proftpd && $(MAKE) install &); \
		(cd ./suhosin && $(MAKE) install &); \
	fi

uninstall:
	if test $(HOST_OS) = debian ; then \
		rm -rf $(SYSTEM_CONF)/easyscp.conf ;  \
		(cd ./apache && $(MAKE) uninstall &); \
		(cd ./courier && $(MAKE) uninstall &); \
		(cd ./cron.d && $(MAKE) uninstall &); \
		(cd ./init.d && $(MAKE) uninstall &); \
		(cd ./logrotate && $(MAKE) uninstall &); \
		(cd ./postfix && $(MAKE) uninstall &); \
		(cd ./proftpd && $(MAKE) uninstall &); \
		(cd ./suhosin && $(MAKE) uninstall &); \
	fi
