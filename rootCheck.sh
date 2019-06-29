#!/bin/bash

if [ ! $EUID = 0 ];
then
	echo "You need root access to run this script!"
	exit 1
else 
	echo "Script started..."
fi

#Some bash code that needed root access
