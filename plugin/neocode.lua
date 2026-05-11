local add_on_event = require('vim-pack').add_on_event

add_on_event('VimEnter', {
    {
        src = 'monkoose/neocodeium',

        opts = {
            enabled = false,
        },

        on_setup = function()
            local neocodeium = require 'neocodeium'

            vim.keymap.set('i', '<A-f>', neocodeium.accept, {
                desc = 'Accept AI suggestion',
            })

            vim.keymap.set('i', '<M-,>', function()
                neocodeium.accept()
            end, {
                desc = 'Accept AI suggestion',
            })

            vim.keymap.set('i', '<M-w>', function()
                neocodeium.accept_word()
            end, {
                desc = 'Accept AI suggestion word',
            })

            vim.keymap.set('i', '<M-l>', function()
                neocodeium.accept_line()
            end, {
                desc = 'Accept AI suggestion line',
            })
        end,
    },
})

