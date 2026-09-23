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
plugins=(vi-mode colorize docker extract zoxide fzf git ssh-agent sudo tmux zsh-autosuggestions)

# User configuration
autoload -U zmv
# setopt HIST_FIND_NO_DUPS

# Add local to path
export PATH="$HOME/.local/bin:$HOME/.fzf/bin:$PATH:/opt/geopsy/bin"

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
alias chromium-headless-shell="google-chrome-stable --headless --disable-gpu"
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
        if [[ -d "$i" ]]; then
            local dest="drive:working/${i%/}"
        else
            local parent="$(dirname "$i")"
            if [[ "$parent" == "." ]]; then
                local dest="drive:working"
            else
                local dest="drive:working/$parent"
            fi
        fi
        echo "Transferring: $i -> $dest"
        rclone copy -P "$i" "$dest"
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

# One-pass configuration
if [[ -f /home/albert/.config/op/plugins.sh ]]; then
    source /home/albert/.config/op/plugins.sh
fi

# Created by `userpath` on 2025-05-23 16:51:07
export PATH="$PATH:/home/albert/.local/share/hatch/pythons/3.12/python/bin"

export ANDROID_HOME=/home/albert/Android/Sdk
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# Use ^y to expand or complete consistent with blink
bindkey "^y" expand-or-complete

# Fix Kitty terminal ssh completion error
zstyle ':completion:*:*:(ssh|scp|sftp):*' matcher-list ''

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/albert/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/home/albert/.julia/juliaup/completions/zsh.zsh" ] && source "/home/albert/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<

# >>> claude-auto-retry >>>
# Drop any pre-existing `claude` alias (Claude Code's own installer adds one)
# before defining the wrapper function. Without this, the shell expands the
# alias while parsing `claude() {`, producing "syntax error near unexpected
# token '('" when the rc file is sourced.
unalias claude 2>/dev/null || true
claude() {
  # Degrade to plain claude if already inside a wrapped session, or if the launcher
  # is gone (package removed via `npm uninstall -g` without `claude-auto-retry
  # uninstall` first) — an orphaned wrapper must never break the claude command.
  if [ "${CLAUDE_AUTO_RETRY_ACTIVE}" = "1" ] || [ ! -e "/usr/lib/node_modules/claude-auto-retry/src/launcher.js" ]; then
    command claude "$@"
    return $?
  fi
  export CLAUDE_AUTO_RETRY_ACTIVE=1
  local _car_exit
  if [ -n "${ZSH_VERSION:-}" ]; then
    # zsh: localtraps restores the user's INT/TERM traps automatically on function
    # return. Capture/restore is NOT portable here — `trap -p` is a bashism (zsh
    # treats it as setting a handler), and $(trap) runs in a subshell where zsh
    # lists nothing — so the bash-style path silently wiped the user's traps.
    setopt localoptions localtraps
    trap 'unset CLAUDE_AUTO_RETRY_ACTIVE' INT TERM
    node "/usr/lib/node_modules/claude-auto-retry/src/launcher.js" "$@"
    _car_exit=$?
  else
    # bash: function traps are global, so capture and restore around ours.
    local _car_old_int_trap _car_old_term_trap
    _car_old_int_trap=$(trap -p INT 2>/dev/null)
    _car_old_term_trap=$(trap -p TERM 2>/dev/null)
    trap 'unset CLAUDE_AUTO_RETRY_ACTIVE' INT TERM
    node "/usr/lib/node_modules/claude-auto-retry/src/launcher.js" "$@"
    _car_exit=$?
    # Restore previous traps instead of clobbering them
    eval "${_car_old_int_trap:-trap - INT}"
    eval "${_car_old_term_trap:-trap - TERM}"
  fi
  unset CLAUDE_AUTO_RETRY_ACTIVE
  return $_car_exit
}
# <<< claude-auto-retry <<<

