use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)

[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval "$(dircolors -b ~/.dir_colors)"
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval "$(dircolors -b /etc/DIR_COLORS)"
		fi
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'

    #PS1='\n\[\033[01;01m\]\h [\w]\n\`-> \[\033[00m\]'
    #PS1='\[\033[01;01m\]________\n\h [\w]\n\`-> \[\033[00m\]'
    #PS1='\[\033[01;35m\]---------------\[\033[00m\]\
    PS1='\[\033[01;45m\]* \h [\w] \[\033[00m\]\
	 \n\[\033[01;35m\]\`->\[\033[00m\] '
    #PS1='\[\033[01;100m\]* \h [\w] \[\033[00m\]\
#	 \n\[\033[01;01m\]\`->\[\033[00m\] '

else
    PS1='\h [\w]-> '
fi

# GPG
GPG_TTY=$(tty)
export GPG_TTY

alias ls='ls --color=auto -h'
alias l='ls -CF'
alias ll='l -l'
alias lll='ll -a'
alias la='l -a'

# openRC
#alias svr='doas rc-service'
#alias svs='rc-status'
#alias svu='doas rc-update'

# golang
alias gof='go fmt'
alias gor='go run'
alias gob='go build'

unset use_color safe_term match_lhs sh
. "$HOME/.cargo/env"
