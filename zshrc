source /etc/profile

# No beeping
unsetopt beep

# Number of lines kept in history
HISTSIZE=5000

# Number of lines saved in the history after logout
SAVEHIST=5000

# Location of history file
HISTFILE=~/.zhistory

# Remove duplicates from the history
setopt hist_save_no_dups

# Vi style key bindings
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/albert/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
# Custom prompt
PS1="%{$fg[green]%}%n@%m %{$fg[yellow]%}%3c
%{$reset_color%}$ "

bindkey -M viins '^N' history-incremental-search-backward
bindkey -M viins '^P' history-incremental-search-forward

alias ls='ls --color'

# Set the editor
export EDITOR='vim'
export SVN_EDITOR='vim'

# Fasd setup for zsh
eval "$(fasd --init auto)"

# Functions for setting window title
function title {
if [[ $TERM == "screen" ]]; then
    # Use these two for GNU Screen:
    print -nR $'\033k'$1$'\033'\\

    print -nR $'\033]0;'$2$'\a'
elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
    # Use this one instead for XTerms:
    print -nR $'\033]0;'$*$'\a'
fi
}

function precmd {
title zsh "$PWD"
}

function preexec {
emulate -L zsh
local -a cmd; cmd=(${(z)1})
title $cmd[1]:t "$cmd[2,-1]"
}

if [[ $HOST == "SFBD29905" ]]; then
    # Commands for work computer
    
    # Don't buffer Python -- import for windows
    export PYTHONUNBUFFERED=1
    alias py='/opt/miniconda/python.exe'
else
    # Other computers
    # Merge pdf
    function mergepdf() {
        gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$@[1] $@[2,-1]
    }

    # Random videos in folder
    function playrandom() {
        ls $1/**/*.(mp4|mov) | xargs vlc --random
    }

    # Add local bin/
    export PATH=/home/albert/.local/bin:$PATH

    # Add qwt to ld_path
    export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/home/albert/Documents/programs/qwt-6.1/lib 
fi

# Commands with passwords are excluded from github
if [[ -a .zshrc_priv ]]; then
   source ~/.zshrc_priv
fi
