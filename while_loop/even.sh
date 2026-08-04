#!/bin/bash

num=0

while [ $num -le 50 ]
do 

	if [ $((num % 2)) -eq 0 ]
	then
		echo $num
	fi
	((num++))
done





