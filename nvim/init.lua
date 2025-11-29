-- Settings

vim.g.mapleader = " "
vim.g.localmapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.signcolumn = "yes" -- Experiment for LSP signs and gitsigns
vim.opt.relativenumber = false
vim.opt.number = true -- Constantly switching trying diff combos of these two 

-- Keybinds

vim.keymap.set("n", " ", "<Nop>", { desc = "Ignore space", silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Autocmds

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- highlights yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	desc = "Remove hl search when enter Insert",
	callback = vim.schedule_wrap(function()
		vim.cmd.nohlsearch()
	end),
})

-- Function to suppress lsp exit code messages from garbage-day.nvim
local og_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:match("quit with exit code 1 and signal 0") then
    return
  end
  return og_notify(msg, level, opts)
end

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		-- {"plugin", config = function() end}

		-- Kanagawa theme (wave variant)
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("kanagawa").setup({
					theme = "wave",
					colors = {
						theme = {
							all = {
								ui = {
									bg_gutter = "none",
								},
							},
						},
					},
					overrides = function(colors)
						local theme = colors.theme
						return {
							NormalFloat = { bg = "none" },
							FloatBorder = { bg = "none" },
							FloatTitle = { bg = "none" },

							-- Save an hlgroup with dark background and dimmed foreground
							-- so that you can use it where your still want darker windows.
							-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
							NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

							-- Popular plugins that open floats will link to NormalFloat by default;
							-- set their background accordingly if you wish to keep them dark and borderless
							LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
							MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						}
					end,
				})
			end,
			build = function()
				vim.cmd("KanagawaCompile")
			end,
		},

		-- The cool little bar at the bottom
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lualine").setup({
					options = {
						theme = "kanagawa",
						section_separators = { left = "", right = "" }, -- section_separators = { left = "", right = "" },
						component_separators = { left = "", right = "" }, -- component_separators = { left = "", right = "" },
						icons_enabled = false, -- icons_enabled = true,
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { { "branch" }, { "filename", color = { bg = "#2a2a37" } } },-- color = { bg = "#2a2a37" } } }, 
						lualine_c = {},
						lualine_x = {}, -- lualine_x = {"encoding", "fileformat", "filetype"},
						lualine_y = { { "location" } }, -- color = { bg = "2a2a37" } } },
						lualine_z = { "filetype" },
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = { "filename" },
						lualine_x = { "location" },
						lualine_y = {},
						lualine_z = {},
					},
					extensions = { "nvim-tree", "quickfix" },
				})
			end,
		},

		-- The lines for indentation guiding cause my eyes get lost
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("ibl").setup()
			end,
			opts = {
				-- char = "▏",
				char = "│",
				highlight = { "Function", "Label" },
				filetype_exclude = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				show_trailing_blankline_indent = true,
				show_current_context = false,
			},
		},

		-- For the smear cursor effect
		{ "sphamba/smear-cursor.nvim", opts = {} },

		-- For my tmux workflow
		{
			"christoomey/vim-tmux-navigator",
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
				"TmuxNavigatorProcessList",
			},
			keys = {
				{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
				{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
				{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
				{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
				{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
			},
		},

		-- Help me jump around faster
        {

			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
            -- stylua: ignore
            keys = {
                { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
                { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
                { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
                { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },   -- powerful when combined with visual mode for selecting whole functions
                { "<C-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" }, -- use with /search to toggle flash labels on search
            },
		},

		-- So I remember my leader shortcuts
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = {
				-- your configuration comes here or leave it empty to use the default settings
			},
		},

		-- Edit directories in buffer
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			keys = {
				{ "-", "<cmd>Oil --float<cr>", desc = "Opens Oil in floating window" },
			},
			dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
			lazy = false,
			config = function()
				require("oil").setup({
					default_file_explorer = true,
					delete_to_trash = true,
					skip_confirm_for_simple_edits = true,
					view_options = {
						show_hidden = true,
					},
					win_options = {
						wrap = true,
					},
                    float = {
                        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    },
				})
			end,
		},

		-- Tree sitter (tbh i dont really know what it does)
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"c",
						"lua",
						"vim",
						"vimdoc",
						"rust",
						"cpp",
						"cmake",
						"html",
						"css",
						"java",
						"javascript",
						"javadoc",
						"json",
						"latex",
						"kotlin",
						"make",
						"markdown",
						"matlab",
						"python",
						"regex",
						"runescript",
						"rust",
						"sql",
						"tmux",
						"toml",
						"typescript",
						"zathurarc",
					},
				})
			end,
		},

		-- Auto pairing
		{
			"altermo/ultimate-autopair.nvim",
			event = { "InsertEnter", "CmdlineEnter" },
			branch = "v0.6", --recommended as each new version will have breaking changes
			opts = {},
		},

		-- Auto formatter
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						markdown = { "prettier" },
						python = { "isort", "black" },
						cpp = { "clang_format" },
					},
					format_on_save = {
						lsp_fallback = false, --true,
						async = false,
						timeout_ms = 1000,
					},
					formatters = {
						prettier = {
							args = {
								"--tab-width",
								"4",
							},
						},
						clang_format = {
							prepend_args = {
								-- Acts as a global .clang-format file
								"--style={BasedOnStyle: Google, IndentWidth: 4, SpaceAfterControlStatementKeyword: false, AllowShortFunctionsOnASingleLine: false, NamespaceIndentation: All, AllowShortIfStatementsOnASingleLine: false, AllowShortBlocksOnASingleLine: false, IndentAccessModifiers: true, AccessModifierOffset: -1, ColumnLimit: 120}",
							},
						},
					},
				})
			end,
		},

		-- fzf lua replacement for telescope
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			cmd = "FzfLua",
			opts = {
                winopts = {
                    preview = {
                        scrollbar = "none",
                        scrollchars = { "", "" },
                    },
                },
				oldfiles = {
					include_current_sessions = true,
				},
				fzf_colors = true,
			},
			keys = {
				{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files" },
				{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume search" },
				{ "<leader>fg", "<cmd>FzfLua grep<cr>", desc = "Search by grep" },
				{ "<leader>fl", "<cmd>FzfLua live_grep<cr>", desc = "Search by live grep" },
				{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
				{ "<leader>fh", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Fuzzily search in current buffer" },
				{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find opened buffers in current neovim instance", },
				{ "<leader>fG", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
				{ "<leader>fc", "<cmd>FzfLua files cwd='~/.config'<cr>", desc = "Open fuzzy find in config dir" },
			},
		},

		-- Autocompletions
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- Show function documentaiton above function
				signature = { enabled = true },
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = "default" },
				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = {
					documentation = { auto_show = false },
					accept = { auto_brackets = { enabled = false } },
				},

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},

		-- Automating disabling LSP to save explorer
		{
			"zeioth/garbage-day.nvim",
			dependencies = "neovim/nvim-lspconfig",
			event = "VeryLazy",
			opts = {
				-- Options/
			},
		},

		-- Main LSP configuration
		{
			"mason-org/mason.nvim",
			lazy = false,
			dependencies = {
				"mason-org/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"neovim/nvim-lspconfig",
				"saghen/blink.cmp",
			},

			keys = {
				{ "<leader>grn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
				{ "<leader>gra", vim.lsp.buf.code_action, desc = "[G]oto Code [A]ction" },
				{ "<leader>grr", "<cmd>FzfLua lsp_references<cr>", desc = "[G]oto [R]eferences" },
				{ "<leader>gri", "<cmd>FzfLua lsp_implementations<cr>", desc = "[G]oto [I]mplementations" },
				{ "<leader>grd", "<cmd>FzfLua lsp_definitions<cr>", desc = "[G]oto [D]efinitions" },
				{ "<leader>grD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
				{ "<leader>gO", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Open Document Symbols" },
				{ "<leader>gW", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Open Workspace Symbols" },
				{ "<leader>grt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "[G]oto [T]ype Definition" },
			},

			config = function()
				local mason = require("mason")
				local mason_lspconfig = require("mason-lspconfig")
				local mason_tool_installer = require("mason-tool-installer")

				local lspconfig = require("lspconfig")
				local blink_cmp = require("blink.cmp")
				local capabilities = blink_cmp.get_lsp_capabilities()

				mason.setup({
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				})

				mason_lspconfig.setup({
					ensure_installed = {
						"lua_ls",
						"basedpyright",
						"clangd",
						"cmake",
						"jdtls",
						"tinymist",
					},

					automatic_installation = true,
				})

				mason_tool_installer.setup({
					ensure_installed = {
						"prettier",
						"stylua",
						"isort",
						"clangd",
						"clang-format",
						"pylint",
						"prettypst",
					},
				})

				local servers = {
					lua_ls = {
						cmd = { "lua-language-server" },
						filetypes = { "lua" },
						root_markers = {
							".luarc.json",
							".luarc.jsonc",
							".luacheckrc",
							".stylua.toml",
							"stylua.toml",
							"selene.toml",
							"selene.yml",
							".git",
						},
						vim.lsp.config("lua_ls", {
							on_init = function(client)
								if client.workspace_folders then
									local path = client.workspace_folders[1].name
									if
										path ~= vim.fn.stdpath("config")
										and (
											vim.uv.fs_stat(path .. "/.luarc.json")
											or vim.uv.fs_stat(path .. "/.luarc.jsonc")
										)
									then
										return
									end
								end

								client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
									runtime = {
										-- Tell the language server which version of Lua you're using (most
										-- likely LuaJIT in the case of Neovim)
										version = "LuaJIT",
										-- Tell the language server how to find Lua modules same way as Neovim
										-- (see `:h lua-module-load`)
										path = {
											"lua/?.lua",
											"lua/?/init.lua",
										},
									},
									-- Make the server aware of Neovim runtime files
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME,
											-- Depending on the usage, you might want to add additional paths
											-- here.
											-- '${3rd}/luv/library'
											-- '${3rd}/busted/library'
										},
										-- Or pull in all of 'runtimepath'.
										-- NOTE: this is a lot slower and will cause issues when working on
										-- your own configuration.
										-- See https://github.com/neovim/nvim-lspconfig/issues/3189
										-- library = {
										--   vim.api.nvim_get_runtime_file('', true),
										-- }
									},
								})
							end,
							settings = {
								Lua = {},
							},
						}),
					},

					-- Kind of optional mostly to make sure clang-format as priority as a formatter
					clangd = {
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
					},

					-- Define custom configs for LSPs otherwise nvim-lspconfig lets us use predefined configs

					-- clangd = {}
					-- basedpyright = {}
				}

				mason_lspconfig.setup({
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}

							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							lspconfig[server_name].setup(server)
						end,
					},
				})

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(event)
						vim.keymap.set("n", "<leader>dp", function()
							vim.diagnostic.goto_prev()
						end, { desc = "Go to the [D]iagnostic [P]revious" })
						vim.keymap.set("n", "<leader>dn", function()
							vim.diagnostic.goto_next()
						end, { desc = "Go to the [D]iagnostic [N]ext" })
						vim.keymap.set("n", "<leader>do", function()
							vim.diagnostic.open_float()
						end, { desc = "Hover over Diagnostic and open menu" })
					end,
				})

				-- Diagnostic Config
				-- See :help vim.diagnostic.Opts
				vim.diagnostic.config({
					severity_sort = true,
					float = { border = "rounded", source = "if_many" },
					underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = false, -- Uncomment below block for signs in the gutter/signcolumn
					-- signs = vim.g.have_nerd_font and {
						-- text = {
							-- [vim.diagnostic.severity.ERROR] = "󰅚 ",
							-- [vim.diagnostic.severity.WARN] = "󰀪 ",
							-- [vim.diagnostic.severity.INFO] = "󰋽 ",
							-- [vim.diagnostic.severity.HINT] = "󰌶 ",
						-- },
					-- } or {},
					virtual_text = {
						source = "if_many",
						spacing = 2,
						format = function(diagnostic)
							local diagnostic_message = {
								[vim.diagnostic.severity.ERROR] = diagnostic.message,
								[vim.diagnostic.severity.WARN] = diagnostic.message,
								[vim.diagnostic.severity.INFO] = diagnostic.message,
								[vim.diagnostic.severity.HINT] = diagnostic.message,
							}
							return diagnostic_message[diagnostic.severity]
						end,
					},
				})
			end,
		},

		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = {
			colorscheme = { "kanagawa" },
		},
		-- automatically check for plugin updates
		checker = { enabled = true },
	},
})

vim.cmd("colorscheme kanagawa-wave")
