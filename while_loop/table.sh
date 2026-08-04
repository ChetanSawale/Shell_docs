#!/bin/bash

read -p "enter num" num

num1=1

while [ $num1 -le 10 ]
do 
	echo "$num x $num1 = $((num * num1))"
	((num1++))
done 


