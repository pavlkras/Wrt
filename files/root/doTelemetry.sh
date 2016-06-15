#!/bin/bash           

#build Telemetry json [{"VS":"FF12","bat_percentage": "89","solar_voltage": "0.1","valve_voltage": "20","temperature": "20","":""},{"VS":"FF31","bat_percentage": "89","solar_voltage": "0.1","valve_voltage": "20","temperature": "20","":""},{}]
echo "\"telemetry\": [" > /root/temp/jsonTelemetry

/root/tools/getTelemetry.sh
DATA=$(cat /root/temp/commdata)
line=$(/root/tools/getMac.sh)
/root/tools/sendLog.sh
/root/tools/split.sh ';' $DATA > /root/temp/splited
    
BATPRES=0
SOLPOW=0
VALPOW=0
TEMPER=0

COUNTER=0
while read line2
do
   if [ $COUNTER -eq 1 ]
   then
      BATPRES=$line2 
   fi
       
   if [ $COUNTER -eq 2 ]
   then
       SOLPOW=$line2
   fi
       
   if [ $COUNTER -eq 3 ]
   then
      VALPOW=$line2
   fi
       
   if [ $COUNTER -eq 4 ]
   then
      TEMPER=$line2
   fi
   COUNTER=$((COUNTER + 1))
done < /root/temp/splited
    
echo \{\"valve_switch\":\"${line}\",\"bat_percentage\":\"100\",\"solar_voltage\":\"${SOLPOW}\",\"valve_voltage\":\"${VALPOW}\",\"temperature\":\"${TEMPER}\"\}, >> /root/temp/jsonTelemetry
echo "{}]" >> /root/temp/jsonTelemetry
cat /root/temp/jsonTelemetry
#rm -f /root/temp/json
