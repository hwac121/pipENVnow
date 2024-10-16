#!/bin/bash

# Title: pipENVnow v1.0
# Date: Oct. 15, 2024
# Author: RJ Levesque, Jr.
# Descriptions
# Utility to setup a venv for installing requirements.txt


#  Copyright 2024 RJ Levesque, Jr.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#  All I ask is if you use this or any part of this script to give me
#  credit in the comments as the original author.
#

#=======================================================================
#                         FUNCTIONS
#=======================================================================

Splash(){
	figlet "pipENVnow" | lolcat
	echo " "
	echo -e "\e[32mVersion 1.0 for Kali Linux\e[0m"
	echo -e "\e[32mby Majik Cat Security\e[0m"
	echo -e "\e[33mBe sure to visit my youtube channel Majik Cat Security\e[0m"
	echo " "
}

#==================================
#         CHECK IF ROOT           #
#==================================

if [ "$EUID" -ne 0 ]
  then 
	clear
	Splash
	echo " "
	echo -e "\e[35mMust be run as root or sudo\e[0m"
	sleep 0.5
  exit
fi

#=================================================================================================
#========                                 MENU SYSTEM                                    ========#
#=================================================================================================

options=("Create pip3 venv" "Activate new venv" "Install requirements" "Deactivate new venv" "Help" "Quit")
PS3='Start with option 1:  '

while [ "$menu" != 1 ]; do
clear
Splash
select opt in "${options[@]}" ; do
		case $opt in
		
#########################################
#              MENU ITEMS               #
#########################################

		"Create pip3 venv")
			clear
			Splash
			echo " "
			echo "What should I call the new venv workspace?"
			read MakeVenv
			echo "Creating workspace for venv called $MakeVenv..."
			sleep 3
			python3 -m venv $MakeVenv
			echo "Creating pip venv launcher script in working directory..."
			echo $MakeVenv > pip.dat
			cp /usr/bin/pip.script pip-activate.sh
			chmod +x pip-activate.sh
			sleep 3
			echo "Use pip-activate.sh to reactivate your venv for this program each time" 
			echo "before runnig the program to make all requirements available."
			sleep 3
		break
		;;
		"Activate new venv")
			clear
			Splash
			echo " "
			echo "Activating new venv $MakeVenv workspace..."
			sleep 3
			source $MakeVenv/bin/activate
			sleep 3
		break
		;;
		"Install requirements")
			clear
			Splash
			echo " "
			echo "Installing requirements..."
			sleep 3
			pip3 install -r requirements.txt
			sleep 3
		break
		;;
		"Deactivate new venv")
			clear
			Splash
			echo " "
			echo "Deactivating $MakeVenv workspace..."
			sleep 3
			deactivate
			sleep 3
		break
		;;
		"Help")
			clear
			Splash
			echo " "
			echo "Close help window to return to the menu."
			xterm -hold -T "Help File" -e cat /usr/bin/syshelp
			sleep 3
		break
		;;
#=================================================================================================
#========                               QUIT FUNCTION                                    ========#
#=================================================================================================
		"Quit")
			clear
			Splash
			echo -e " "
			echo -e "\e[37mThank you for using pipENVnow 1.0 by Majik Cat Security - Oct. 15, 2024\e[0m"
			sleep 3
			clear
			menu=1
		break
		;;
#=================================================================================================
#========                        ERROR CAPTURE - INVALID OPTION                          ========#
#=================================================================================================
		*) 
			clear
			Splash
			echo " "
			echo -e "invalid option $REPLY"
		break
		;;
		esac
	done
done
