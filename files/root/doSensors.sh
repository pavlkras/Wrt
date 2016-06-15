#!/bin/bash           

#build sensors json [{"VS":"FF12","id":"0401","value":"30"},{"VS":"FF12","id":"0602","value":"70"}]
echo "\"sensor_value\": [" > /root/temp/jsonSensor
ERROR=0

/root/tools/getSensors.sh
/root/tools/sendLog.sh
line=$(/root/tools/getMac.sh)
#cat /root/temp/commdata >> /root/retval
while read line2
do
    #echo $line2
    ID=0
    VAL=0
    if [ -n "$line2" ]; then
       ID=${line2:4:4}
       VAL=${line2:9}
       /root/tools/split.sh ',' $VAL > /root/temp/splited.2
       VAL=$(head -n 1 /root/temp/splited.2)
       RSSI=${line2:12:2}
       if [ "$RSSI" = "32" ];
       then
          ERROR=1
       fi
      echo \{\"valve_switch\":\"${line}\",\"id\":\"${ID}\",\"value\":\"${VAL}\"\}, >> /root/temp/jsonSensor
   fi
done < /root/temp/commdata
sleep 1
/root/tools/getDL.sh $line
echo "{}]" >> /root/temp/jsonSensor
cat /root/temp/jsonSensor
if [ "$RETVAL" = "ERROR" ];
then
  ERROR=1
fi
