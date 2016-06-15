#!/bin/bash
echo START_WD >> log
PS=$(/root/tools/getDI.sh)
echo $PS >> log

if [ "$PS" != "\$DI;RF" ]; then
   echo "NONE" 
else
   echo "NO ERROR COMM" >> /root/log
   /root/tools/loginWeb.sh
   SIZE=$(du /root/data/token | cut -c 1)
   echo "size is $SIZE" >> /root/log
fi


