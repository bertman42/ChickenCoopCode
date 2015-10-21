#!/bin/bash

log_file="/home/pi/chicken_coop/check_door.log"

#Eganville
lat="45.5333N"
lon="77.1000W"

sunset_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )

#Wait for the sunset, then close the door 30 minutes after 
echo  "`date '+%m/%d/%y @ %H:%M:%S'`" " - Sunset tonight was: " $sunset_time | cat - $log_file > temp && mv temp $log_file

/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait down offset -0:30:00 $lat $lon

echo $'\n'"`date '+%m/%d/%y @ %H:%M:%S'`" " * Relay One on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/chicken_coop/relay_4port/open_in1.py
echo $'\n'"`date '+%m/%d/%y @ %H:%M:%S'`" " * Relay Two on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/chicken_coop/relay_4port/open_in2.py

echo $'\n'"`date '+%m/%d/%y @ %H:%M:%S'`" " * Door closed " | cat - $log_file > temp && mv temp $log_file

mail -s "AJ Chicken Coop Door activity" bertman30@msn.com < $log_file

