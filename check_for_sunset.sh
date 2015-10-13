#!/bin/bash

log_file = "/home/pi/chicken_coop/check_door.log"

#Eganville
lat="45.5333N"
lon="77.1000W"

sunset_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )

#Wait for the sunset, then close the door 30 minutes after 
echo "`date`" " -- Begun waiting for sunset " $sunset_time | cat - $log_file > temp && mv temp $log_file

/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait down offset -1:00:00 $lat $lon

sudo python /home/pi/chicken_coop/relay_4port/close_in1.py
echo "`date`" " -- Fermez la porte (+1 hour after Sunset)" | cat - $log_file > temp && mv temp $log_file

mail -s "John and Alis Chicken Coop Door has been closed" bertman30@msn.com < $log_file

