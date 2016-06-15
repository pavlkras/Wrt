#!/bin/bash
#
# Restore Access Point if Master network is inaccessible
# 

TIMEOUT=30
SLEEP=3

sta_err=0
nw_found=1
nw_conf_restored=0

output=$(iw dev wlan0 link)
exit_code=$?

while [ $(echo "$output" | grep -c "Connected to") -lt 1 ]; do
	let sta_err=$sta_err+1

	if [ $nw_conf_restored == 0 ] &&
	   [ $(find /root/wifi/confClient/* -maxdepth 0 -name "*.nw.ok" | wc -l) == 4 ]
	then
		cd /root/wifi/confClient
		for file in *.nw.ok
		do
			cp "$file" "/etc/config/${file/.nw.ok/}"
		done
		wifi reload
	fi

	nw_conf_restored=1

	if [ $exit_code != 0 -o $((sta_err * SLEEP)) -ge $TIMEOUT ];
	then
		cd /root/wifi/confAP
		for file in *.AP
		do
			cp "$file" "/etc/config/${file/.AP/}"
		done
		wifi reload
		nw_found=0
		break
	fi

	output=$(iw dev wlan0 link)
	exit_code=$?

	sleep $SLEEP
done

if [ $nw_found == 1 ];
then
	cp /etc/config/wireless /root/wifi/confClient/wireless.nw.ok
	cp /etc/config/network /root/wifi/confClient/network.nw.ok
	cp /etc/config/dhcp /root/wifi/confClient/dhcp.nw.ok
	cp /etc/config/firewall /root/wifi/confClient/firewall.nw.ok
fi
