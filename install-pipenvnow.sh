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

#==================================
#            FUNCTIONS            #
#==================================

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

#===================================
#     CHECKING PREREQUISITES      #
#===================================

echo " "
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' nala | grep "install ok installed")
echo Checking for nala: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mnala not installed. Attempting to install nala now...\e[0m"
  sleep 0.15
  apt-get install nala
fi

echo " "
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' lolcat | grep "install ok installed")
echo Checking for lolcat: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mlolcat not installed. Attempting to install lolcat now...\e[0m"
  sleep 0.15
  nala install lolcat
  gem install lolcat
fi

echo " "
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' python3 | grep "install ok installed")
echo Checking for python3: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mpython3 not installed. Attempting to install python3 now...\e[0m"
  sleep 0.15
  nala install python3
fi

echo " "
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' python3-pip | grep "install ok installed")
echo Checking for python3-pip: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mpip3 not installed. Attempting to install pip3 now...\e[0m"
  sleep 0.15
  nala install -y python3-pip
  nala install build-essential libssl-dev libffi-dev python3-dev
  nala install -y python3-venv
fi

echo " "
echo "Installing pipENVnow script for global access..."
cp pipenvnow.sh /usr/bin/pipenvnow
chmod +x /usr/bin/pipenvnow
cp pip.script /usr/bin/pip.script
cp syshelp /usr/bin/syshelp
sleep 3
echo "Now simply type pipenvnow in terminal from the working directory to setup a venv."
sleep 2
echo "Installation complete!"
sleep 2
clear
