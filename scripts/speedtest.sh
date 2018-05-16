#!/bin/bash 
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "SpeedTest" ; tput sgr0
echo ""
sleep 2
echo ""
tput setaf 7 ; tput setab 1 ; printf '  %-30s%s\n' "------------------------------------------------------------------" ; echo "" ; tput sgr0
cd /bin*
python speedtest.py --share
echo ""

tput setaf 7 ; tput setab 1 ; printf '  %-30s%s\n' "------------------------------------------------------------------" ; echo "" ; tput sgr0
