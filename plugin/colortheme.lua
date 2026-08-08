


local add = require('vim-pack').add

add {
    {
        src = 'mcauley-penney/techbase.nvim',
        module_name = 'techbase',
        opts = {
          transparent = true
        },

        on_setup = function()
            -- apply colorscheme AFTER setup
            vim.cmd.colorscheme 'entryway' -- or 'techbase'
        end,
    },
}


