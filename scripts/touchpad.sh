#!/bin/bash

touchpad_state=$(synclient -l | grep -i TouchpadOff | awk '{ print $3 }');

if [[ $touchpad_state == 0 ]]; then
    synclient TouchpadOff=1
else
    synclient TouchpadOff=0
fi
