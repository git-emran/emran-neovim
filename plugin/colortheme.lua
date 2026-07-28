

local add = require('vim-pack').add

add {
    {
        src = 'craftzdog/solarized-osaka.nvim',
        module_name = 'solarized-osaka',
        opts = {
          transparent = true
        },

        on_setup = function()
            -- apply colorscheme AFTER setup
            vim.cmd.colorscheme 'solarized-osaka'
        end,
    },
}

