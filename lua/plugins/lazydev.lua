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
		opts = {
			-- Force Lua fuzzy matching (no Rust, no warnings)
			fuzzy = { implementation = "lua" },

			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- top priority
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
