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

	$(SYSTEM_MAKE_DIRS) $(ROOT_CONF)/init.d
	$(SYSTEM_MAKE_DIRS) $(ROOT_CONF)/default

	cp easyscp_daemon $(ROOT_CONF)/init.d
	cp easyscp_network $(ROOT_CONF)/init.d

	chown root:root $(ROOT_CONF)/init.d/easyscp_network $(ROOT_CONF)/init.d/easyscp_daemon
	chmod 0755 $(ROOT_CONF)/init.d/easyscp_network $(ROOT_CONF)/init.d/easyscp_daemon

	if [ -f easyscp_daemon.default ]; then \
		cp -p easyscp_daemon.default $(ROOT_CONF)/default/easyscp_daemon ; \
	fi

	if [ -f easyscp_network.default ]; then \
		cp -p easyscp_network.default $(ROOT_CONF)/default/easyscp_network ; \
	fi

uninstall:

	rm -f $(ROOT_CONF)/init.d/easyscp_daemon
	rm -f $(ROOT_CONF)/init.d/easyscp_network
	rm -f $(ROOT_CONF)/default/easyscp_daemon
	rm -f $(ROOT_CONF)/default/easyscp_network
