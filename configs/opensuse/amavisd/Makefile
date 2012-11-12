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
	$(SYSTEM_MAKE_DIRS) $(SYSTEM_CONF)/amavisd

	cp -R ./backup $(SYSTEM_CONF)/amavisd
	cp -R ./working $(SYSTEM_CONF)/amavisd
	cp ./amavisd.tpl $(SYSTEM_CONF)/amavisd
	cp ./amavisd.domains $(SYSTEM_CONF)/amavisd/amavisd.domains
	cp ./sender_scores_sitewide $(SYSTEM_CONF)/amavisd/sender_scores_sitewide
	cp ./spamassassin.tpl $(SYSTEM_CONF)/amavisd/spamassassin.tpl

uninstall:

	rm -rf $(SYSTEM_CONF)/amavisd
