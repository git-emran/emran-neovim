


local add = require('vim-pack').add

add {
    {
        src = 'ThorstenRhau/token',
        opts = {
          transparent = true
        },

        on_setup = function()
            -- apply colorscheme AFTER setup
            vim.cmd.colorscheme 'token-flint'
        end,
    },
}


