#!/bin/sh
COM=$(cat /root/config/com)
#./writeComm.sh "\$VS;FF12;VC2\r\n"
echo -ne $1 > ${COM}
