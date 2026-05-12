-- lua/plugins/snacks.lua
local snacks = require 'snacks'

snacks.setup {
    dashboard = {
        enabled = true,
        sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
            { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
            { pane = 2, icon = ' ', title = 'Projects', section = 'recent_files', indent = 2, padding = 1 },
            {
                pane = 2,
                icon = ' ',
                title = 'Git Status',
                section = 'terminal',
                enabled = function()
                    return snacks.git.get_root() ~= nil
                end,
                cmd = 'git status --short --branch --renames',
                height = 5,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
            },
        },
    },
    -- Essential for "loading before vim loads itself" behavior
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    notifier = { enabled = true },
    words = { enabled = true },
}

-- Dashboard specific fix:
-- If nvim is opened with no arguments, open the dashboard
vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        if vim.fn.argc() == 0 then
            snacks.dashboard.open()
        end
    end,
})

return snacks
