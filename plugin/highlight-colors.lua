local add_on_event = require('vim-pack').add_on_event

add_on_event('BufWritePre', {
    src = 'brenoprata10/nvim-highlight-colors',
    opts = {
        render = 'background',
        enable_hex = true,
        enable_short_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_hsl_without_function = true,
        enable_ansi = true,
        enable_var_usage = true,
        enable_tailwind = true,
    },
})
