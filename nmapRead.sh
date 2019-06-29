#!/bin/bash

echo "Enter the starting IP address: "
read FirstIP

echo "Enter the last IP address: "
read LastIP

echo "Enter the port number you want to scan for: "
read port

echo "Enter the output file: "
read file

nmap -sT $FirstIP- $LastIP -p $port -oG $file
