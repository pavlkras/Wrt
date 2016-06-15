#!/bin/sh
COM=$(cat /root/config/com)
stty -F ${COM} 115200 cs8 -cstopb -parenb -echo -onlcr
