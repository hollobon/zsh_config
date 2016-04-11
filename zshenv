# -*- mode: Shell-script; -*-
#
# $Header: /usr/local/cvs/zsh/zshenv,v 1.19 2007/04/15 18:05:53 pete Exp $
#
# zshenv - always read at shell startup.

# CVS
#export CVSROOT=":ext:pete@wenzhou:/usr/local/cvs"

# Make path a unique array and tie other paths to unique array variables.
typeset -U path manpath
typeset -TU PYTHONPATH pythonpath
typeset -TU LD_LIBRARY_PATH ld_library_path

if [[ $OSTYPE = cygwin ]]; then
    export CYGWIN=smbntsec
fi

#export CVS_RSH=$(which ssh)

export EDITOR=vim
export INFODIR=~/info

LOCATION=home
if [[ $HOST = *example*.com || $USERDNSDOMAIN = (#i)*example*.com || $HOST = unknown ]]; then
    LOCATION=work
fi
export LOCATION

# This sucks, because zsh needs to be exec'd again to know about
# TERMINFO changing.
if [[ $OSTYPE = solaris* && -e $HOME/.terminfo/${TERM[0]}/$TERM ]]; then
    export TERMINFO=$HOME/.terminfo
fi

if [[ $LOCATION = work ]]; then
    # Less
    export PAGER=less
    export LESSOPEN="|$HOME/bin/lesspipe.sh %s"

elif [[ $LOCATION = home ]]; then
    [[ -e /usr/local/bin ]] && PATH=/usr/local/bin:${PATH}
    [[ -e /usr/gnu/bin ]] && PATH=/usr/gnu/bin:${PATH}
    [[ -e ~/bin ]] && PATH=~/bin:${PATH}
fi