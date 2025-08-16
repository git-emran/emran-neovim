return {
	-- Bufferline: Tabs
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"moll/vim-bbye",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
					numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
					close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
					buffer_close_icon = "✗",
					close_icon = "✗",
					path_components = 1, -- Show only the file name without the directory
					modified_icon = "●",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 30,
					max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
					tab_size = 21,
					diagnostics = false,
					diagnostics_update_in_insert = false,
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = false,
					show_close_icon = true,
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					separator_style = { "│", "│" }, -- | "thick" | "thin" | { 'any', 'any' },
					enforce_regular_tabs = true,
					always_show_bufferline = true,
					show_tab_indicators = true,
					indicator = {
						-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
						style = "none", -- Options: 'icon', 'underline', 'none'
					},
					icon_pinned = "󰐃",
					minimum_padding = 1,
					maximum_padding = 5,
					maximum_length = 15,
					sort_by = "insert_at_end",
				},
				highlights = {
					separator = {
						fg = "#434C5E",
					},
					buffer_selected = {
						bold = true,
						italic = false,
					},
					-- separator_selected = {},
					-- tab_selected = {},
					-- background = {},
					-- indicator_selected = {},
					-- fill = {},
				},
			})
		end,
	},

	-- Incline File view

	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- Surround : Wraps codes around parenthesis and quotes
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				keymaps = {
					visual = "<leader>s",
					visual_line = "<leader>S",
				},
			})
		end,
	},

	-- Toggle-term : Opens the terminal
	{
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
			-- Lazygit integration
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

			vim.keymap.set("n", "<leader>gg", function()
				lazygit:toggle()
			end, { desc = "Open LazyGit" })
		end,
	},

	-- Code indent

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
				show_exact_scope = false,
			},
			exclude = {
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
				},
			},
		},
	},

	-- Quick search text in current buffer with s and S
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- Zen mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	-- Markdown render
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		---@module 'render-markdown'
		opts = {},
	},
}
