#!/bin/bash

num=1
sum=0

while [  $num -le 101  ]
do 
	((sum += num))
	((num++))
done

echo $sum



