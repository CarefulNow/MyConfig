local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    -- Packer can manage itself --
    --use 'wbthomason/packer.nvim'

    -- Themes --
    {'folke/tokyonight.nvim'},

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.6',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },
    {'nvim-treesitter/nvim-treesitter-context'},

    -- Markdown plugins --
    -- Auto generate markdown table of contents
    --use 'mzlogin/vim-markdown-toc'

    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- recommended....
        ft = { 'rust' },
    },

    {
        'https://gitlab.com/code-stats/code-stats-vim.git',
        dependencies = {
            {'nvim-lualine/lualine.nvim'},
            {'nvim-tree/nvim-web-devicons'},
        }
    },

    -- LSP Installer
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'mfussenegger/nvim-jdtls'},
            {'mfussenegger/nvim-dap'},
            {'nvim-neotest/nvim-nio'},
            {'rcarriga/nvim-dap-ui'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    },
})
