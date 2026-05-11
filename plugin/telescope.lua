local add_on_event = require('vim-pack').add_on_event

add_on_event('VimEnter', {
    -- deps
    {
        src = 'nvim-lua/plenary.nvim',
        setup = false,
    },

    {
        src = 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        setup = false,
    },

    {
        src = 'nvim-telescope/telescope-file-browser.nvim',
        setup = false,
    },

    -- main telescope
    {
        src = 'nvim-telescope/telescope.nvim',

        opts = {
            defaults = {
                wrap_results = true,
                layout_strategy = 'horizontal',
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
                winblend = 0,
                file_ignore_patterns = { 'node_modules' },
            },

            pickers = {
                diagnostics = {
                    theme = 'ivy',
                    initial_mode = 'normal',
                },
            },
        },

        on_setup = function()
            local telescope = require 'telescope'

            telescope.load_extension 'fzf'
            telescope.load_extension 'file_browser'

            local builtin = require 'telescope.builtin'

            -- Keymaps
            vim.keymap.set('n', '<leader>fP', function()
                builtin.find_files {
                    cwd = vim.fn.stdpath 'data' .. '/site/pack',
                }
            end, { desc = 'Find Plugin File' })

            vim.keymap.set('n', ';f', function()
                builtin.find_files {
                    hidden = true,
                    no_ignore = false,
                    find_command = {
                        'fd',
                        '--type',
                        'f',
                        '--max-depth',
                        '5',
                    },
                }
            end, { desc = 'Find files' })

            vim.keymap.set('n', ';r', function()
                builtin.live_grep {
                    additional_args = { '--hidden' },
                }
            end, { desc = 'Live grep' })

            vim.keymap.set('n', '\\\\', function()
                builtin.buffers()
            end, { desc = 'Buffers' })

            vim.keymap.set('n', ';t', function()
                builtin.help_tags()
            end, { desc = 'Help tags' })

            vim.keymap.set('n', ';;', function()
                builtin.resume()
            end, { desc = 'Resume' })

            vim.keymap.set('n', ';e', function()
                builtin.diagnostics()
            end, { desc = 'Diagnostics' })

            vim.keymap.set('n', ';s', function()
                builtin.treesitter()
            end, { desc = 'Treesitter' })

            vim.keymap.set('n', ';c', function()
                builtin.lsp_incoming_calls()
            end, { desc = 'LSP calls' })

            vim.keymap.set('n', 'sf', function()
                local telescope = require 'telescope'

                telescope.extensions.file_browser.file_browser {
                    path = '%:p:h',
                    cwd = vim.fn.expand '%:p:h',
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = 'normal',
                    layout_config = { height = 40 },
                }
            end, { desc = 'File browser' })
        end,
    },
})
