return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Enable the dashboard
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "echo '🎨 Welcome to Neovim!' && date",
					height = 5,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					desc = "Browse Repo",
					padding = 1,
					key = "b",
					action = function()
						if Snacks.git.get_root() then
							Snacks.gitbrowse()
						else
							vim.notify("Not in a git repository", vim.log.levels.WARN)
						end
					end,
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Notifications",
							cmd = "gh api notifications --template '{{range .}}{{.subject.title}} ({{.repository.name}}){{\"\\n\"}}{{end}}' | head -5 2>/dev/null || echo 'No GitHub CLI or notifications'",
							action = function()
								vim.ui.open("https://github.com/notifications")
							end,
							key = "n",
							icon = " ",
							height = 5,
							enabled = true,
						},
						{
							title = "Open Issues",
							cmd = in_git and "gh issue list -L 3 2>/dev/null || echo 'No issues or not a GitHub repo'"
								or "echo 'Not in a git repository'",
							key = "i",
							action = function()
								if in_git then
									vim.fn.jobstart("gh issue list --web", { detach = true })
								else
									vim.notify("Not in a git repository", vim.log.levels.WARN)
								end
							end,
							icon = " ",
							height = 7,
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = in_git and "gh pr list -L 3 2>/dev/null || echo 'No PRs or not a GitHub repo'"
								or "echo 'Not in a git repository'",
							key = "P",
							action = function()
								if in_git then
									vim.fn.jobstart("gh pr list --web", { detach = true })
								else
									vim.notify("Not in a git repository", vim.log.levels.WARN)
								end
							end,
							height = 7,
						},
						{
							icon = " ",
							title = "Git Status",
							cmd = in_git and "git --no-pager diff --stat -B -M -C 2>/dev/null || echo 'No changes'"
								or "echo 'Not in a git repository'",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = true, -- Always show sections but with appropriate messages
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},
		-- You can add other snacks configurations here
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.dashboard()
			end,
			desc = "Dashboard",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for easier access
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				if vim.lsp.inlay_hint then
					Snacks.toggle.inlay_hints():map("<leader>uh")
				end
			end,
		})
	end,
}
