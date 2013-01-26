#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

export

install:

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)/cron.d

	cp ./easyscp $(SYSTEM_CONF)/cron.d

	cp -R ./backup $(SYSTEM_CONF)/cron.d
	cp -R ./parts $(SYSTEM_CONF)/cron.d
	cp -R ./working $(SYSTEM_CONF)/cron.d

uninstall:

	rm -rf $(SYSTEM_CONF)/cron.d
