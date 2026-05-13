local add_on_event = require('vim-pack').add_on_event

add_on_event('FileType', {
    {
        src = 'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            checkbox = {
                enabled = true,
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'.
                    icon = '󰄱 ',
                    -- Highlight for the unchecked icon.
                    highlight = 'RenderMarkdownUnchecked',
                    -- Highlight for item associated with unchecked checkbox.
                    scope_highlight = nil,
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'.
                    icon = '󰱒 ',
                    -- Highlight for the checked icon.
                    highlight = 'RenderMarkdownChecked',
                    -- Highlight for item associated with checked checkbox.
                    scope_highlight = nil,
                },
            },
        },
    },
})
