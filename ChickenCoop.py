#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import subprocess
import logging
import logging.handlers

import sys

#Setup GPIO pins
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
relay1 = [11]
relay2 = [7]
GPIO.setup(11, GPIO.OUT)
GPIO.setup(7, GPIO.OUT)

#Setup logging
LOG_FILENAME="/home/pi/chicken_coop/chicken_coop_door.log"
my_logger = logging.getLogger('MyLogger')
handler = logging.handlers.RotatingFileHandler(
		LOG_FILENAME, maxBytes=80, backupCount=5)
my_logger.addHandler(handler)

formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")

#Setup LAT and LON for Eganville
lat = "45.5333N"
lon = "77.1000W"
#sunrise_time = "Test "
sunwait_time = subprocess.Popen(['/home/pi/chicken_coop/sunwait08/sunwait/0.8/sunwait', 'list' ,lat ,lon], stdout=subprocess.PIPE).stdout.read()
sunrise_time = sunwait_time.split(",")[0].strip()
sunset_time = sunwait_time.split(",")[1].strip()
print "Sunrise time:", sunrise_time
print "Sunset time:", sunset_time
my_logger.debug("Sunset is set to", sunset_time)

current_time =  subprocess.Popen(['date'], stdout=subprocess.PIPE).stdout.read()
current_time = current_time.split(" ")[3].strip()
print "Current time:", current_time

if current_time < 12:
	print ("It is Morning")
	try:
		GPIO.output(relay1,GPIO.LOW)
		print "Relay 1 ON"
		GPIO.output(relay2,GPIO.HIGH)
		print "Relay 2 OFF"
	except:
		GPIO.cleanup()
else:
	print ("It is Afternoon and time to close")

	try:
                GPIO.output(relay1,GPIO.LOW)
                print "Relay 1 ON"
                GPIO.output(relay2,GPIO.LOW)
                print "Relay 2 ON"
        except:
                GPIO.cleanup()

