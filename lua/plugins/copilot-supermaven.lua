return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-y>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			ignore_filetypes = { cpp = true }, -- or { "cpp", }
			color = {
				suggestion_color = "#808080", -- Gray color
				cterm = 244,
			},
		})

		-- Set italic style for suggestions
		vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
			fg = "#808080",
			italic = true,
		})
	end,
}
