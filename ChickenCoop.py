#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import subprocess


#Eganville
lat = "45.5333N"
lon = "77.1000W"
sunrise_time = subprocess.call(['/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait'])
#sunrise_time = subprocess.call(['/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait', 'list', _lat, _lon, '|', 'awk', ''BEGIN', '{FS=",";}',  '{', ' print', '$1;', '}'', ')'])
#sunset_time=$(/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )
#current_time=(date | awk '{ print $4; }' | awk 'BEGIN {FS=":";} { print $1; }')

GPIO.setmode(GPIO.BCM)

# init list with pin numbers

pinList = [11]

# loop through pins and set mode and state to 'high'

for i in pinList: 
    GPIO.setup(i, GPIO.OUT) 
#    GPIO.output(i, GPIO.HIGH)


# main loop

try:
  GPIO.output(11, GPIO.LOW)
  print "ON"



# End program cleanly with keyboard
except KeyboardInterrupt:
  print "  Quit"

  # Reset GPIO settings
  GPIO.cleanup()

