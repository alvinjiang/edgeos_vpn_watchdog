#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

# make sure script is run as group vyattacfg
if [ 'vyattacfg' != $(id -ng) ]; then
  exec sg vyattacfg -c "$0 $@"
fi
  
logger -t vpn_reset start
  
# shorthand for cmd wrapper
cw=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
  
# enter configure mode
$cw begin
  
# put disable and commit (to stop)
echo "Disabling $1"
$cw set interfaces openvpn $1 disable
$cw commit
          
# remove disable and commit (to start)
echo "Enabling $1"
$cw delete interfaces openvpn $1 disable
$cw commit
          
# end configure mode
$cw end
          
logger -t vpn_reset end
          
