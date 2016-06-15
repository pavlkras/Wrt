#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE=$(cat /root/config/routeBase)


curl --max-time 120 \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-H "Authorization: Bearer ${OUTPUT}" \
-X POST --data '@/root/temp/json' "${ROUTEBASE}/server.php/api/v1/update/telemetry" > /root/temp/webRes
