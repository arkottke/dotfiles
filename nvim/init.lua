-- Install packer on new copies
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- My plugins here
  require('plugins/packer')
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


require('settings')
require('keymaps')
require('plugins/aerial')
require('plugins/diaglist')
require('plugins/formatter')
require('plugins/lightspeed')
require('plugins/lualine')
require('plugins/zk-nvim')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/hlslens')
require('plugins/packer')
require('plugins/tabnine')
require('plugins/telescope')
require('plugins/tmux-navigation')

