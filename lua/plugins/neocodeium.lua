-- AI completions.
return {
    {
        'monkoose/neocodeium',
        event = 'VeryLazy',
        config = function()
            local neocodeium = require 'neocodeium'
            neocodeium.setup {
                enabled = false,
            }
            vim.keymap.set('i', '<A-f>', neocodeium.accept)
        end,
        keys = {
            {
                '<M-,>',
                function()
                    require('neocodeium').accept()
                end,
                desc = 'Accept AI suggestion',
                mode = 'i',
            },
            {
                '<M-w>',
                function()
                    require('neocodeium').accept_word()
                end,
                desc = 'Accept AI suggestion word',
                mode = 'i',
            },
            {
                '<M-l>',
                function()
                    require('neocodeium').accept_line()
                end,
                desc = 'Accept AI suggestion line',
                mode = 'i',
            },
        },
    },
}
