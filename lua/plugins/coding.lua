return {
	-- Surrounds code/word in parenthesis
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					visual = "<leader>s",
					visual_line = "<leader>S",
				},
			})
		end,
	},

	-- Git view
	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				blame = "<Leader>gb",
				browse = "<Leader>go",
			},
		},
	},

	-- Autopair tags and braces
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local conds = require("nvim-autopairs.conds")

			npairs.setup()

			-- Autoclosing angle-brackets (MariaSolOs style)
			npairs.add_rule(
				Rule("<", ">", {
					"-html",
					"-javascriptreact",
					"-typescriptreact",
				})
					:with_pair(conds.before_regex("%a+:?:?$", 3))
					:with_move(function(opts)
						return opts.char == ">"
					end)
			)
		end,
	},

	-- Code folding
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			foldKeymaps = {
				setup = false,
				hOnlyOpensOnFirstColumn = false,
			},
			pauseFoldsOnSearch = true,
			autoFold = {
				enabled = false,
			},
			foldText = {
				enabled = true,
				padding = 3,
				lineCount = {
					template = "%d lines",
					hlgroup = "Comment",
				},
			},
		},
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},

	-- Auto <tag> completion
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			opts = {
				enable_close = true,
				enable_rename = false,
				enable_close_on_slash = true,
			},
		},
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},

	-- Code commenting
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
