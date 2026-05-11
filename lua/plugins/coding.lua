return {

    -- Autopair tags and braces
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            local npairs = require 'nvim-autopairs'
            local Rule = require 'nvim-autopairs.rule'
            local conds = require 'nvim-autopairs.conds'

            npairs.setup()

            -- Autoclosing angle-brackets (MariaSolOs style)
            npairs.add_rule(Rule('<', '>', {
                '-html',
                '-javascriptreact',
                '-typescriptreact',
            }):with_pair(conds.before_regex('%a+:?:?$', 3)):with_move(function(opts)
                return opts.char == '>'
            end))
        end,
    },

    -- Auto <tag> completion
    {
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            opts = {
                enable_close = true,
                enable_rename = false,
                enable_close_on_slash = true,
            },
        },
        config = function(_, opts)
            require('nvim-ts-autotag').setup(opts)
        end,
    },
}
