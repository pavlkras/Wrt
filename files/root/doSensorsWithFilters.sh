#!/bin/bash           

#build sensors json [{"VS":"FF12","id":"0401","value":"30"},{"VS":"FF12","id":"0602","value":"70"}]
echo "\"sensor_value\": [" > /root/temp/jsonSensor
ERROR=0

while read line           
do           
    /root/tools/getSensors.sh $line
    while read line2
    do
       #echo $line2
       ID=0
       VAL=0
       if [ -n "$line2" ]; then
	  ID=${line2:4:4}
	  VAL=${line2:9:2}
	  RSSI=${line2:12:2}
	  if [ "$RSSI" = "32" ];
	  then
	     ERROR=1
	  fi

	  if [ -f /root/temp/${ID} ];
	  then
	     VS=$(cat /root/temp/${ID})
	     if [ "$VS" = "$line" ];
	     then
	        echo \{\"VS\":\"${line}\",\"id\":\"${ID}\",\"value\":\"${VAL}\"\}, >> /root/temp/jsonSensor
	     fi

	  else
	     echo $line > /root/temp/${ID}
	     echo \{\"VS\":\"${line}\",\"id\":\"${ID}\",\"value\":\"${VAL}\"\}, >> /root/temp/jsonSensor
	  fi
       fi
    done < /root/temp/commdata
done < /root/data/devices
echo "{}]" >> /root/temp/jsonSensor
#/root/tools/sendSensors.sh
#RETVAL=$(cat /root/temp/webRes)
if [ "$RETVAL" = "ERROR" ];
then
  ERROR=1
fi
if [ "$ERROR" -eq 0 ];
then
   while read line
   do
        /root/tools/getDL.sh $line
   done < /root/data/devices	
fi
#rm -f /root/temp/json
