#! /bin/bash

# Author: David Sopkin (sopkin.sf@gmail.com)
# This script is used to install Numix, an icon pack. 
# Their website can be found at:  https://numixproject.org/

#numix theme and icons
sudo add-apt-repository ppa:numix/ppa
sudo apt-get update -y
sudo apt-get install numix-gtk-theme -y
sudo apt-get install numix-icon-theme-circle -y

echo done!
