# -*- mode: Shell-script; -*-
#
# $Header: /usr/local/cvs/zsh/zshrc,v 1.23 2007/04/15 18:04:18 pete Exp $
#
# zshrc - read for interactive shell.

if [[ $HOST = *example.com ]]; then
    PATCHED_ZSH=/u/hollobon/bin/zsh

    if [[ $SHELL = '/usr/local/bin/zsh' && -x $PATCHED_ZSH ]]; then
        export SHELL=$PATCHED_ZSH
        echo exec-ing $SHELL
        exec $SHELL
    fi
fi

# Set up terminfo and colours
zmodload -i zsh/terminfo
autoload colors

if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

# Key bindings: Emacs with meta key layer set up
bindkey -me

fpath=(~/.zsh/functions $fpath)

source ~/.zsh/zshalias
source ~/.zsh/zshfunc
source ~/.zsh/zshdirs
source ~/.zsh/zshcomplete

# History
export SAVEHIST=1500
export HISTSIZE=2000
export HISTFILE=$HOME/.zsh_history
setopt sharehistory

# Zsh options
setopt extended_glob
setopt nobeep
export WORDCHARS=
export PS1="%(0?..%K{red}%?%k )%2m:%B%~%b%(1j.[%j].)%# "

# Directory stack
setopt auto_pushd
setopt pushd_ignoredups
export DIRSTACKSIZE=50

autoload zmv

export PAGER=less

# run-help
alias run-help > /dev/null && unalias run-help
autoload -U run-help
HELPDIR=~/.zsh/zsh-help

bindkey ${terminfo[khome]} beginning-of-line
bindkey ${terminfo[kend]} end-of-line

if [[ $TERM = screen* ]]; then
    bindkey "^[^[OD" backward-word
    bindkey "^[^[OC" forward-word
fi

if [[ $HOST = *hollobon.com &&  ( $OSTYPE = "linux-gnu" || $OSTYPE = solaris* ) ]]; then
    PATH=${PATH}:/sbin:/usr/sbin
fi

# OS specific
if [[ $OSTYPE = freebsd* ]]; then
    export CLICOLOR=1
    export LSCOLORS=CXGXFXdaCXDADAxxxxxxxx
elif [[ $OSTYPE = *darwin* ]]; then
    export CLICOLOR=1
    export LSCOLORS=CxGxFxdaCxDADAxxxxxxxx
elif [[ -e ~/.dir_colors ]]; then
    eval $(dircolors ~/.dir_colors)
fi

# Rxvt doesn't support UNICODE which is the default for Linux (Fedora Core 3 at least...)
#if [[ $OSTYPE = linux-gnu && $TERM = rxvt ]]; then
#    export LANG=en_GB
#fi

ttyctl -f

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ $+commands[keychain] -eq 1 ]] && eval $(keychain --eval --agents ssh -Q --quiet)

# g-w, o-rw
umask 026
