#!/bin/bash

# Get a list of all network interfaces
interfaces=$(ls /sys/class/net | grep -v lo)

echo "Interface Status Speed"
echo "----------------------"

# Loop through each interface and determine speed
for iface in $interfaces; do
    # Check if ethtool supports the interface
    if ethtool $iface &>/dev/null; then
        speed=$(ethtool $iface | grep "Speed:" | awk '{print $2}')
        status=$(cat /sys/class/net/$iface/operstate)
        
        if [[ -z "$speed" ]]; then
            speed="Unknown"
        fi
        
        printf "%-10s %-10s %-10s\n" "$iface" "$status" "$speed"
    else
        echo "$iface Unknown No ethtool support"
    fi
done
