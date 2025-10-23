return {
	"stevearc/conform.nvim",
	event = { "bufreadpre", "bufnewfile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				lua = { "stylua" },
				javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				python = { "ruff_format" },
				go = { name = "gopls", timeout_ms = 500, lsp_format = "prefer" },
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
