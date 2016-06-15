#!/bin/bash           

#build counters json [{"VS":"FF12","id":"c1","pulse":"30"},{"VS":"FF12","id":"c2","pulse":"70"}]
echo "\"counters\": [" > /root/temp/jsonCounter

/root/tools/getMeters.sh
DATA=$(cat /root/temp/commdata)
/root/tools/sendLog.sh
line=$(/root/tools/getMac.sh)
/root/tools/split.sh ';' ${DATA:4} > /root/temp/splited
cat /root/temp/splited
COUNTER=1
while read line2
do
   if [ $COUNTER -gt 0 ]
   then
       echo \{\"valve_switch\":\"${line}\",\"id\":\"c${COUNTER}\",\"pulse\":\"${line2}\"\}, >> /root/temp/jsonCounter
   fi
   COUNTER=$((COUNTER + 1))  
done < /root/temp/splited
echo "{}]" >> /root/temp/jsonCounter
cat /root/temp/jsonCounter
#/root/tools/sendCounters.sh
#rm -f /root/temp/json          
