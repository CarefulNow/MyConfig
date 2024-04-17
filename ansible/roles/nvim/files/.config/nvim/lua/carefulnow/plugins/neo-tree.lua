return {
    'nvim-neo-tree/neo-tree.nvim',
    version = "*",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('neo-tree').setup {
            filesystem = {
                filtered_items = {
                    hide_hidden = false,
                    hide_dotfiles = false,
                }
            }
        }
        vim.keymap.set('n', '<leader>p', function()
                local reveal_file = vim.fn.expand('%.p')
                if (reveal_file == '') then
                    reveal_file = vim.fn.getcwd()
                else
                    local f = io.open(reveal_file, "r")
                    if (f) then
                        f.close(f)
                    else
                        reveal_file = vim.fn.getcwd()
                    end
                end
                require('neo-tree.command').execute({
                    action = "focus",
                    source = "filesystem",
                    position = "left",
                    toggle = true,
                    reveal_file = reveal_file,
                    reveal_force_cwd = true,
                })
            end,
            { desc = "Open neo-tree [P]roject view" }
        );

        vim.keymap.set('n', '<leader>o', function()
                local reveal_file = vim.fn.expand('%.p')
                if (reveal_file == '') then
                    reveal_file = vim.fn.getcwd()
                else
                    local f = io.open(reveal_file, "r")
                    if (f) then
                        f.close(f)
                    else
                        reveal_file = vim.fn.getcwd()
                    end
                end
                require('neo-tree.command').execute({
                    action = "focus",
                    source = "filesystem",
                    position = "left",
                    reveal_file = reveal_file,
                    reveal_force_cwd = true,
                })
            end,
            { desc = "Swap focus to the neo-tree project view" }
        );
    end
}

