#!/usr/bin/env bash

prev_state=0

while true; do
    # Check if Caps Lock is ON
    xset q | grep "Caps Lock" | grep -q "on"
    state=$?

    if [[ $state -eq 0 && $prev_state -ne 0 ]]; then
        notify-send -u low -a "capslock" "Caps Lock ON - $(date +%H:%M:%S)"
    elif [[ $state -ne 0 && $prev_state -eq 0 ]]; then
        notify-send -u low -a "capslock" "Caps Lock OFF - $(date +%H:%M:%S)"
    fi

    prev_state=$state
    sleep 0.2
done

