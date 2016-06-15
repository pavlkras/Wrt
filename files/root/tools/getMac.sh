#!/bin/sh
/sbin/ifconfig | grep HWaddr | grep wlan0 | grep Ethernet | cut -d ' ' -f10

