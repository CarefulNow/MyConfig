-- enable syntax,
vim.opt.termguicolors = true

vim.cmd [[
  syntax enable
  colorscheme tokyonight-night
]]

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.codestats_api_key = '<YOUR-API-KEY-HERE>'
require('lualine').setup {
    sections = { 
        lualine_x = {
            'tagbar',
            'filetype',
            '%{CodeStatsXp()}',
        }
    }
}

require("nvim-web-devicons").setup({
    color_icons = true,
    default = true,
})

