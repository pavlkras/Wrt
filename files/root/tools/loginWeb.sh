#!/bin/sh
OUTPUT="$(/root/tools/getMac.sh)"
echo {\"device_mac\":\"${OUTPUT}\"} > /root/temp/json
ROUTEBASE=$(cat /root/config/routeBase)
rm -f /root/data/token 
touch /root/data/token

curl \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data '@/root/temp/json' "${ROUTEBASE}/server.php/auth/Login" > /root/temp/webRes
cat /root/temp/webRes | sed "s/{\"token\":\"//" | sed "s/\"}//" > /root/data/token
cat /root/data/token
#rm -f /root/temp/webRes
#rm -f /root/temp/json
