return {
	-- LazyDev plugin for Lua completions
	{
		"folke/lazydev.nvim",
		ft = "lua", -- load only for Lua files
		opts = {
			library = {
				-- Load luvit types when `vim.uv` is detected
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Blink completion source for LazyDev, Lua-only implementation
	{
		"saghen/blink.cmp",
		version = "v1.*",
		build = function()
			vim.fn.system({ "cargo", "build", "--release" })
		end,
		opts = {
			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},
			-- Use Lua fuzzy matcher (no warnings).
			-- Change to "prefer_rust" if you install Rust nightly.
			fuzzy = { implementation = "prefer_rust" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},

	{
		"j-hui/fidget.nvim",
		tag = "v1.6.1",
		lazy = false,
		opts = {
			progress = {
				suppress_on_insert = true,
				display = {
					done_icon = "✔",
					progress_icon = { pattern = "dots" },
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
