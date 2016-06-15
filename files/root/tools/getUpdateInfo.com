#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE="http://192.168.0.106/TevatronicWithAlgoritm"
#ROUTEBASE=$(cat /root/config/routeBase)

curl --max-time 120 \
-H "Authorization: Bearer ${OUTPUT}" \
-X GET "${ROUTEBASE}/server.php/api/v1/update/info?type=1" > /root/temp/webRes
cat /root/temp/webRes
