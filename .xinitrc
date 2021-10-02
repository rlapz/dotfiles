#!/bin/sh

### Global Variables ###
readonly INPUT=fcitx
readonly WIN_MGR=dwm


#input
export GTK_IM_MODULE=$INPUT
export QT_IM_MODULE=$INPUT
export QT4_IM_MODULE=$INPUT
export SDL_IM_MODULE=$INPUT
export XMODIFIERS=@im=$INPUT

# config
export CM_SELECTIONS=clipboard
export DESKTOP_SESSION=gnome
export QT_QPA_PLATFORMTHEME=gtk2
export TERMINAL="alacritty"
export VISUAL="vim"
export WEB_BROWSER=firefox --private

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

    *)
        exit 1
        ;;
esac

# Monitor
mons -e bottom --primary "VGA1"
mons -a &

### Running necessary Apps ###
~/.startup

### Launch window manager  ###
dbus-run-session "$WIN_MGR" >~/.xinitrc.log 2>&1

### Cleanup ###
#killall /usr/lib/at-spi-bus-launcher
#killall /usr/lib/dconf-service
#killall /usr/bin/dbus-daemon
#killall /usr/lib/mozc/mozc_server
#killall /usr/lib/gvfsd
#killall /usr/lib/gvfsd-fuse
