-- lazy.nvim
return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
		foldKeymaps = {
			setup = false,
			hOnlyOpensOnFirstColumn = false,
		},
		foldText = {
			enabled = true,
			padding = 3,
			lineCount = {
				template = "%d lines", -- `%d` is replaced with the number of folded lines
				hlgroup = "Comment",
			},
		},
	}, -- needed even when using default config

	-- recommended: disable vim's auto-folding
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
