-- lsp/clangd.lua
return {
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_dir = function(fname)
		return vim.fs.root(fname, {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git",
		})
	end,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
}
