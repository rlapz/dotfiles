#!/bin/sh


# ------------------------------------------------------
#                       Set Dirs
# ------------------------------------------------------
readonly H_BIN=$HOME/.local/bin
#readonly H_SHARE=$HOME/.local/share
readonly H_CONFIG=$HOME/.config

readonly D_DIR=$HOME/Documents/dotfiles
readonly D_BIN=$D_DIR/.local/bin
#readonly D_SHARE=$D_DIR/.local/share
readonly D_CONFIG=$D_DIR/.config


case "$1" in
"cd")
	cd "$D_DIR"
	$SHELL
	exit 0
	;;
esac


# ------------------------------------------------------
#                      Check Dirs
# ------------------------------------------------------

[ ! -d "$D_DIR" ]    && mkdir -p "$D_DIR"
[ ! -d "$D_BIN" ]    && mkdir -p "$D_BIN"
#[ ! -d "$D_SHARE" ]  && mkdir -p "$D_SHARE"
[ ! -d "$D_CONFIG" ] && mkdir -p "$D_CONFIG"


# ------------------------------------------------------
#                 function declaration(s)
# ------------------------------------------------------
rsync_c()
{
    rsync -auvzP "$1" "$2"
}


# ------------------------------------------------------
#                   Backup process
# ------------------------------------------------------
# $HOME/
readonly HOME_FILES=".profile .startup .xinitrc \
                    .zlogin .zshrc .bashrc .okshrc"

# $HOME/.config
readonly CONFIG_FILES="alacritty dunst sxhkd"

# $HOME/.local/bin
readonly BIN_FILES="= brightness clock locknow dmenu_desktop dmenu_run_i \
                    moediary moenotes screensh netspeed moewallpaper \
                    moewallpaper.c moewallpaper.sh sp transsh gtts icetile ipinfo \
                    urlencode.c urlencode srv chdns pinga
                    "

# backup this file
rsync_c "$0" "$D_DIR"

# backup from $HOME dir
for I in $HOME_FILES
do
    rsync_c "$I" "$D_DIR"
done


# backup from $HOME/.config dir
for I in $CONFIG_FILES
do
    rsync_c "$H_CONFIG/$I" "$D_CONFIG"
done

# backup from .local/bin dir
for I in $BIN_FILES
do
    rsync_c "$H_BIN/$I" "$D_BIN"
done


# ------------------------------------------------------
#                For specific Files/dirs
# ------------------------------------------------------
# Vim
rsync_c "$HOME/.vim/after" "$D_DIR/.vim/"

# icewm
readonly ICEWM_D="keys preferences theme toolbar icons winoptions themes"

for I in $ICEWM_D
do
    rsync_c "$HOME/.icewm/$I" "$D_DIR/.icewm/"
done

# vifm
readonly VIFM_D="colors vifm-media vifmrc"
for I in $VIFM_D
do
    rsync_c "$H_CONFIG/vifm/$I" "$D_CONFIG/vifm"
done

# cmus
rsync_c "$H_CONFIG/cmus/rc" "$D_CONFIG/cmus/"


# ------------------------------------------------------
echo "Done!"
exit 0
