#!/bin/bash

STR=$2  #String with names
IFS=$1 read -ra NAMES <<< "$STR"    #Convert string to array

#Print all names from array
for i in "${NAMES[@]}"; do
    echo $i
done
