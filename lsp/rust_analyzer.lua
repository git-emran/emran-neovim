-- lsp/rust_analyzer.lua
return {
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
			inlayHints = { locationLinks = false },
		},
	},
}
