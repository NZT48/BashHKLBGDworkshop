#!/bin/bash
{
echo "Script started..."
echo "Results of script infoGather:" >> .infoLinux

echo "=========Whoami=========" >> .infoLinux
whoami >> .infoLinux

echo "=========Hosts file=========" >> .infoLinux
cat /etc/hosts >> .infoLinux

echo "=========Shadow file"========= >> .infoLinux
cat /etc/shadow >> .infoLinux

echo "=========Passwd file============" >> .infoLinux
cat /etc/passwd >> .infoLinux
} > /dev/null
