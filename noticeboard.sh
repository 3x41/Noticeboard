#!/bin/bash
# You need to have installed Debian 10 and setup SSH and NO GUI.
# Make sure you login as Root, this is still a work in progress

# upgrade packages to the latest versions
	apt-get update -y
	apt-get upgrade -y
	sleep 5

# Add a user, this will be used for autologin and config
	useradd -m kiosk
	# passwd kiosk

# Install the required packages
	apt-get install sudo xorg chromium openbox lightdm unclutter --no-install-recommends

# Add autologin at the end of the config file
	sed -i "s/# autologin-user =/autologin-user = kiosk #/g" /etc/lightdm/lightdm.conf

	#sed -i "$ a autologin-user=kiosk" /etc/lightdm/lightdm.conf
	#sed -i "$ a user-session=openbox" /etc/lightdm/lightdm.conf
	#nano /etc/lightdm/lightdm.conf
	#[SeatDefaults]
	#autologin-user=kiosk
	#user-session=openbox

# Login as the new user
	su kiosk
	bash
	cd ~
	mkdir .config
	mkdir .config/openbox

# Create the config file for openbox for the user
# mkdir -p $HOME/.config/openbox
	touch .config/openbox/autostart

# touch $HOME/.config/openbox/autostart
	echo "xset s off" >> ~/.config/openbox/autostart
	echo "xset -dpms" >> ~/.config/openbox/autostart
	echo "xset s noblank" >> ~/.config/openbox/autostart

# You may need to force the screen resolution
# echo "xrandr -s 800x600" >> $HOME/.config/openbox/autostart

# This is to auto hide the mouse pointer
	echo "unclutter &" >> ~/.config/openbox/autostart
	echo " " >> ~/.config/openbox/autostart
	echo "chromium \\" >> ~/.config/openbox/autostart
	echo "   --no-first-run \\" >> ~/.config/openbox/autostart
	echo "   --disable \\" >> ~/.config/openbox/autostart
	echo "   --disable-translate \\" >> ~/.config/openbox/autostart
	echo "   --disable-infobars \\" >> ~/.config/openbox/autostart
	echo "   --disable-suggestions-service \\" >> ~/.config/openbox/autostart
	echo "   --disable-save-password-bubble \\" >> ~/.config/openbox/autostart
	echo "   --start-maximized \\" >> ~/.config/openbox/autostart
	echo "   --kiosk "http://www.google.com" &" >> ~/.config/openbox/autostart

# END OF SCRIPT

	echo "Please Reboot Machine"
