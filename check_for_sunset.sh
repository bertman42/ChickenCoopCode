#!/bin/bash

#Eganville
lat="45.5333N"
lon="77.1000W"

#Wait for the sunrise, then open the door 30 minutes after sunrise
/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait down offset 0:30:00 $lat $lon

sudo python /home/pi/chicken_coop/relay_4port/close_in1.py
echo $'\n'"`date`" " -- Closed the door (should be 30 minutes after Sunset" >> /home/pi/chicken_coop/check_door.log

mail -s "Door has been closed" bertman30@msn.com < /home/pi/chicken_coop/check_door.log

