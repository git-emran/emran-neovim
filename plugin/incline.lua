local add_on_event = require("vim-pack").add_on_event

add_on_event("BufReadPre", {
	{
		src = "craftzdog/solarized-osaka.nvim",
	},

	{
		src = "nvim-tree/nvim-web-devicons",
	},

	{
		src = "b0o/incline.nvim",

		opts = {
			window = {
				margin = {
					vertical = 0,
					horizontal = 1,
				},
			},

			hide = {
				cursorline = true,
			},

			render = function(props)
				local filename =
					vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

				if vim.bo[props.buf].modified then
					filename = "[+] " .. filename
				end

				local icon, color =
					require("nvim-web-devicons").get_icon_color(filename)

				return {
					{ icon, guifg = color },
					{ " " },
					{ filename },
				}
			end,
		},

		on_setup = function()
			local colors = require("solarized-osaka.colors").setup()

			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = {
							guibg = colors.magenta500,
							guifg = colors.base04,
						},

						InclineNormalNC = {
							guifg = colors.violet500,
							guibg = colors.base03,
						},
					},
				},
			})
		end,
	},
})