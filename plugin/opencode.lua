local add_on_event = require("vim-pack").add_on_event

add_on_event("BufReadPre", {
	-- dependencies
	{
		src = "nvim-lua/plenary.nvim",
	},

	{
		src = "meanderingprogrammer/render-markdown.nvim",

		ft = {
			"markdown",
			"avante",
			"copilot-chat",
			"opencode_output",
		},

		opts = {
			anti_conceal = {
				enabled = false,
			},

			file_types = {
				"markdown",
				"opencode_output",
			},
		},
	},

	{
		src = "saghen/blink.cmp",
	},

	{
		src = "nvim-telescope/telescope.nvim",
	},

	-- main plugin
	{
		src = "sudo-tee/opencode.nvim",

		opts = {
			preferred_picker = "telescope",
			preferred_completion = "blink",
			default_mode = "build",

			display_cost = true,
			display_model = true,

			default_model = "opencode/north-mini-code-free",
		},
	},
})
