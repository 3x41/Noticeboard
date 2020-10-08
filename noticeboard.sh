#!/bin/bash
# You need to have installed Debian 10 and setup SSH and NO GUI.
# Make sure you login as Root, this is still a work in progress

# upgrade packages to the latest versions
	apt-get update -y
	apt-get upgrade -y
	#sleep 5

# Add a user, this will be used for autologin and config
	useradd -m kiosk
	# passwd kiosk

# Install the required packages
	apt-get install sudo xorg chromium chromium-sandbox openbox lightdm unclutter --no-install-recommends -y

# Add autologin at the end of the config file
	sed -i "s/#autologin-user=/autologin-user=kiosk/g" /etc/lightdm/lightdm.conf

	#sed -i "$ a autologin-user=kiosk" /etc/lightdm/lightdm.conf
	#sed -i "$ a user-session=openbox" /etc/lightdm/lightdm.conf
	#nano /etc/lightdm/lightdm.conf
	#[SeatDefaults]
	#autologin-user=kiosk
	#user-session=openbox

# Login as the new user
	#su kiosk
	#bash
	mkdir /home/kiosk/.config
	mkdir /home/kiosk/.config/openbox

# Create the config file for openbox for the user
# mkdir -p $HOME/.config/openbox
	touch /home/kiosk/.config/openbox/autostart

# touch $HOME/.config/openbox/autostart
	echo "xset s off" >> /home/kiosk/.config/openbox/autostart
	echo "xset -dpms" >> /home/kiosk/.config/openbox/autostart
	echo "xset s noblank" >> /home/kiosk/.config/openbox/autostart

# You may need to force the screen resolution
# echo "xrandr -s 800x600" >> $HOME/.config/openbox/autostart

# This is to auto hide the mouse pointer
	echo "unclutter &" >> /home/kiosk/.config/openbox/autostart
	echo " " >> /home/kiosk/.config/openbox/autostart
	echo "chromium \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --no-first-run \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --disable \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --disable-translate \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --disable-infobars \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --disable-suggestions-service \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --disable-save-password-bubble \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --start-maximized \\" >> /home/kiosk/.config/openbox/autostart
	echo "   --kiosk "http://www.google.com" &" >> /home/kiosk/.config/openbox/autostart

# END OF SCRIPT

	echo "Please Reboot Machine"
