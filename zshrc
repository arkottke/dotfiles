# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dracula"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(extract fasd fzf git gitfast ssh-agent sudo tmux vi-mode)

# User configuration
autoload -U zmv
# setopt HIST_FIND_NO_DUPS

# Add local to path
export PATH="/home/albert/.local/bin:/home/albert/.gem/ruby/2.7.0/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Add fake paths on MSYS for completion
if [[ -n $MSYSTEM && $MSYSTEM == MSYS ]]; then
    # complete hard drives in msys2
    drives=$(mount | sed -rn 's#^[A-Z]: on /([a-z]).*#\1#p' | tr '\n' ' ')
    zstyle ':completion:*' fake-files /: "/:$drives"
    unset drives
fi

# Load solarized directory colors
# eval `dircolors $HOME/.dir_colors`

# Incremental search
bindkey '^r' history-incremental-search-backward

# Export java options for antialiasing
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ko='kde-open5'
alias tmux='TERM=screen-256color tmux'
alias jn='jupyter notebook'
alias jc='jupyter console'
alias reffzy='find /home/albert/Dropbox/references -type f | fzy | xargs kde-open5'

function extract_clip() {
    fname=$1
    start=$2
    if [[ $# -ge 3 ]]; then
        length=$3
    else
        length=00:00:15
    fi
    echo $length
    avconv -ss $start -t $length -i $fname -an -aq 5 -ac 2 -qmax 25 -threads 2 myvideo.webm
}

function to_gdrive() {
    for i do
        echo "Transferring: $i"
        rclone copy -P $i gdrive:working/
    done
}

function merge_pdf() {
    gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combined.pdf -dBATCH $*
}

function xlsx_to_csv() {
    libreoffice --headless --convert-to csv $1 --outdir .
}

# Load extensions
[ -f /home/albert/.travis/travis.sh ] && source /home/albert/.travis/travis.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -z "$TMUX" ]]; then
    # Create a new session if it doesn't exist
    tmux has-session || tmux new
fi

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_CTRL_T_COMMAND='ag --nocolor -g ""'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/albert/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/albert/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/albert/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/albert/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

