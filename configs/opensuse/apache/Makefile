#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

ROOT_APACHE_CONF=$(ROOT_CONF)/apache2

export

install:

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)/apache
	$(SYSTEM_MAKE_DIRS) $(ROOT_APACHE_CONF)
	$(SYSTEM_MAKE_DIRS) $(ROOT_APACHE_CONF)/conf.d
	$(SYSTEM_MAKE_DIRS) $(ROOT_APACHE_CONF)/easyscp

	cp ./00_master.conf $(SYSTEM_CONF)/apache
	cp ./01_awstats.conf $(SYSTEM_CONF)/apache

	cp ./fcgid.conf $(SYSTEM_CONF)/apache/fcgid_easyscp.conf

uninstall:

	rm -rf $(SYSTEM_CONF)/apache
