# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# ---------------------------------------------------------- #

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# if running oksh
if [ -n "$OKSH_VERSION" ] && [ -f "$HOME/.okshrc" ]
then
    export ENV="$HOME/.okshrc"
    . "$HOME/.okshrc"
fi

# ---------------------------------------------------------- #

# PATH
export PATH=$PATH:$HOME/.nimble/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/Application
#export PATH=$PATH:/opt/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH
#export ANDROID_HOME=$HOME/Development/Android/Sdk
#export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# XDG Base Directory
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# man
export MANPAGER=less

# default text editor
export EDITOR=vim

. "$HOME/.cargo/env"
