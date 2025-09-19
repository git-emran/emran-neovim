return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim", "jayp0521/mason-null-ls.nvim" },
	config = function()
		local ok, none_ls = pcall(require, "none-ls")
		if not ok then
			return
		end
		local extras = require("none-ls-extras")

		require("mason-null-ls").setup({
			ensure_installed = { "prettier", "eslint_d", "stylua", "shfmt", "ruff" },
			automatic_installation = true,
		})

		none_ls.setup({
			sources = {
				extras.formatting.prettier,
				extras.formatting.stylua,
				extras.formatting.shfmt,
				extras.diagnostics.ruff,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
