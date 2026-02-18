-- lsp/ltex.lua
return {
	filetypes = { "markdown", "tex", "bib" },
	flags = { debounce_text_changes = 500 },
	settings = {
		ltex = {
			enabled = { "markdown", "tex", "bib" },
			checkOnSave = true,
			checkFrequency = "save",
		},
	},
}
