-- lua/plugins/lsp.lua
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		{ "mason-org/mason.nvim", config = true },

		-- Name resolution only (lua_ls -> lua-language-server)
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				handlers = {}, -- we do not auto-setup servers
				auto_update = false,
			},
		},

		-- Installs LSPs + tools
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

		-- LSP status
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},

		-- Capabilities
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		--------------------------------------------------------------------
		-- Diagnostics
		--------------------------------------------------------------------
		vim.diagnostic.config({
			update_in_insert = false,
		})

		--------------------------------------------------------------------
		-- Capabilities
		--------------------------------------------------------------------
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		--------------------------------------------------------------------
		-- LOAD SERVERS FROM lsp/*.lua
		--------------------------------------------------------------------
		-- We scan ~/.config/nvim/lsp/*.lua and load each file.
		-- Each file returns a config table valid for vim.lsp.config[name].
		local lsp_plugins_path = vim.fn.stdpath("config") .. "/lsp"
		local handle = vim.loop.fs_scandir(lsp_plugins_path)

		local servers = {}

		if handle then
			while true do
				local name, type = vim.loop.fs_scandir_next(handle)
				if not name then
					break
				end

				if type == "file" and name:match("%.lua$") then
					local server_name = name:gsub("%.lua$", "")
					table.insert(servers, server_name)
				end
			end
		end

		--------------------------------------------------------------------
		-- MASON INSTALLATION
		--------------------------------------------------------------------
		local mason_tools = {
			"stylua",
		}

		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.deepcopy(servers), mason_tools),
			run_on_start = true,
			auto_update = false,
		})

		--------------------------------------------------------------------
		-- REGISTER + ENABLE SERVERS
		--------------------------------------------------------------------
		for _, name in ipairs(servers) do
			-- Correctly require the module based on runtime path
			-- But since we are creating them in ~/.config/nvim/lsp,
			-- we cannot easily 'require' them if "lsp" is not in Lua path as a module root,
			-- unless ~/.config/nvim/lua/lsp existed.
			-- ~/.config/nvim is in runtime path, but 'require' looks for lua/ directory.
			-- So `require("lsp.pylsp")` would look for `lua/lsp/pylsp.lua`.
			-- But our files are in `lsp/pylsp.lua` (top level config dir).
			-- So we use `dofile` on the absolute path.

			local config_path = lsp_plugins_path .. "/" .. name .. ".lua"
			local status, config = pcall(dofile, config_path)

			if not status then
				vim.notify("Failed to load LSP config for " .. name .. ": " .. config, vim.log.levels.ERROR)
			else
				local cfg = vim.deepcopy(config)
				cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

				vim.lsp.config[name] = cfg
				vim.lsp.enable(name)
			end
		end
	end,
}
