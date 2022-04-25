#!/bin/bash

for w in Firefox Code Alacritty; do
xdotool search —class "$w" windowkill
done

sleep 2
shutdown -h now
