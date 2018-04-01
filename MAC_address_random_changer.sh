#!/bin/bash

mac=0

echo "openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"
mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
echo ${mac}
mac=${mac%??}
echo ${mac}
echo $'SUCCESS...\n'


echo "sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z"
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
echo $'SUCCESS...\n'


echo "Generate new M.A.C address ..."
RANGE=255 #set integer ceiling
number=$RANDOM #generate random numbers
let "number %= $RANGE" #ensure they are less than ceiling

octeta=`echo "obase=16;$number" | bc`
#use a command line tool to change int to hex(bc is pretty standard)
#they're not really octets.  just sections.

macadd=$mac$octeta #concatenate values and add dashes
echo $macadd
echo $'SUCCESS...\n'


echo "Configuring new M.A.C address ..."
sudo ifconfig en0 ether "${macadd}"
echo $'SUCCESS...\n'


echo $'CONFIGURATION FINISHED... ENJOY!\n'

#networksetup -detectnewhardware 
