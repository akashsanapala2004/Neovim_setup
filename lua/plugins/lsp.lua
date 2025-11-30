return {
	-- tools
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"clangd",
				--"tailwindcss-language-server",
				--"typescript-language-server",
				--"css-lsp",
			})
		end,
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			--@type lspconfig.options
			servers = {
				--[=[
        cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},]=]
				--[=[
	      clangd = {
              cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "compile_commands.json",
              "compile_flags.txt",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true, noremap = true }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", function()
              require("telescope.builtin").lsp_definitions({ reuse_win = false })
            end, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          end,
        },]=]
				--
				clangd = {
					cmd = {
						"clangd",
						"--clang-tidy", -- enable clang-tidy diagnostics
						"--header-insertion=never", -- don't auto-insert headers
						"--completion-style=detailed", -- better completion info
						"--all-scopes-completion", -- completions from all scopes
					},
					-- capabilities = require("cmp_nvim_lsp").default_capabilities(),
					init_options = {
						clangdFileStatus = true, -- show file status in LSP
						inlayHints = {
							enabled = true, -- enable inlay hints
							parameterNames = "none", -- disables parameter names (so no format: in function signatures)
							typeHints = true, -- optional: you can leave type hints enabled (e.g., int, char*)
						},
					},
					on_attach = function(client, bufnr)
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.buf.inlay_hint(bufnr, true)
						end
					end,
				},
				--[=[
				rust_analyzer = {
					cmd = { "rust-analyzer" },
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = {
								command = "clippy", -- Use clippy for diagnostics
							},
							completion = {
								postfix = { enable = true }, -- Enable postfix completions
							},
							inlayHints = {
								enable = true, -- Enable inlay hints
								typeHints = true, -- Show type hints
								parameterHints = false, -- Disable parameter name hints (e.g. a: a, b: b)
								chainingHints = true, -- Show chaining hints (method calls)
							},
						},
					},
				},]=]
			},
			setup = {},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						-- DO NOT RESUSE WINDOW
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Goto Definition",
					has = "definition",
				},
			})
		end,
	},
}
