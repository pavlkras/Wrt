#!/bin/bash          
line="* * * * * /root/startexec.sh & > /dev/null"
(crontab -u root -l; echo "$line" ) | crontab -u root -

