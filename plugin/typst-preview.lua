local add_on_file_type = require('vim-pack').add_on_file_type

add_on_file_type('typst', {
    {
        src = 'chomosuke/typst-preview.nvim',
        on_setup = function()
            vim.keymap.set('n', '<leader>tp', '<cmd>TypstPreview<cr>', {
                desc = 'Typst Preview',
            })
        end,
    },
})
