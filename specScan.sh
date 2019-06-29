#!/bin/bash


# checking if user has root access
if [ ! $EUID = 0 ]; then
	echo "You need root access to run this script!"
	exit 1
fi


domain=$1
shift #shifting so that getopts could get other parameters

while getopts :or:s opt; do
	case $opt in
		o)osScan=1;;
		r)file=$OPTARG;;
		s)sublst=1;;
		*)echo "Script usage: ./skripta.sh example.com [-o] [-r report.txt] [-s]"
		  exit -1;;
	esac
done

echo $domain

#creating file if not exists
if [ ! -f $file ]; then
	touch $file
fi

#getting ip address for given domain
ipaddr=$(host $domain | grep address | cut -d" " -f4)

#just for debugging
#echo "I got IP addr which is $ipaddr"

# Printing all data in the report
{
echo "==== Report for $domain ===="
echo "- Date: $(date)"
echo "- Author: $(whoami)"
echo "====================="
echo "Services that are running on open ports: "

# nmap command that finds open ports and services that are running on them
nmap -sV $ipaddr | tee services.log | grep open

# extracting only services from nmap command output
opnPortServ=$(cat services.log | grep open | tr -s " " " " | cut -d" " -f4,5)

echo "======================"

# just practice example, search through services
# if it finds nginx, then alerts the user
cnt=1
for i in $opnPortServ; do
	if [ $i = nginx ]; then
		echo "$cnt - Server is maybe vulnerable to Ngnix privilege escalation!"
		let cnt++
	fi
done

echo "======================"

# checking what os is running on the server
if [ ! -z $osScan ]; then
	echo "OS scan is started:"
	nmap -p 22,80,445,65123,56123 -O $ipaddr | grep Running
	echo "======================"
fi

# running script that finds subdomains of given domain
if [ ! -z $sublst ]; then
	echo "Sublister is started:"
	./../Sublist3r/sublist3r.py -d $domain | grep $domain
	echo "======================"
fi

} | tee $file #everything should be written in given file and on standard output

# remove file if the user didnt need it
if [ -z $file ]; then
	rm $file
fi

# remove log file
rm services.log
