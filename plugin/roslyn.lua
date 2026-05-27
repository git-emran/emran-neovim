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
        opts = {
            broad_search = true,
            -- Use the dotnet tool install of Roslyn if available (cmd: `roslyn-language-server`).
            -- Also wire Razor co-hosting args from the same install to avoid extension warnings.
            extensions = {
                razor = {
                    enabled = true,
                    config = function()
                        local server_exe = vim.fn.exepath('roslyn-language-server')
                        if server_exe == '' then
                            return { path = nil }
                        end

                        local real_exe = vim.uv.fs_realpath(server_exe) or server_exe
                        local base = vim.fs.dirname(real_exe)

                        return {
                            path = vim.fs.joinpath(base, 'Microsoft.VisualStudioCode.RazorExtension.dll'),
                            args = {
                                '--razorSourceGenerator='
                                    .. vim.fs.joinpath(base, 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
                                '--razorDesignTimePath='
                                    .. vim.fs.joinpath(base, 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets'),
                            },
                        }
                    end,
                },
            },
        },
        on_setup = function()
            -- Configure roslyn LSP server options via Neovim's LSP config interface
            vim.lsp.config('roslyn', {
                cmd = { 'roslyn-language-server', '--logLevel=Information', '--extensionLogDirectory='
                    .. vim.fn.expand('~/.local/state/nvim'), '--stdio' },
                settings = {
                    ['csharp|inlay_hints'] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                    },
                    ['csharp|code_lens'] = {
                        dotnet_enable_references_code_lens = true,
                        dotnet_enable_tests_code_lens = true,
                    },
                },
            })
        end,
    },
})
