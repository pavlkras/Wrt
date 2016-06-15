#!/bin/sh
 
echo 1 > /sys/class/gpio/gpio$1/value
#echo 1 > /sys/class/gpio/gpio2/value
