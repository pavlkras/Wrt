#!/bin/sh
 
echo 0 > /sys/class/gpio/gpio$1/value
#echo 0 > /sys/class/gpio/gpio2/value
