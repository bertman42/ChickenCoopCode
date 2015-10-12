#!/bin/bash

#Eganville
lat="45.5333N"
lon="77.1000W"

sunset_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )

#Wait for the sunset, then close the door 30 minutes after 
echo "`date`" " -- Waited for sunset starting at " $sunset_time >> /home/pi/chicken_coop/check_door.log

/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait down offset 0:30:00 $lat $lon

sudo python /home/pi/chicken_coop/relay_4port/close_in1.py
echo "`date`" " -- Fermez la porte (30 minutes after Sunset)" >> /home/pi/chicken_coop/check_door.log

mail -s "John and Alis Chicken Coop Door has been closed" bertman30@msn.com < /home/pi/chicken_coop/check_door.log

