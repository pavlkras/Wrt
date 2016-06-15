#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE=$(cat /root/config/routeBase)
echo "${ROUTEBASE}/server.php/api/v1/getConfigurationMini?from_date=2000-01-11%2007:39:44"

curl --max-time 120 \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-H "Authorization: Bearer ${OUTPUT}" \
-X GET "${ROUTEBASE}/server.php/api/v1/getConfigurationMini?from_date=2000-01-11%2007:39:44" > /root/temp/webRes
cat /root/temp/webRes
DEVICES="$(cat /root/temp/webRes | sed "s/{\"settings\":\"//" | sed "s/\"}//")"
/root/tools/split.sh , ${DEVICES} > /root/data/devices
rm -f /root/temp/webRes
