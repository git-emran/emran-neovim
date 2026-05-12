local add_on_event = require('vim-pack').add_on_event

add_on_event('BufCreate', {
    {
        src = 'kdheepak/lazygit.nvim',
        opts = {
            cmd = {
                'LazyGit',
                'LazyGitConfig',
                'LazyGitCurrentFile',
                'LazyGitFilter',
                'LazyGitFilterCurrentFile',
            },
        },
        on_setup = function()
            require('telescope').load_extension 'lazygit'
            vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'opening lazygit' })
        end,
    },
})
