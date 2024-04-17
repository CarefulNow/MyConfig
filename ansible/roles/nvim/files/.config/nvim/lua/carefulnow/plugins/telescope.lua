return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',
            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        {
            'nvim-telescope/telescope-ui-select.nvim'
        },
        -- Useful for getting pretty icons, but requires a Nerd Font.
        {
            'nvim-tree/nvim-web-devicons'
        },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {
                    "^.git/",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        });
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        require("nvim-web-devicons").setup({
            color_icons = true,
            default = true,
        })
    end,
}
