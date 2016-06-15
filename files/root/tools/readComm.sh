#!/bin/sh
COM=$(cat /root/config/com)
dd if=${COM} >> /root/temp/commdata
