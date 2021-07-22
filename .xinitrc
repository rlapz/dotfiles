#!/bin/sh

### Global Variables ###
INPUT=fcitx
#WIN_MGR=icewm-session
WIN_MGR=dwm


### Running necessary Apps ###
~/.startup

case $WIN_MGR in
	"dwm")
		dwmblocks &
		sxhkd &
		;;
	"icewm-session")
		# generate menu
		mmaker -f --no-legacy icewm -t alacritty -s GNOME,Console
		#icewm-menu-fdo --seps --no-sub-cats --no-sep-others --sep-after > "$HOME/.icewm/menu"
		nm-applet &
		osmo & # calendar
		;;
esac

# Monitor
mons -e bottom --primary "VGA1"
mons -a &

### Launch window manager  ###
"$WIN_MGR" >~/.xinitrc.log 2>&1

### Cleanup ###
#killall /usr/lib/at-spi-bus-launcher
#killall /usr/lib/dconf-service
#killall /usr/bin/dbus-daemon
#killall /usr/lib/mozc/mozc_server
