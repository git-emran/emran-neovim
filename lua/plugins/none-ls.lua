return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		local code_actions = null_ls.builtins.code_actions -- to setup code actions

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- Shell formatter
				"checkmake", -- linter for Makefiles
				-- Go tools
				"gofmt", -- Go formatter (or use goimports for imports handling)
				"goimports", -- Go formatter with import management
				"golangci-lint", -- Go linter (comprehensive)
				"gomodifytags", -- Go struct tag modifier
				"impl", -- Go interface implementation generator
				-- 'stylua', -- lua formatter; Already installed via Mason
				-- 'ruff', -- Python linter and formatter; Already installed via Mason
			},
			automatic_installation = true,
		})

		local sources = {
			-- General
			diagnostics.checkmake,
			formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),

			-- Go support
			formatting.goimports, -- Use goimports instead of gofmt for better import handling
			-- Alternative: formatting.gofmt, -- Basic Go formatting
			diagnostics.golangci_lint, -- Comprehensive Go linting
			code_actions.gomodifytags, -- Add/remove struct tags
			code_actions.impl, -- Generate interface implementations
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
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
