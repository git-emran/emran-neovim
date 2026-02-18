-- ~/.config/nvim/lua/plugins/typst.lua
local function create_tinymist_command(command_name, client, bufnr)
	local cmd_display = command_name:match("tinymist%.export(%w+)")
	local function run_tinymist_command()
		local arguments = { vim.api.nvim_buf_get_name(bufnr) }
		return client:exec_cmd({
			title = "Export " .. cmd_display,
			command = command_name,
			arguments = arguments,
		}, { bufnr = bufnr })
	end
	return run_tinymist_command, ("Export" .. cmd_display), ("Export to " .. cmd_display)
end

return {
	-- TinyMist LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- The show_deprecations option is still necessary here, as other LSP configurations might
			-- still be handled by nvim-lspconfig's internal logic.
			show_deprecations = false,
		},
		config = function()
			-- Define the tinymist configuration outside of the `opts` table
			local tinymist_config = {
				cmd = { "tinymist" },
				filetypes = { "typst" },
				settings = { formatterMode = "typstyle" },
				on_attach = function(client, bufnr)
					local export_commands = {
						"tinymist.exportSvg",
						"tinymist.exportPng",
						"tinymist.exportPdf",
						"tinymist.exportHtml",
						"tinymist.exportMarkdown",
					}
					for _, command in ipairs(export_commands) do
						local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
						vim.api.nvim_buf_create_user_command(bufnr, cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
					end
				end,
			}

			-- Use the modern, recommended API to configure and enable the server
			vim.lsp.config["tinymist"] = tinymist_config
			vim.lsp.enable("tinymist")
		end,
	},

	-- Typst Preview
	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		version = "1.*",
		opts = {
			dependencies_bin = {
				["tinymist"] = "tinymist", -- force system binary
				["websocat"] = "websocat",
			},
		},
	},
}
