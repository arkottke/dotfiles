set fish_greeting

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \co forward-char
    end
end

fish_vi_key_bindings

# set PATH /home/albert/.local/bin $PATH
set --universal fish_user_paths $fish_user_paths /home/albert/.local/bin

# Always start tmux
if status is-interactive; and not set -q TMUX
    if tmux has
        tmux attach 
    else 
        tmux new
    end
end

function ko
    kde-open5 $argv
end

# Add miniconda
set -gx PATH $PATH /home/albert/miniconda3/bin
source (conda info --root)/etc/fish/conf.d/conda.fish
