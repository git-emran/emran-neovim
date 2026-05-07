return {
    'sudo-tee/opencode.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'meanderingprogrammer/render-markdown.nvim',
            opts = {
                anti_conceal = { enabled = false },
                file_types = { 'markdown', 'opencode_output' },
            },
            ft = { 'markdown', 'avante', 'copilot-chat', 'opencode_output' },
        },
        -- optional, for file mentions and commands completion, pick only one
        'saghen/blink.cmp',
        -- 'hrsh7th/nvim-cmp',

        -- optional, for file mentions picker, pick only one
        -- 'folke/snacks.nvim',
        'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        -- 'nvim_mini/mini.nvim',
    },

    config = function()
        require('opencode').setup {
            preferred_picker = 'telescope',
            preferred_completion = 'blink',
            default_mode = 'build',
            display_cost = true,
            display_model = true,
            default_model = 'openrouter/qwen/qwen3-coder-flash',
        }
    end,
}
