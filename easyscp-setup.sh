#!/bin/sh

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

Auswahl=""
OS=""

clear

echo ""
echo "1 = CentOS"
echo "\033[36m"
echo "2 = Debian"
echo "\033[32m"
echo "3 = OpenSuse"
echo "\033[33m"
echo "4 = Ubuntu"
echo "\033[49;0m"

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
			#echo "Using CentOS. Please wait."
			echo "Easy Setup currently does not support CentOS."
			break
			;;
		Debian)
			echo "Using Debian. Please wait."

			echo "Build the Software"
			make install > /dev/null

			echo "Copy required files to your system"
			cp -R /tmp/easyscp/* / > /dev/null

			while :
			do
				read -p "Secure your mysql installation [Y/N]?" MySQL
				case "$MySQL" in
					[JjYy])
						#echo "ja"
						mysql_secure_installation
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

			echo "Clean the temporary folders"
			rm -fR /tmp/easyscp/

			if [ ! -f /etc/easyscp/easyscp.conf ]; then
				cp /etc/easyscp/easyscp.conf.tpl /etc/easyscp/easyscp.conf
			fi

			echo -n "Debian" > /etc/easyscp/OS

			touch /var/log/rkhunter.log
			chmod 644 /var/log/rkhunter.log

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
			# echo "Using OpenSuse. Please wait."
			echo "Easy Setup currently does not support OpenSuse."
			break
			;;
		Ubuntu)
			echo "Using Ubuntu. Please wait."

			echo "Build the Software"
			sudo make -f Makefile.ubuntu install > /dev/null

			echo "Copy required files to your system"
			cp -R /tmp/easyscp/* / > /dev/null

			while :
			do
				read -p "Secure your mysql installation [Y/N]?" MySQL
				case "$MySQL" in
					[JjYy])
						#echo "ja"
						mysql_secure_installation
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

			echo "Clean the temporary folders"
			rm -fR /tmp/easyscp/

			if [ ! -f /etc/easyscp/easyscp.conf ]; then
				cp /etc/easyscp/easyscp.conf.tpl /etc/easyscp/easyscp.conf
			fi

			echo -n "Ubuntu" > /etc/easyscp/OS

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
		*)
			echo "Please type a number or the name of your distribution!"
			#Wenn vorher nichts passte
			;;
	esac
done

exit 0