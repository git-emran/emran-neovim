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
		config = function(_, opts)
			require("lazydev").setup(opts)

			local ok_cmp, cmp = pcall(require, "cmp")
			if not ok_cmp then
				return
			end

			local config = cmp.get_config() or {}
			local sources = config.sources or {}
			cmp.setup.filetype("lua", {
				sources = cmp.config.sources({
					{ name = "lazydev", group_index = 0 },
				}, sources),
			})
		end,
	},
}
