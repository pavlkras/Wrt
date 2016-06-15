#!/bin/bash
rm -f /root/temp/commdata
#START READ
/root/tools/readComm.sh &
#send command
/root/tools/writeComm.sh $1
sleep 2
FILESIZE=0
FILESIZEPREV=$(ls -l /root/temp/commdata | awk '{ print $5 }')
while [[ $FILESIZEPREV != $FILESIZE ]]
do
   FILESIZEPREV=$FILESIZE
   sleep 1
   FILESIZE=$(ls -l /root/temp/commdata | awk '{ print $5 }')
done
#STOP READ
killall dd readComm.sh cat      
