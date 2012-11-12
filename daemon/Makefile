#!/usr/bin/make -f

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

SYSTEM_DAEMON_ROOT=$(SYSTEM_ROOT)/daemon

CMD_INSTALL=/usr/bin/install -m 0700 -o root -g root
CMD_DIR_INSTALL=/usr/bin/install -d -o root -g root

export

install:

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_DAEMON_ROOT)
	$(CMD_DIR_INSTALL) -m 0700 $(SYSTEM_DAEMON_ROOT)

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_DAEMON_ROOT)/extlibs
	$(CMD_DIR_INSTALL) -m 0700 $(SYSTEM_DAEMON_ROOT)/extlibs

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon
	$(CMD_DIR_INSTALL) -m 0700 $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon

	$(SYSTEM_MAKE_DIRS) $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_DIR_INSTALL) -m 0700 $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS

	$(CMD_INSTALL) ./DaemonCore.php $(SYSTEM_DAEMON_ROOT)
	$(CMD_INSTALL) ./DaemonDomain.php $(SYSTEM_DAEMON_ROOT)
	$(CMD_INSTALL) ./DaemonMail.php $(SYSTEM_DAEMON_ROOT)
	$(CMD_INSTALL) ./easyscp_daemon $(SYSTEM_DAEMON_ROOT)
	$(CMD_INSTALL) ./Maps.php $(SYSTEM_DAEMON_ROOT)
	$(CMD_INSTALL) ./SocketHandler.php $(SYSTEM_DAEMON_ROOT)

	$(CMD_INSTALL) ./extlibs/Daemon.php $(SYSTEM_DAEMON_ROOT)/extlibs

	$(CMD_INSTALL) ./extlibs/Daemon/Exception.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon
	$(CMD_INSTALL) ./extlibs/Daemon/Options.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon
	$(CMD_INSTALL) ./extlibs/Daemon/OS.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon

	$(CMD_INSTALL) ./extlibs/Daemon/OS/Arch.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/BSD.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Debian.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Exception.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Fedora.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Linux.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/RedHat.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Ubuntu.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS
	$(CMD_INSTALL) ./extlibs/Daemon/OS/Windows.php $(SYSTEM_DAEMON_ROOT)/extlibs/Daemon/OS

uninstall:

	rm -rf $(SYSTEM_DAEMON_ROOT)
