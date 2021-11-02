# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#------------------------------
# History stuff
#------------------------------
HISTTIMEFORMAT="[%F %T] "
HISTSIZE=100000
HISTFILE=~/.histfile
PROMPT_COMMAND="history -a; echo -ne $1"
HISTCONTROL=ignoredups
#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="vim"
#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS
#------------------------------
# Alias stuff
#------------------------------
case `uname` in
    "Linux")
        alias ls="ls --color -aF"
        alias ll="ls --color -lah"
        ;;
    "FreeBSD")
        alias ls="ls -G -aF"
        alias ll="ls -G -lah"
        ;;
    "OpenBSD")
        alias ls="colorls -G -aF"
        alias ll="colorls -G -lah"
        ;;
    "Darwin")
        alias ll="ls -G -lah"
        alias ls="ls -G -F"
        ;;
    *)
        alias ll="ls -lah --color"
esac
alias fe1="ssh jk@login.genome.au.dk"
alias dmz="ssh root@130.225.14.69"
alias suvi="ssh jk@51.15.240.149"
alias snd="sysctl hw.snd.default_unit=1"

PATH=/usr/local/emacs/bin:$PATH

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}
#------------------------------
# Prompt
#------------------------------
PS1="\[\033[32m\][\w]\[\033[0m\] \[\e[31m\]\`nonzero_return\`\[\e[m\]\n\[\033[1;36m\]\u\[\033[1;33m\]@\[\e[33m\]\h\[\e[m\]-> \[\033[0m\]"
#------------------------------
# Local stuff
#------------------------------
export PATH=${HOME}/bin:$PATH
if [ -d ${HOME}/.yarn/bin ] ; then
    export PATH=${HOME}/.yarn/bin:$PATH
fi
export LANGUAGE=en_IE
export LANG=en_IE.UTF-8
export LC_CTYPE=en_IE.UTF-8
export LC_NUMERIC=en_IE.UTF-8
export LC_TIME=en_IE.UTF-8
export LC_COLLATE=en_IE.UTF-8
export LC_MONETARY=en_IE.UTF-8
export LC_MESSAGES=en_IE.UTF-8
export LC_PAPER=en_IE.UTF-8
export LC_NAME=en_IE.UTF-8
export LC_ADDRESS=en_IE.UTF-8
export LC_TELEPHONE=en_IE.UTF-8
export LC_MEASUREMENT=en_IE.UTF-8
export LC_IDENTIFICATION=en_IE.UTF-8

if [ $(uname) == Darwin ] ; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    if [ -d /opt/homebrew/bin ] ; then
        PATH=$PATH:/opt/homebrew/bin
    fi
fi
#------------------------------
# for screen + emacs
#------------------------------
export TERM=xterm-256color
#------------------------------
# ssh using gpg keys
#------------------------------
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#------------------------------
# gpg keys
#------------------------------
NELGPG=8E1CA07BFE31A568EC5B33127DDE81C0B2FD98A0
NELGITGPG=4D5BAB9C2787879003BBB02338788DA9AAC9FFF7
PRIVGPG=3B45BED6C94F50270A6196449534C96A934C0DCB
CSCGPG=BB0B59EF209475522A6B6C238DB1BB49BC9E9C5F
