return {
	"stevearc/conform.nvim",
	event = { "bufreadpre", "bufnewfile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				python = { "ruff_format" },
				go = { "gofmt" },
				sh = { "shfmt" },
				-- add more filetypes here
			},
			format_on_save = {
				timeout_ms = 500, -- Increased timeout for robustness
				lsp_fallback = true,
			},
		})
	end,
}
