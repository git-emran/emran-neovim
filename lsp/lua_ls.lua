-- lsp/lua_ls.lua
return {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config") .. "/lua",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			diagnostics = {
				globals = { "vim", "use" },
				disable = {
					"missing-fields",
					"incomplete-signature-doc",
				},
			},
			format = { enable = false },
			telemetry = { enable = false },
		},
	},
}
