return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<C-\>]], -- Ctrl + \
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
