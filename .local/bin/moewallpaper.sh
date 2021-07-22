#!/bin/sh


W_PATH="$HOME/Pictures/Wallpapers"

cd "$W_PATH" || exit

W_FILES=$(ls)

for i in $W_FILES
do
    xwallpaper --zoom "$i"
    sleep 30
done
