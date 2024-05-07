#!/bin/bash
if [ $(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}') == 'br' ]
then
  setxkbmap -layout us -variant altgr-intl
  echo $(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')
else
  setxkbmap -model abnt2 -layout br
  echo $(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')
fi
