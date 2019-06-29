#!/bin/bash

oldIFS=$IFS
IFS=' '

ls $1 | while read script
do
		./$1/$script
done

IFS=$oldIFS

