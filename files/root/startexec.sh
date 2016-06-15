#!/bin/bash           
echo START > log
PS=$(ps | grep "execute.sh" | grep -v "grep")
echo $PS >> log
if [ -n "$PS" ]; then
   echo no >> log
else
   echo yes >> log
   /root/execute.sh
   #/root/wd.sh
fi
