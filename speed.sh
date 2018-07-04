#!/bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# This is a utility for the blink(1) and speedtest-cli app. 
# It shows colors based on internet speeds. 

speed='speedtest-cli | grep Download | cut -c 11-15'; if [ $speed -lt "10" ]; then blink1 --orange blink 10 && echo "hella slow" && echo $speed; else blink1 --green blink n10 && echo "hella fast" && echo $speed; fi; blink1 --off
