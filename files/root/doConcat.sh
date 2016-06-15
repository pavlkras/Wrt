#!/bin/bash
echo "{" > /root/temp/json
TEL=$(cat /root/temp/jsonTelemetry)
COUNTER=$(cat /root/temp/jsonCounter)
SENSORS=$(cat /root/temp/jsonSensor)
echo "$TEL," >> /root/temp/json
echo "$COUNTER," >> /root/temp/json
echo "$SENSORS" >> /root/temp/json
echo "}" >> /root/temp/json
/root/tools/sendTelemetry.sh
#rm -f /root/temp/json
