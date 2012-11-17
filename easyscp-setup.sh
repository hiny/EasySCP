#!/bin/sh

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

Auswahl=""
OS=""

clear

echo "1 = CentOS"
echo "2 = Debian"
echo "3 = OpenSuse"
echo "4 = Ubuntu"

while :
do
    read -p "Please select your distribution: " Name

    if [ "$Name" = "1" ] || [ "$Name" = "CentOS" ]; then
        Auswahl="CentOS"
    fi

    if [ "$Name" = "2" ] || [ "$Name" = "Debian" ]; then
        Auswahl="Debian"
    fi

    if [ "$Name" = "3" ] || [ "$Name" = "OpenSuse" ]; then
        Auswahl="OpenSuse"
    fi

    if [ "$Name" = "4" ] || [ "$Name" = "Ubuntu" ]; then
        Auswahl="Ubuntu"
    fi

	case "$Auswahl" in
		CentOS)
			echo "Easy Setup currently does not support CentOS."
			break
			;;
		Debian)
			echo "Using Debian. Please wait."

			echo "Build the Software"
			make install > /dev/null

			echo "Copy required files to your system"
			cp -R /tmp/easyscp/* / > /dev/null

			echo "Secure your mysql installation"
			mysql_secure_installation

			echo "Clean the temporary folders"
			rm -fR /tmp/easyscp/

			echo -n "Debian" > /etc/easyscp/OS
			/etc/init.d/apache2 restart

			while :
			do
				read -p "Start setup [Y/N]?" Setup
				case "$Setup" in
					[JjYy])
						#echo "ja"
						cd /var/www/easyscp/engine/setup
						perl easyscp-setup
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"
						;;
				esac
			done
			break
			;;
		OpenSuse)
			echo "Easy Setup currently does not support OpenSuse."
			break
			;;
		Ubuntu)
			echo "Using Ubuntu. Please wait."
			break
			;;
		*)
			echo "Please type a number or the name of your distribution!"
			#Wenn vorher nichts passte
			;;
	esac
done

#exit 0
#make install

#cp -R /tmp/easyscp/* /

exit 0