#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE=$(cat /root/config/routeBase)


curl --max-time 120 \
-H "Accept: application/json" \
-X POST --data '@/root/temp/commdata' "${ROUTEBASE}/server.php/system/log/data" > /root/temp/webRes
