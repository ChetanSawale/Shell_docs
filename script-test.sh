

name=$(whoami)

if [ -f /etc/passwd ];
then	echo "exist"
else
	echo "Unknown"
fi


