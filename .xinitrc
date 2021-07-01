#!/bin/sh

### Global Variables ###
INPUT=fcitx
WIN_MGR=icewm-session
#WIN_MGR=dwm

### Export ###
export WEB_BROWSER=firefox --private
export GTK_IM_MODULE=$INPUT
export QT4_IM_MODULE=$INPUT
export QT_IM_MODULE=$INPUT
export XMODIFIERS=@im=$INPUT
export CM_SELECTIONS=clipboard
export DESKTOP_SESSION=gnome
export EDITOR="vim"
export TERMINAL="alacritty"
export QT_QPA_PLATFORMTHEME=gtk2
export PATH=$PATH:$HOME/Application:$HOME/.local/bin
export PATH=$PATH:$HOME/.nimble/bin

#export PATH=$PATH:/opt/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH
#export ANDROID_HOME=$HOME/Development/Android/Sdk
#export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools


### Running necessary Apps ###

### Startup ###
~/.startup &


## dwm
if [ "$WIN_MGR" = "dwm" ]
then
	dwmblocks &
	sxhkd &
fi

### flwm
if [ "$WIN_MGR" = "flwm -x" ]
then
	xsetroot -solid \#004040
	xrdb .Xresources
fi

# Monitor
mons -e bottom --primary "VGA1"

### Launch window manager  ###
dbus-launch "$WIN_MGR"

### Cleanup ###
killall /usr/lib/at-spi-bus-launcher
killall /usr/lib/dconf-service
killall /usr/bin/dbus-daemon
killall /usr/lib/mozc/mozc_server
