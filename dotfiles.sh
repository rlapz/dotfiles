#!/bin/bash


H_BIN=$HOME/.local/bin
H_SHARE=$HOME/.local/share
H_CONFIG=$HOME/.config

DOTFILES=$HOME/Documents/dotfiles
D_BIN=$DOTFILES/.local/bin
D_SHARE=$DOTFILES/.local/share
D_CONFIG=$DOTFILES/.config

[ ! -d "$DOTFILES" ] && mkdir -p "$DOTFILES"
[ ! -d "$D_BIN" ] && mkdir -p "$D_BIN"
[ ! -d "$D_SHARE" ] && mkdir -p "$D_SHARE"
[ ! -d "$D_CONFIG" ] && mkdir -p "$D_CONFIG"

RSYNC_C="rsync -auvzP"

# this file
$RSYNC_C "$0" "$DOTFILES"

# home dir
$RSYNC_C "$HOME"/{.profile,.startup,.vimrc,.xinitrc,.zlogin,.zshrc} "$DOTFILES"
# vim
$RSYNC_C "$HOME"/.vim/after "$DOTFILES"/.vim
# icewm
$RSYNC_C "$HOME"/.icewm/{keys,preferences,theme,toolbar,icons,winoptions,themes} "$DOTFILES"/.icewm/

# home/.config dir
# whole file in dir
$RSYNC_C "$H_CONFIG"/{alacritty,dunst,sxhkd} "$D_CONFIG"
# vifm
$RSYNC_C "$H_CONFIG"/vifm/{colors,vifm-media,vifmrc} "$D_CONFIG"/vifm
# cmus
$RSYNC_C "$H_CONFIG"/cmus/rc "$D_CONFIG"/cmus/

# home/.local/bin dir
$RSYNC_C "$H_BIN"/{'=',clock,dmenu_{desktop,run_i},moe{diary,notes},netspeed,moewallpaper,moewallpaper.c,sp,'trans-cli',icetile} "$D_BIN"

#-----#

echo "Done!"
