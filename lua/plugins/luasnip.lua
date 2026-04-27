return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		config = function()
			local luasnip = require("luasnip")
			-- Load VSCode snippets from the snippets/ directory
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
			-- Also load friendly-snippets if installed
			require("luasnip.loaders.from_vscode").lazy_load()

			luasnip.config.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})
		end,
		config = function(_, opts)
			local luasnip = require("luasnip")

			---@diagnostic disable: undefined-field
			luasnip.setup(opts)

			-- Load my custom snippets:
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})

			-- Use <C-c> to select a choice in a snippet.
			vim.keymap.set({ "i", "s" }, "<C-c>", function()
				if luasnip.choice_active() then
					require("luasnip.extras.select_choice")()
				end
			end, { desc = "Select choice" })
			---@diagnostic enable: undefined-field
		end,
	},
}
