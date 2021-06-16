#!/bin/zsh

if [ -z "$DISPLAY" ] && [ $EUID != 0 ]
then
	! pgrep -x "startx|xinit" > /dev/null && [[ $(tty) == "/dev/tty1" ]] && startx 1> ~/.xsession-errors 2>&1
fi 
