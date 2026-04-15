return {
	"akinsho/toggleterm.nvim",
	version = "*",
	init = function()
		local lazygit_term

		_G._toggleterm_toggle_lazygit = function()
			local Terminal = require("toggleterm.terminal").Terminal
			if not lazygit_term then
				lazygit_term = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
			end
			lazygit_term:toggle()
		end
	end,
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
		{
			"<leader>gg",
			function()
				_G._toggleterm_toggle_lazygit()
			end,
			desc = "Open LazyGit",
		},
	},
	config = function()
		require("toggleterm").setup({
			size = 20,
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float", -- "vertical" | "float" | "tab"
			close_on_exit = true,
			shell = vim.o.shell,
			dir = "git_dir",
		})
	end,
}
