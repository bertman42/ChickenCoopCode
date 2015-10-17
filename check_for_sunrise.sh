#!/bin/bash

log_file="/home/pi/chicken_coop/check_door.log"

#Eganville
lat="45.5333N"
lon="77.1000W"
sunrise_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $1; }' )

#Wait for the sunrise, then open the door 30 minutes after sunrise
echo $'\n'"`date`" " -- Waited for sunrise starting at " $sunrise_time | cat - $log_file > temp && mv temp $log_file

/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait rise offset 0:30:00 $lat $lon

sudo python /home/pi/chicken_coop/relay_4port/open_in1.py
echo "`date`" " -- Opened the door (30 mins after Sunrise)" | cat - $log_file > temp && mv temp $log_file

mail -s "Ali and Johns Chicken Coop Door has been opened" bertman30@msn.com < $log_file

