#!/bin/bash
#
# Starts attempt to restore last successful connection
# if there is no active web connections
#

if [ $(iw dev wlan0 station dump | wc -l) == 0 ];
then
	/root/wifi/fix_sta_ap.sh
elif [ $(iw dev wlan0 link | grep -c "Connected to") -ge 1 ]
then
	cp /etc/config/wireless /root/wifi/confClient/wireless.nw.ok
	cp /etc/config/network /root/wifi/confClient/network.nw.ok
	cp /etc/config/dhcp /root/wifi/confClient/dhcp.nw.ok
	cp /etc/config/firewall /root/wifi/confClient/firewall.nw.ok
fi
