-- Add dotnet tools to PATH so Neovim can find dotnet global tools (like roslyn-language-server).
do
    local dotnet_tools = vim.fn.expand('~/.dotnet/tools')
    if dotnet_tools ~= '' and not vim.env.PATH:find(dotnet_tools, 1, true) then
        vim.env.PATH = dotnet_tools .. ':' .. vim.env.PATH
    end
end

local add = require('vim-pack').add

-- Load roslyn eagerly to allow proper startup and solution detection events
add({
    {
      src = 'seblyng/roslyn.nvim',
        on_setup = function()
            -- Configure roslyn LSP server options via Neovim's LSP config interface
            vim.lsp.config('roslyn', {
                cmd = { 'roslyn-language-server',
                     '--stdio' },
            })
        end,
    },
})
