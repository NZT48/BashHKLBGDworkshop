#!/bin/bash

for i in $(cat domains.txt)
do
 	ping -c2 $i 
	echo "==============="
	echo
done
