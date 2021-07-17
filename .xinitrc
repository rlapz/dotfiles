#!/bin/sh

### Global Variables ###
INPUT=fcitx
#WIN_MGR=icewm-session
WIN_MGR=dwm

### Export ###
# Ascending sort
# XDG Base Directory
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# config
export CM_SELECTIONS=clipboard
export DESKTOP_SESSION=gnome
export EDITOR="vim"
export QT_QPA_PLATFORMTHEME=gtk2
export TERMINAL="alacritty"
export WEB_BROWSER=firefox --private

#input
export GTK_IM_MODULE=$INPUT
export QT_IM_MODULE=$INPUT
export QT4_IM_MODULE=$INPUT
export SDL_IM_MODULE=$INPUT
export XMODIFIERS=@im=$INPUT

# PATH
export PATH=$PATH:$HOME/.nimble/bin
export PATH=$PATH:$HOME/Application:$HOME/.local/bin

#export PATH=$PATH:/opt/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH
#export ANDROID_HOME=$HOME/Development/Android/Sdk
#export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools


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

### Launch window manager  ###
exec "$WIN_MGR" >~/.xinitrc.log 2>&1

### Cleanup ###
#killall /usr/lib/at-spi-bus-launcher
#killall /usr/lib/dconf-service
#killall /usr/bin/dbus-daemon
killall /usr/lib/mozc/mozc_server
