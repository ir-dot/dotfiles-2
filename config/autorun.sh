#!/usr/bin/env bash

function run {
  if [ ! -f /tmp/started ]; then
    $@&
  fi
}

setxkbmap -layout us,ir -option grp:alt_shift_toggle
xrdb -merge $HOME/.Xresources

run sh $HOME/.screenlayout/single-screen-full-hd.sh
run sh $HOME/bin/desktop-environment.sh

run ping-log
run watch -n30 $HOME/bin/battery

run xautolock -time 10 -locker "sh $HOME/.config/i3/i3lock $HOME/Pictures/Lockscreen/wallpaper.jpg"
run xss-lock -- sh $HOME/.config/i3/i3lock $HOME/Pictures/Lockscreen/wallpaper.jpg
run xxkb
run code
run google-chrome-beta
run xterm
run telegram-desktop
run nm-applet
run mpd

currenttime=$(date +%H:%M)
if [[ "$currenttime" > "19:00" ]] || [[ "$currenttime" < "06:30" ]]; then
  run xbacklight -set 70%
else
  run xbacklight -set 100%
fi

touch /tmp/started
