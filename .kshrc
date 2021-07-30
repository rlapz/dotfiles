#!/bin/sh

PS1='\[\033[01;01m\]\h [\w]\n\`-> \[\033[00m\]'

# vi mode
set -o vi

# history
HISTFILE="$HOME/.ksh_history"
HISTSIZE=5000

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# aliased commands
alias ls='ls --color=auto -h'
alias l='ls -CF'
alias ll='l -l'
alias lll='ll -a'
alias la='l -a'

alias more='more -d'
alias h='fc -l | more'

# openRC
alias svr='doas rc-service'
alias svs='rc-status'
alias svu='doas rc-update'

# golang
alias gof='go fmt'
alias gor='go run'
alias gob='go build'
