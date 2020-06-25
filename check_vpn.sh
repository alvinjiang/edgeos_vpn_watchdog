#!/bin/vbash

alias run='/opt/vyatta/bin/vyatta-op-cmd-wrapper'

set -e

# define vpn interfaces
vtuns=( vtun1 vtun2 )

int=`run show interfaces openvpn | cut -d ' ' -f1 | tail +4 | tr $'\n' ' '`
IFS=' ' read -r -a active <<< $int

for i in "${vtuns[@]}"; do
    for j in "${active[@]}"; do
        if [ "$j" == "$i" ]; then
            echo "$i is running"
            continue 2
        fi
    done
    echo "$i is NOT running"
    /config/scripts/vpn_reset $i
done

