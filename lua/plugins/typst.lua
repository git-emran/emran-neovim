return {
	-- Typst Preview
	{
		"chomosuke/typst-preview.nvim",
		ft = { "typst" },
		version = "1.*",
		init = function()
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

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Typst: add TinyMist export commands",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "tinymist" then
						return
					end

					local bufnr = args.buf
					if vim.bo[bufnr].filetype ~= "typst" then
						return
					end

					local export_commands = {
						"tinymist.exportSvg",
						"tinymist.exportPng",
						"tinymist.exportPdf",
						"tinymist.exportHtml",
						"tinymist.exportMarkdown",
					}

					for _, command in ipairs(export_commands) do
						local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
						pcall(vim.api.nvim_buf_del_user_command, bufnr, cmd_name)
						vim.api.nvim_buf_create_user_command(bufnr, cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
					end
				end,
			})
		end,
		opts = {
			dependencies_bin = {
				["tinymist"] = "tinymist", -- force system binary
				["websocat"] = "websocat",
			},
		},
	},
}
