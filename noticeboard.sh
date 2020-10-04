#!/bin/bash
# You need to have installed Debian 10 and setup SSH and NO GUI.
# Make sure you login as Root

# upgrade packages to the latest versions
  apt-get update -y
  apt-get upgrade -y

# Add a user, this will be used for autologin and config
  useradd -m kiosk

# Install the requred packages
  apt-get install sudo xorg chromium openbox lightdm unclutter

# Add autologin at the end of the config file
  sed -i "$ a autologin-user=kiosk" /etc/lightdm/lightdm.conf
  sed -i "$ a user-session=openbox" /etc/lightdm/lightdm.conf

  #nano /etc/lightdm/lightdm.conf
  #[SeatDefaults]
  #autologin-user=kiosk
  #user-session=openbox

# Login as the new user
  su kiosk

# Create the config file for openbox for the user
  mkdir -p $HOME/.config/openbox
  touch $HOME/.config/openbox/autostart
  echo "xset s off" >> $HOME/.config/openbox/autostart
  echo "xset -dpms" >> $HOME/.config/openbox/autostart
  echo "xset s noblank" >> $HOME/.config/openbox/autostart

# You may need to force the screen resolution
# echo "xrandr -s 800x600" >> $HOME/.config/openbox/autostart

# This is to auto hide the mouse pointer
  echo "unclutter &" >> $HOME/.config/openbox/autostart
  echo " " >> $HOME/.config/openbox/autostart
  echo "chromium \\" >> $HOME/.config/openbox/autostart
  echo "   --no-first-run \\" >> $HOME/.config/openbox/autostart
  echo "   --disable \\" >> $HOME/.config/openbox/autostart
  echo "   --disable-translate \\" >> $HOME/.config/openbox/autostart
  echo "   --disable-infobars \\" >> $HOME/.config/openbox/autostart
  echo "   --disable-suggestions-service \\" >> $HOME/.config/openbox/autostart
  echo "   --disable-save-password-bubble \\" >> $HOME/.config/openbox/autostart
  echo "   --start-maximized \\" >> $HOME/.config/openbox/autostart
  echo "   --kiosk "http://www.google.com" &" >> $HOME/.config/openbox/autostart

# END OF SCRIPT

echo "Please Reboot Machine"
