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
		-- LSP SERVER DEFINITIONS
		--------------------------------------------------------------------
		-- Each table here should ONLY describe the server.
		-- No Mason logic. No enable/start logic.
		local servers = {

			----------------------------------------------------------------
			-- Lua
			----------------------------------------------------------------
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								vim.fn.stdpath("config") .. "/lua",
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
						diagnostics = {
							globals = { "vim", "use" },
							disable = {
								"missing-fields",
								"incomplete-signature-doc",
							},
						},
						format = { enable = false },
						telemetry = { enable = false },
					},
				},
			},

			----------------------------------------------------------------
			-- Python
			----------------------------------------------------------------
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = { "W391" },
								maxLineLength = 100,
							},
							pydocstyle = {
								enabled = false,
							},
						},
					},
				},
			},

			ruff = {
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"ruff.toml",
					".ruff.toml",
					".git",
				},
			},

			----------------------------------------------------------------
			-- TypeScript / JavaScript
			----------------------------------------------------------------
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
						suggest = { completeFunctionCalls = true },
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
						suggest = { completeFunctionCalls = true },
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

			tailwindcss = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"vue",
				},
			},

			----------------------------------------------------------------
			-- Rust
			----------------------------------------------------------------
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
						inlayHints = { locationLinks = false },
					},
				},
			},

			----------------------------------------------------------------
			-- C / C++
			----------------------------------------------------------------
			clangd = {
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_dir = function(fname)
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

			----------------------------------------------------------------
			-- Web / Markup / Infra
			----------------------------------------------------------------
			html = { filetypes = { "html", "twig", "hbs" } },
			cssls = {
				settings = {
					css = { lint = { unknownAtRules = "ignore" } },
					scss = { lint = { unknownAtRules = "ignore" } },
					less = { lint = { unknownAtRules = "ignore" } },
				},
			},

			jsonls = {},
			yamlls = {},
			bashls = {},
			dockerls = {},
			docker_compose_language_service = {},
			terraformls = {},
			sqlls = {},
			graphql = {},

			----------------------------------------------------------------
			-- Writing / Docs
			----------------------------------------------------------------
			ltex = {
				filetypes = { "markdown", "tex", "bib" },
				flags = { debounce_text_changes = 500 },
				settings = {
					ltex = {
						enabled = { "markdown", "tex", "bib" },
						checkOnSave = true,
					},
				},
			},

			texlab = {},
			tinymist = {
				filetypes = { "typst" },
				settings = {
					formatterMode = "typstyle",
				},
			},

			----------------------------------------------------------------
			-- C#
			----------------------------------------------------------------
			roslyn = {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			},
		}

		--------------------------------------------------------------------
		-- MASON INSTALLATION
		--------------------------------------------------------------------
		local lsp_servers = vim.tbl_keys(servers)

		local mason_tools = {
			"stylua",
		}

		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.deepcopy(lsp_servers), mason_tools),
			run_on_start = true,
			auto_update = false,
		})

		--------------------------------------------------------------------
		-- REGISTER + ENABLE SERVERS
		--------------------------------------------------------------------
		for name, config in pairs(servers) do
			local cfg = vim.deepcopy(config)

			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

			vim.lsp.config(name, cfg)
			vim.lsp.enable(name)
		end
	end,
}
