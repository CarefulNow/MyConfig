-- Set TOC depth to 2 in markdown
vim.g.vmt_max_level = 3

-- Set Tab to 4 spaces. Sets "tabs" to 8 chars so they are obvious when they appear
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 0

vim.opt.undofile = true

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
}

vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

