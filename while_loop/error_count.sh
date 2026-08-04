#!/bin/bash


while read line
do 
	if echo "$line" | grep -q "ERROR"
	then
		echo $line
	fi
done < log.txt




