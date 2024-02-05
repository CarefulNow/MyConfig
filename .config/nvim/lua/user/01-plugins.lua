local packer = require('packer')

-- For first time packer install so that it can automatically set things up
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

packer.startup(function(use)
  -- Packer can manage itself --
  use 'wbthomason/packer.nvim'

  -- Themes --
  use {'dracula/vim', as = 'dracula'}
  
  -- Markdown plugins --
  -- Auto generate markdown table of contents
  use 'mzlogin/vim-markdown-toc'

  -- LSP Installer
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)

