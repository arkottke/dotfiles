dotfiles
========

Collection of configuration files used across a variety of platforms
(mainly Linux; a few files are Windows/mintty-only). Deployed as plain
symlinks into ``$HOME`` -- there is no stow config and no install script,
just ``ln -s``.

Layout
------

=====================  ==================================  ================================
Path                    Symlink target                      Notes
=====================  ==================================  ================================
``zshrc``               ``~/.zshrc``
``tmux.conf``           ``~/.tmux.conf``                    needs TPM, see below
``gitconfig``           ``~/.gitconfig``
``Xresources``          ``~/.Xresources``
``dir_colors``          ``~/.dir_colors``
``ctags``               ``~/.ctags``
``inputrc``             ``~/.inputrc``
``condarc``             ``~/.condarc``
``starship.toml``       ``~/.config/starship.toml``
``kitty/``              ``~/.config/kitty``                 needs submodules (themes)
``zk/``                 ``~/.config/zk``
``vim/vimrc``           ``~/.vimrc``                        pure builtin, no plugin manager
``vim/ftplugin``        ``~/.vim/ftplugin``
``vim/spell``           ``~/.vim/spell``
``nvim/``               *(not deployed)*                    pure-builtin Neovim config, kept as reference
``pikaur.conf``         Arch/pikaur only
``redshift.conf``       X11 only
``pycodestyle``         picked up by tools that read it directly
``crawlrc``             Dungeon Crawl Stone Soup
``AutoHotkey.ahk``      Windows only
``minttyrc``            Windows/mintty only
=====================  ==================================  ================================

Neovim is **not** deployed from this repo. ``~/.config/nvim`` is its own git
repo (github.com/arkottke/kickstart.nvim) -- a kickstart.nvim fork that stays
plugin-based via ``vim.pack``. Clone it directly to ``~/.config/nvim`` rather
than symlinking anything from here.

This repo also carries ``nvim/`` -- a pure-builtin, zero-plugin Neovim config
with the same keymaps/feel as ``vim/vimrc`` below and as ``~/.config/nvim``.
It's kept here as a maintained reference (see ``nvim/CLAUDE.md``), not
currently symlinked or cloned anywhere.

Deploying to a new machine
---------------------------

1. Clone with submodules -- they provide the Nord/Dracula/Catppuccin theme
   files a few configs reference (e.g. kitty)::

     git clone --recurse-submodules git@github.com:arkottke/dotfiles.git ~/Documents/dotfiles
     cd ~/Documents/dotfiles

2. Symlink the core shell/terminal configs::

     ln -sf "$PWD"/zshrc      ~/.zshrc
     ln -sf "$PWD"/tmux.conf  ~/.tmux.conf
     ln -sf "$PWD"/gitconfig  ~/.gitconfig
     ln -sf "$PWD"/Xresources ~/.Xresources
     ln -sf "$PWD"/dir_colors ~/.dir_colors
     ln -sf "$PWD"/ctags      ~/.ctags
     ln -sf "$PWD"/inputrc    ~/.inputrc
     ln -sf "$PWD"/condarc    ~/.condarc
     mkdir -p ~/.config
     ln -sf "$PWD"/starship.toml ~/.config/starship.toml
     ln -sf "$PWD"/kitty          ~/.config/kitty
     ln -sf "$PWD"/zk             ~/.config/zk

3. Vim -- single file plus two runtime dirs, no plugin manager required::

     ln -sf "$PWD"/vim/vimrc ~/.vimrc
     mkdir -p ~/.vim
     ln -sf "$PWD"/vim/ftplugin ~/.vim/ftplugin
     ln -sf "$PWD"/vim/spell    ~/.vim/spell

4. Neovim -- clone the separate repo instead of symlinking::

     git clone git@github.com:arkottke/kickstart.nvim.git ~/.config/nvim

5. tmux plugins via TPM (Tmux Plugin Manager) -- not bundled as a
   submodule, install it separately::

     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
     tmux source ~/.tmux.conf

   Then, inside a running tmux session, press ``C-a I`` (the prefix in
   this config is ``C-a``, not the tmux default ``C-b``) to fetch and
   install the plugins listed in ``tmux.conf`` (tpm, tmux-cpu,
   tmux-sensible, catppuccin/tmux, tmux-yank, tmux-sidebar). ``C-a U``
   updates them later.

6. Everything else in the table above (``AutoHotkey.ahk``, ``minttyrc``,
   ``pikaur.conf``, ``redshift.conf``, ``pycodestyle``, ``crawlrc``) is
   platform- or tool-specific -- symlink individually only where it
   applies.
