return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			-- Ensure routes table exists
			opts.routes = opts.routes or {}

			-- Skip "No information available" notifications
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			-- Track focus state to conditionally modify notifications
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})

			-- When Neovim is unfocused, send notifications differently
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			-- Customize the :Noice command's message history window
			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			-- Setup markdown filetype integration with noice text markdown keys
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			-- Enable LSP documentation window border preset
			opts.presets = opts.presets or {}
			opts.presets.lsp_doc_border = true
		end,
	},
}
