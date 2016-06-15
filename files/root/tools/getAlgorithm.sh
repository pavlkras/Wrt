#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE=$(cat /root/config/routeBase)

curl --max-time 120  \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-H "Authorization: Bearer ${OUTPUT}" \
-X GET "${ROUTEBASE}/server.php/api/v1/algorithm/system" > /root/temp/ttm
cat /root/temp/ttm | sed "s/{\"message\":\"//" | sed "s/\"}//" > /root/temp/webRes
