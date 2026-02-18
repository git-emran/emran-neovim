-- lsp/ruff.lua
return {
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		".git",
	},
	settings = {
		["line-length"] = 100,
	},
}
