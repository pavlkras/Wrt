#!/bin/sh
OUTPUT="$(cat /root/data/token)"
ROUTEBASE=$(cat /root/config/routeBase)

curl --max-time 120 \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-H "Authorization: Bearer ${OUTPUT}" \
-X GET "${ROUTEBASE}/server.php/api/v1/sensors/status" > /root/temp/webRes
cat /root/temp/webRes
RESULT=$(cat /root/temp/webRes)
if [[ "$RESULT" == "\"true\"" ]]
then
   reboot
fi
rm -f /root/temp/webRes
