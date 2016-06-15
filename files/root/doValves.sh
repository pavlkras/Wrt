#!/bin/bash           

#parse json {"message":"FF12,VO1,0|FF12,VO3,60|FF12,VO2,120|FF12,VC2,120|FF12,VO4,60|FF12,VO2,120|"}
echo "[" > /root/temp/json
ERROR=0

/root/tools/getAlgorithm.sh
DATA=$(cat /root/temp/webRes)
/root/tools/split.sh '|' $DATA > /root/temp/splited

if [ "$DATA" = "Keep working" ];
then
   exit
fi


while read line           
do           
    echo $line
    VS=${line:0:4}
    OP=${line:5:2}
    ID=${line:7:1}
    TIME=${line:9}

    echo $line

    if [ "$OP" = "VO" ];
    then
       sleep $TIME
       /root/tools/sendValveCommand.sh $VS $OP $ID
    else
       /root/tools/sendValveCommand.sh $VS $OP $ID
       sleep $TIME
    fi
done < /root/temp/splited
