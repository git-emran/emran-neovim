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
			opts = {},
		},
		-- mason-tool-installer:
		-- - Installs LSPs, linters, formatters, etc. by their Mason package name.
		-- - We use it to ensure all desired tools are present.
		-- - The `ensure_installed` list works with mason-lspconfig to resolve LSP names like "lua_ls".
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {},
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
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Add the current config directory to workspace
								vim.fn.stdpath("config") .. "/lua",
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
						diagnostics = {
							globals = { "vim", "use" }, -- Add commonly used globals
							disable = { "missing-fields", "incomplete-signature-doc" },
						},
						format = {
							enable = false, -- We're using stylua for formatting
						},
						telemetry = {
							enable = false, -- Disable telemetry
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
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
					javascript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
			},
			angularls = {
				cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
				filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
				root_dir = function(fname)
					-- Look upward for one of these files
					return vim.fs.root(fname, { "angular.json", "project.json", ".git" })
				end,
				on_new_config = function(new_config, new_root_dir)
					new_config.cmd = {
						"ngserver",
						"--stdio",
						"--tsProbeLocations",
						new_root_dir,
						"--ngProbeLocations",
						new_root_dir,
					}
				end,
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				root_dir = function(fname)
					-- Search upward for one of these files
					return vim.fs.root(fname, {
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git",
					})
				end,
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
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
			html = { filetypes = { "html", "twig", "hbs" } },
		}

		-- Separate LSP servers from tools for Mason
		local lsp_servers = vim.tbl_keys(servers or {})
		local mason_tools = {
			"stylua", -- Used to format Lua code (this is a formatter, not an LSP)
		}

		-- Install LSP servers and tools separately
		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.deepcopy(lsp_servers), mason_tools),
			auto_update = false,
			run_on_start = true,
		})

		-- Configure and enable each LSP server
		for server, cfg in pairs(servers) do
			-- Create a deep copy of the config to avoid mutating the original
			local server_config = vim.deepcopy(cfg)

			-- Add capabilities to the config copy
			server_config.capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

			-- Configure the server (this registers the configuration)
			vim.lsp.config(server, server_config)

			-- Enable the server (this starts it when appropriate)
			vim.lsp.enable(server)
		end
	end,
}
