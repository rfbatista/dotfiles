#!/bin/sh  
while true  
do  
  set -eu | export DISPLAY=:0 | /usr/bin/feh --bg-fill --randomize $HOME/wallpapers/*
  sleep 60
done
