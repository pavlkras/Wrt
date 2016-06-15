#!/bin/bash
echo "{1} = device MAC"
/root/tools/sendCommand.sh "\$GV\r"
cat /root/temp/commdata
