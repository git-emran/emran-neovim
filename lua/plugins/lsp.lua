return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		-- mason-lspconfig:
		-- - Bridges the gap between LSP config names (e.g. "lua_ls") and actual Mason package names (e.g. "lua-language-server").
		-- - Used here only to allow specifying language servers by their LSP name (like "lua_ls") in `ensure_installed`.
		-- - It does not auto-configure servers — we use vim.lsp.config() + vim.lsp.enable() explicitly for full control.
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				automatic_enable = true,
			},
		},
		-- mason-tool-installer:
		-- - Installs LSPs, linters, formatters, etc. by their Mason package name.
		-- - We use it to ensure all desired tools are present.
		-- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
		},

		-- Allows extra capabilities provided by nvim-cmp
	},
	config = function()
		-- LSP servers and clients are able to communicate to each other what features they support.
		-- By default, Neovim doesn't support everything that is in the LSP specification.
		-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		--
		-- Add any additional override configuration in the following tables. Available keys are:
		-- - cmd (table): Override the default command used to start the server
		-- - filetypes (table): Override the default list of associated filetypes for the server
		-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		-- - settings (table): Override the default settings passed when initializing the server.
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						format = {
							enable = false,
						},
					},
				},
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			},
			vtsls = {
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
					javascript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			},
			angularls = {
				cmd = { "angular-language-server", "--stdio" },
				filetypes = { "typescript", "html" },
				root_dir = require("lspconfig.util").root_pattern("angular.json", "package.json", ".git"),
				capabilities = capabilities,
				init_options = {
					-- Optional: specify TypeScript path if needed
					tsserver_path = "typescript/lib/tsserverlibrary.js",
					-- Helps LSP find Angular modules
					ng_probe_locations = {},
				},
			},
			clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git")(
						fname
					)
				end,
				capabilities = capabilities,
			},
			-- basedpyright = {
			--    -- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
			--    settings = {
			--      basedpyright = {
			--        disableOrganizeImports = true, -- Using Ruff's import organizer
			--        disableLanguageServices = false,
			--        analysis = {
			--          ignore = { '*' },             -- Ignore all files for analysis to exclusively use Ruff for linting
			--          typeCheckingMode = 'off',
			--          diagnosticMode = 'openFilesOnly', -- Only analyze open files
			--          useLibraryCodeForTypes = true,
			--          autoImportCompletions = true,       -- whether pyright offers auto-import completions
			--        },
			--      },
			--    },
			-- },
			ruff = {},
			jsonls = {},
			sqlls = {},
			terraformls = {},
			yamlls = {},
			bashls = {},
			dockerls = {},
			tailwindcss = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"vue",
				},
			},
			graphql = {},
			cssls = {
				settings = {
					css = { lint = { unknownAtRules = "ignore" } },
					scss = { lint = { unknownAtRules = "ignore" } },
					less = { lint = { unknownAtRules = "ignore" } },
				},
			},
			ltex = {
				settings = {
					ltex = {
						checkFrequency = "save",
					},
				},
			},
			tinymist = {
				cmd = { "tinymist" },
				filetypes = { "typst" },
				settings = {
					formatterMode = "typstyle",
				},
			},
			texlab = {},
			jdtls = {},
			docker_compose_language_service = {},
			-- tailwindcss = {},
			-- graphql = {},
			html = { filetypes = { "html", "twig", "hbs" } },
		}

		-- Ensure the servers and tools above are installed
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for server, cfg in pairs(servers) do
			-- For each LSP server (cfg), we merge:
			-- 1. A fresh empty table (to avoid mutating capabilities globally)
			-- 2. Your capabilities object with Neovim + cmp features
			-- 3. Any server-specific cfg.capabilities if defined in `servers`
			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

			vim.lsp.config(server, cfg)
			vim.lsp.enable(server)
		end
	end,
}
