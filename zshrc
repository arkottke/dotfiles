# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="mydracula"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="false"

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
plugins=(vi-mode colorize docker extract fasd fzf git gitfast ssh-agent sudo tmux zsh-autosuggestions)

# User configuration
autoload -U zmv
# setopt HIST_FIND_NO_DUPS

# Add local to path
export PATH="$HOME/.local/bin:$PATH:/opt/geopsy/bin"

source $ZSH/oh-my-zsh.sh

# Use StarShip
eval "$(starship init zsh)"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Configure the history
setopt    appendhistory       # Append history to the history file (no overwriting)
setopt    nosharehistory      # Do not share history across terminals
setopt    noincappendhistory  # Do not mmediately append to the history file, not just when a term is killed

# Preferred editor for local and remote sessions
if [[ -f "/usr/bin/nvim" ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

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

alias vim="nvim"
# Pass terminfo to ssh server
# https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

alias ko='kde-open5'
alias jl='source /home/albert/miniconda3/bin/activate && jupyter lab'
alias rl='source /home/albert/miniconda3/bin/activate && jupyter retro'
alias reffzy='find /home/albert/Dropbox/references -type f | fzy | xargs kde-open5'
alias fp='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias glrs='git pull --recurse-submodules --jobs=10'

# Use DSLR as webcam
# https://medium.com/nerdery/dslr-webcam-setup-for-linux-9b6d1b79ae22
alias start_webcam='gphoto2 --stdout --capture-movie | ffmpeg -hwaccel nvdec -c:v mjpeg_cuvid -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'

export ZK_NOTEBOOK_DIR='/home/albert/Dropbox/misc/zettel/'

# Let Julia use multiple threads. 'auto' requires Julia 1.7+
export JULIA_NUM_THREADS='auto'

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

function to_drive() {
    for i do
        echo "Transferring: $i"
        rclone copy -P $i drive:working/
    done
}

function merge_pdf() {
    gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combined.pdf -dBATCH $*
}

function xlsx_to_csv() {
    libreoffice --headless --convert-to csv $1 --outdir .
}

# Use platformpaths for jupyter
export JUPYTER_PLATFORM_DIRS=1

if [[ -f "$HOME/.secrets" ]]; then
    source $HOME/.secrets
fi

if [[ -z "$TMUX" ]]; then
    # Create a new session if it doesn't exist
    tmux has-session || tmux new
fi

if [[ -d "$HOME/.pyenv" ]]; then
    # Add pyenv, but let starship handle the prompt
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    export PYENV_ROOT="$HOME/.pyenv"
    export MAMBA_ROOT_PREFIX="$PYENV_ROOT/versions/miniforge3-latest"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [[ -f /home/albert/.config/op/plugins.sh ]]; then
    source /home/albert/.config/op/plugins.sh
fi
