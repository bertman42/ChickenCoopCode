#!/usr/bin/python
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

GPIO.setup(23, GPIO.OUT)

#try:
#  if GPIO.output(5) == True:
#	GPIO.output(5, GPIO.HIGH)
#  else:
#	GPIO.output(5, GPIO.LOW)
#  print "ON"



# End program cleanly with keyboard
#except KeyboardInterrupt:
#  print "  Quit"

  # Reset GPIO settings
GPIO.cleanup()

