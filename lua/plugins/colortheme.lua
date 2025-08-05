return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		-- Theme state
		local bg_transparent = false

		-- Setup Catppuccin with your custom configuration
		local function setup_catppuccin()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = bg_transparent,
				float = {
					transparent = false,
					solid = false,
				},
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				auto_integrations = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end

		setup_catppuccin()

		-- Toggle transparency with <leader>bg
		local function toggle_transparency()
			bg_transparent = not bg_transparent
			setup_catppuccin()
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
	end,
}
