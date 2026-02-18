-- lsp/pylsp.lua
return {
	settings = {
		pylsp = {
			configurationSources = {},
			plugins = {
				pycodestyle = {
					enabled = true,
					ignore = { "W391" },
					maxLineLength = 100,
					["max-line-length"] = 100,
				},
				flake8 = { enabled = false },
				pydocstyle = { enabled = false },
				mccabe = { enabled = false },
				pyflakes = { enabled = false },
				pylint = { enabled = false },
			},
		},
	},
}
