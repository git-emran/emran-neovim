local add_on_event = require('vim-pack').add_on_event

add_on_event('VimEnter', {
    {
        src = 'rose-pine/neovim',
        module_name = 'rose-pine',

        opts = {
            variant = 'moon',
            dark_variant = '',

            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true,
                migrations = true,
            },

            styles = {
                bold = true,
                italic = false,
                transparency = true, -- bg_transparent
            },

            groups = {
                border = 'muted',
                link = 'iris',
                panel = 'surface',

                error = 'love',
                hint = 'iris',
                info = 'foam',
                note = 'pine',
                todo = 'rose',
                warn = 'gold',

                git_add = 'foam',
                git_change = 'rose',
                git_delete = 'love',
                git_dirty = 'rose',
                git_ignore = 'muted',
                git_merge = 'iris',
                git_rename = 'pine',
                git_stage = 'iris',
                git_text = 'rose',
                git_untracked = 'subtle',

                headings = {
                    h1 = 'iris',
                    h2 = 'foam',
                    h3 = 'rose',
                    h4 = 'gold',
                    h5 = 'pine',
                    h6 = 'foam',
                },
            },

            highlight_groups = {
                WinBar = { bg = 'NONE' },
                Comment = { italic = true },
                Conditional = { italic = true },

                ['@comment'] = { italic = true },
                ['@conditional'] = { italic = true },
                ['@keyword.conditional'] = { italic = true },
            },
        },

        on_setup = function()
            -- apply colorscheme AFTER setup
            vim.cmd.colorscheme 'rose-pine'
        end,
    },
})
