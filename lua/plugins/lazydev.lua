return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional cmp completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		-- build = "cargo build --release", -- Use this if you have cargo installed and want to build from source
		-- For pre-built binaries (which checkhealth says you support):
		build = "npx lucide-cross-init", -- This is a common pattern for blink, but often 'version = "*"' is enough to trigger binary download in lazy.nvim
		opts = {
			fuzzy = { implementation = "lua" },
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "path" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	-- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
