#!/bin/bash

read -p "enter a num" num
sum=$num

while (( $num != 1 ))
do 
	(( sum = sum * ((num - 1)) ))
	((num--))
done

echo $sum



