#!/bin/bash       
line2="FF12,VO1,120012900091"
echo $line2
ID=${line2:0:4}
VAL=${line2:5:2}
GG=${line2:7:1}
RSSI=${line2:9}
echo $ID 
echo $VAL 
echo $GG
echo $RSSI 
