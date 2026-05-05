-- Auto-completion:
return {
    {
        'saghen/blink.cmp',
        version = '*', -- Use a release tag for stability and prebuilt binaries
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saghen/blink.lib',
            'rafamadriz/friendly-snippets',
        },
        build = function()
            require('blink.cmp').build():wait(60000)
        end,
        event = 'InsertEnter',
        lazy = false,
        opts = {
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-\\>'] = { 'hide', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show' },
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                ['<C-p>'] = { 'select_prev' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                list = {
                    selection = { preselect = false, auto_insert = true },
                    max_items = 10,
                },
                documentation = { auto_show = true },
                menu = {
                    scrollbar = false,
                    draw = {
                        gap = 2,
                        columns = {
                            { 'kind_icon', 'kind', gap = 1 },
                            { 'label', 'label_description', gap = 1 },
                        },
                    },
                },
            },
            snippets = { preset = 'luasnip' },
            cmdline = { enabled = false },
            sources = {
                default = function()
                    local sources = { 'lsp', 'buffer' }
                    local ok, node = pcall(vim.treesitter.get_node)

                    if ok and node then
                        if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            table.insert(sources, 'path')
                        end
                        if node:type() ~= 'string' then
                            table.insert(sources, 'snippets')
                        end
                    end

                    return sources
                end,
            },
            appearance = {
                kind_icons = require('icons').symbol_kinds,
            },
        },
    },
}
