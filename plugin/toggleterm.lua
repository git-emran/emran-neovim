local add = require('vim-pack').add

add {
    {
        src = 'akinsho/toggleterm.nvim',
        module_name = 'toggleterm',

        opts = {
            size = 20,
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = 'float',
            close_on_exit = true,
            shell = vim.o.shell,
            dir = 'git_dir',
        },

        on_setup = function()
            vim.keymap.set({ 'n', 't' }, '<C-\\>', '<cmd>ToggleTerm<cr>', {
                desc = 'Toggle terminal',
            })
        end,
    },
}
