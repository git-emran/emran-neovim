return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		-- Theme state
		local bg_transparent = true

		-- Setup Rose Pine with your custom configuration
		local function setup_rose_pine()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, dawn
				dark_variant = "main", -- main, moon, dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},

				styles = {
					bold = true,
					italic = false,
					transparency = bg_transparent,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					headings = {
						h1 = "iris",
						h2 = "foam",
						h3 = "rose",
						h4 = "gold",
						h5 = "pine",
						h6 = "foam",
					},
				},

				palette = {},
				highlight_groups = {
					-- Enable italics for comments and conditionals only
					Comment = { italic = true },
					Conditional = { italic = true },
					-- Treesitter equivalents
					["@comment"] = { italic = true },
					["@conditional"] = { italic = true },
					["@keyword.conditional"] = { italic = true },
				},

				before_highlight = function(group, highlight, palette)
					-- Disable all undercurls
					-- if highlight.undercurl then
					--     highlight.undercurl = false
					-- end
					--
					-- Change palette colours
					-- if highlight.fg == palette.pine then
					--     highlight.fg = palette.foam
					-- end
				end,
			})

			vim.cmd.colorscheme("rose-pine")
		end

		setup_rose_pine()

		-- Toggle transparency with <leader>bg
		local function toggle_transparency()
			bg_transparent = not bg_transparent
			setup_rose_pine()
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
	end,
}
