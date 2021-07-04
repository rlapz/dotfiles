#!/bin/sh

W_DIR="$HOME/Pictures/Wallpapers"
DELAY=30

sleep 1

while true; do
	feh --randomize --bg-fill "$W_DIR"/*
	sleep $DELAY
done
