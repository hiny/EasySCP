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

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)/proftpd
	$(SYSTEM_MAKE_DIRS) $(ROOT_CONF)/proftpd

	cp -R ./backup $(SYSTEM_CONF)/proftpd
	cp -R ./parts $(SYSTEM_CONF)/proftpd
	cp -R ./working $(SYSTEM_CONF)/proftpd

	if [ ! -d $(ROOT_CONF)/proftpd ]; then \
		$(SYSTEM_MAKE_DIRS) $(ROOT_CONF)/proftpd ; \
	fi

	$(SYSTEM_MAKE_DIRS) $(ROOT_CONF)/proftpd/easyscp
	cp ./root_domain.conf $(ROOT_CONF)/proftpd/easyscp
	cp ./proftpd.conf $(SYSTEM_CONF)/proftpd

uninstall:

	rm -rf $(SYSTEM_CONF)/proftpd
