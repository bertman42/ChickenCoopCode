#!/bin/bash

log_file="/home/pi/chicken_coop/check_door.log"

#Eganville
lat="45.5333N"
lon="77.1000W"
sunrise_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $1; }' )
sunset_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )
current_time=(date | awk '{ print $4; }' | awk 'BEGIN {FS=":";} { print $1; }')
if [current_time < 12]
  then


#if it is sunrise then do this
#Wait for the sunrise, then open the door 30 minutes after sunrise
echo $'\n'"`date`" " -- Waited for sunrise starting at " $sunrise_time | cat - $log_file > temp && mv temp $log_file
/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait rise offset 0:30:00 $lat $lon
sudo python /home/pi/chicken_coop/relay_4port/open_in1.py
echo "`date`" " -- Opened the door (30 mins after Sunrise)" | cat - $log_file > temp && mv temp $log_file
mail -s "Ali and Johns Chicken Coop Door has been opened" bertman30@msn.com < $log_file

#if it is sunset then do this
#Wait for the sunset, then close the door 30 minutes after
echo "`date`" " -- Begun waiting for sunset " $sunset_time | cat - $log_file > t
emp && mv temp $log_file
/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait wait down offset -1:00:00 $lat $lon
sudo python /home/pi/chicken_coop/relay_4port/close_in1.py
echo "`date`" " -- Fermez la porte (+1 hour after Sunset)" | cat - $log_file > temp && mv temp $log_file
mail -s "John and Alis Chicken Coop Door has been closed" bertman30@msn.com < $log_file

