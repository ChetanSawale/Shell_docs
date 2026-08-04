#!/bin/bash

package=htop

which $package

if [ $? -eq 0 ]
then
	echo "exists"
else
	echo "not"
fi

