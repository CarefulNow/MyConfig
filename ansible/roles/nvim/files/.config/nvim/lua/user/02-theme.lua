-- enable syntax,
-- use dracula colorscheme
vim.cmd [[
  syntax enable
  colorscheme tokyonight-night
]]

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.codestats_api_key = '<MY-KEY-HERE>'
require('lualine').setup {
    sections = { 
        lualine_x = {
            'tagbar',
            'filetype',
            '%{CodeStatsXp()}',
        }
    }
}

