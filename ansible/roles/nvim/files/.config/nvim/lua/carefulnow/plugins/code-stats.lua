return {
    'https://gitlab.com/code-stats/code-stats-vim.git',
    dependencies = {
        {
            'nvim-lualine/lualine.nvim'
        },
        {
            'nvim-tree/nvim-web-devicons'
        },
    },
    config = function()
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
    end
}

