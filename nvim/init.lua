-- Settings

vim.g.mapleader = " "
vim.g.localmapleader = " "
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.autochdir = false
vim.opt.selection = "inclusive"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

vim.opt.clipboard = "unnamedplus"

vim.opt.signcolumn = "yes" -- Experiment for LSP signs and gitsigns
vim.opt.relativenumber = false
vim.opt.number = true -- Constantly switching trying diff combos of these two

-- Keybinds

local defaultOpts = { noremap = true, silent = true }
local termOpts = { silent = true }

vim.keymap.set("n", "<leader>pu", function()
	vim.pack.update(nil, { force = true })
end, { desc = "Run vim.pack.update()" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", defaultOpts)
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", defaultOpts)

vim.keymap.set("v", ">", ">gv", defaultOpts)
vim.keymap.set("v", "<", "<gv", defaultOpts)

vim.keymap.set("n", "n", "nzzzv", defaultOpts)
vim.keymap.set("n", "N", "Nzzzv", defaultOpts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", defaultOpts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", defaultOpts)

vim.keymap.set("n", "<C-h>", ":lua require('smart-splits').move_cursor_left()<cr>", { desc = "Go to Left split", silent = true })
vim.keymap.set("n", "<C-j>", ":lua require('smart-splits').move_cursor_down()<cr>", { desc = "Go to Lower split", silent = true })
vim.keymap.set("n", "<C-k>", ":lua require('smart-splits').move_cursor_up()<cr>", { desc = "Go to Upper split", silent = true })
vim.keymap.set("n", "<C-l>", ":lua require('smart-splits').move_cursor_right()<cr>", { desc = "Go to Right split", silent = true })

vim.keymap.set("n", "H", ":lua require('smart-splits').resize_left()<cr>", defaultOpts)
vim.keymap.set("n", "J", ":lua require('smart-splits').resize_down()<cr>", defaultOpts)
vim.keymap.set("n", "K", ":lua require('smart-splits').resize_up()<cr>", defaultOpts)
vim.keymap.set("n", "L", ":lua require('smart-splits').resize_right()<cr>", defaultOpts)

vim.keymap.set("n", "<leader>z", ":tab split<cr>", { desc = "Move split into standalone tab", noremap = true, silent = true })

-- Navigate terminal splits like regular splits
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", termOpts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", termOpts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", termOpts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", termOpts)
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", defaultOpts)

vim.keymap.set("n", "<leader>th", ":vertical leftabove term<cr>", { desc = "Create terminal to the left", silent = true })
vim.keymap.set("n", "<leader>tj", ":below term<cr>", { desc = "Create terminal below", silent = true })
vim.keymap.set("n", "<leader>tk", ":leftabove term<cr>", { desc = "Create terminal above", silent = true })
vim.keymap.set("n", "<leader>tl", ":vertical belowright term<cr>", { desc = "Create terminal to the right", silent = true })

vim.keymap.set("n", "<leader>sh", "<C-w>s<C-w>H", { desc = "Create split to the left", silent = true })
vim.keymap.set("n", "<leader>sj", "<C-w>s", { desc = "Create split below", silent = true })
vim.keymap.set("n", "<leader>sk", "<C-w>s<C-w>K", { desc = "Create split above", silent = true })
vim.keymap.set("n", "<leader>sl", "<C-w>v", { desc = "Create split to the right", silent = true })

vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Opens Oil in floating window" })

vim.keymap.set("n", "<leader>H", "<cmd>help!<cr>", { desc = "Show help page for whats under cursor" })

vim.keymap.set("o", "r", "<cmd>lua require('flash').remote()<cr>", { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "R", "<cmd>lua require('flash').treesitter_search()<cr>", { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", "<cmd>lua require('flash').toggle()<cr>", { desc = "Toggle Flash Search" })

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Search files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "Resume search" })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<cr>", { desc = "Search by live grep" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Look at currently open buffers" })
vim.keymap.set("n", "<leader>fG", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua files cwd='~/.config'<cr>", { desc = "Open fuzzy find in config dir" })

vim.keymap.set("n", "<leader>mm", "<cmd>Markview<cr>", { desc = "Toggle Markview" })
vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Toggle Markview splitview" })

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Open Git status dashboard" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Open diff split" })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Run git blame" })

-- Autocommands

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
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- Enter Insert Mode every time you enter a terminal, comment out if its too annoying
vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
	group = vim.api.nvim_create_augroup("terminal_insert", { clear = true }),
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

-- For regular text-writing and note-taking
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("text_writing", { clear = true }),
	pattern = { "markdown", "text", "plaintext", "gitcommit" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false

		vim.opt_local.breakindent = true -- idk actually know what these two do so feel free to comment them out if you dont like it
		vim.opt_local.linebreak = true
		vim.opt_local.wrap = true

		vim.opt_local.signcolumn = "no"
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_au"

		vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
		vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
	end,
})

-- Plugins

require("vim._core.ui2").enable({ enable = true })
vim.cmd("packadd nohlsearch")
vim.pack.add({
	-- { src = "https://www.github.com/rebelot/kanagawa.nvim" },
	{ src = "https://www.github.com/YashNaga/jojolion.nvim" },
	{ src = "https://www.github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://www.github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://www.github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://www.github.com/lukas-reineke/indent-blankline.nvim" }, -- version = "v2.20.8"
	{ src = "https://www.github.com/folke/which-key.nvim" }, -- Removable when you've learnt your keybinds
	{ src = "https://www.github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://www.github.com/folke/flash.nvim" },
	{ src = "https://www.github.com/stevearc/oil.nvim" },
	{ src = "https://www.github.com/tpope/vim-fugitive" },
	{ src = "https://www.github.com/mrjones2014/smart-splits.nvim" },
	{ src = "https://www.github.com/kylechui/nvim-surround" },
	{ src = "https://www.github.com/OXY2DEV/markview.nvim" },
	{ src = "https://www.github.com/ibhagwan/fzf-lua" },
	{ src = "https://www.github.com/stevearc/conform.nvim" },
	{
		src = "https://www.github.com/saghen/blink.cmp",
		version = vim.version.range("*"),
	},
	{ src = "https://www.github.com/neovim/nvim-lspconfig" },
	{ src = "https://www.github.com/mason-org/mason.nvim" },
	{ src = "https://www.github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://www.github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("jojolion").setup()

require("nvim-web-devicons").setup()

local ensureInstalled = {
	"c",
	"make",
	"cpp",
	"cmake",
	"vim",
	"lua",
	"java",
	"json",
	"markdown",
	"matlab",
	"python",
	"regex",
	"rust",
	"sql",
	"toml",
	"asm",
}
local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
	:filter(function(parser)
		return not vim.tbl_contains(alreadyInstalled, parser)
	end)
	:totable()
require("nvim-treesitter").install(parsersToInstall)

require("lualine").setup({
	options = {
		theme = require("jojolion.lualine"),
		section_separators = { left = "", right = "" }, -- section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" }, -- component_separators = { left = "", right = "" },
		icons_enabled = false, -- icons_enabled = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "branch" }, { "filename" } }, -- color = { bg = "#2a2a37" } } }, -- color = { bg = "#2a2a37" } } },
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
	extensions = { "oil", "quickfix", "mason" }, -- lowk not even sure what this does
})

require("ibl").setup({
	indent = { char = "▏", tab_char = "▏", highlight = { "Function", "Label" }, smart_indent_cap = false },
	exclude = {
		filetypes = {
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
	},
	whitespace = { remove_blankline_trail = true }, -- false
	scope = { enabled = false },
})

require("smear_cursor").setup({
	stiffness = 0.8,
	trailing_stiffness = 0.6,
	stiffness_insert_mode = 0.7,
	trailing_stiffness_insert_mode = 0.7,
	damping = 0.85,
	damping_insert_mode = 0.85,
	distance_stop_animating = 0.5,
})

require("oil").setup({
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
	win_options = {
		wrap = true,
	},
	float = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
})

require("smart-splits").setup()
require("nvim-surround").setup()

require("flash").setup({
	modes = {
		char = {
			enabled = true,
			jump_labels = true,
		},
	},
})

require("fzf-lua").setup({
	{ "borderless-full" },
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
})

require("blink.cmp").setup({
	signature = { enabled = false }, -- Set to true to get the popup that displays values when writing functions (C-k to toggle)
	keymap = { preset = "default" },
	completion = { documentation = { auto_show = false } }, -- set to true to automatically show documentation popup
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
})

-- Define custom configs optionally for lsps
local lspConfigs = {
	lua_ls = {
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
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
							-- '${3rd}/luv/library',
							-- '${3rd}/busted/library',
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = vim.api.nvim_get_runtime_file('', true),
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

	asm_lsp = {
		filetypes = { "asm", "s", "S" },
		single_file_support = true,
		settings = {},
	},
}

-- Lsp and tool installer
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- iterate through custom configs in lspConfigs or default to nvim-lspconfig
local lspconfig = require("lspconfig")
local blink_cmp = require("blink.cmp")
local capabilities = blink_cmp.get_lsp_capabilities()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"basedpyright",
		"clangd",
		"neocmake",
		"jdtls", -- I hate java
		"tinymist",
		"asm_lsp",
	},
	automatic_installation = true,
	auto_update = false,
	handlers = {
		function(server_name)
			local server = lspConfigs[server_name] or {}

			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			lspconfig[server_name].setup(server)
		end,
	},
})

-- automatic install of linters, formatters, etc
require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"isort",
		"clang-format",
		"pylint",
	},
	auto_update = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function make_opts(desc)
			return { buffer = ev.buf, silent = true, desc = desc }
		end

		local fzf = require("fzf-lua")

		-- set keybinds
		-- might need to add desc so whichkey can see it
		vim.keymap.set("n", "gR", function()
			fzf.lsp_references({ jump1 = true })
		end, make_opts("Show LSP references")) -- show definition, references

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, make_opts("Go to declaration")) -- go to declaration

		vim.keymap.set("n", "gd", function()
			fzf.lsp_definitions({ jump1 = true })
		end, make_opts("Show LSP definitons"))

		vim.keymap.set("n", "gi", function()
			fzf.lsp_implementations({ jump1 = true })
		end, make_opts("Show LSP implementations"))

		vim.keymap.set("n", "gt", function()
			fzf.lsp_typedefs({ jump1 = true })
		end, make_opts("Show LSP type definitions"))

		vim.keymap.set({ "n", "v" }, "<leader>ca", function()
			fzf.lsp_code_actions()
		end, make_opts("See available code actions"))

		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, make_opts("Smart rename")) -- smart rename

		vim.keymap.set("n", "<leader>lt", function()
			vim.diagnostic.enable(not vim.diagnostic.is_enabled())
		end, make_opts("Toggle diagnostics"))

		vim.keymap.set("n", "<leader>lb", function()
			fzf.diagnostics_document()
		end, make_opts("Show buffer diagnostics"))

		vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, make_opts("Show line diagnostics"))

		vim.keymap.set("n", "<leader>lp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, make_opts("Go to previous diagnostic"))

		vim.keymap.set("n", "<leader>ln", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, make_opts("Go to next diagnostic"))

		vim.keymap.set("n", "D", vim.lsp.buf.hover, make_opts("Show documentation for whats under cursor")) -- Double press D to enter hover as buffer
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = true,
	virtual_text = false,
	-- virtual_text = {
	-- 	source = "if_many",
	-- 	spacing = 2,
	-- },
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		markdown = {}, -- markdown = { "prettier" },
		c = { "clang_format" }, -- Took me two days to figure out its clang_format not clang-format
		cpp = { "clang_format" },
		lua = { "stylua" },
	},
	default_format_opts = {
		lsp_format = "never",
	},
	format_on_save = {
		lsp_format = "never",
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
		stylua = {
			prepend_args = {
				"--column-width",
				"160",
			},
		},
		clang_format = {
			-- Acts as a global .clang-format file
			prepend_args = function(self, ctx)
				local style_str = ""

				if vim.bo[ctx.buf].filetype == "c" then
					style_str =
						"--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Always, SpaceAfterControlStatementKeyword: false, AllowShortFunctionsOnASingleLine: false, NamespaceIndentation: All, AllowShortIfStatementsOnASingleLine: false, AllowShortBlocksOnASingleLine: false, IndentAccessModifiers: true, AccessModifierOffset: -1, ColumnLimit: 120, PointerAlignment: Right, DerivePointerAlignment: false}"
				else
					style_str = "--style=Google"
				end

				return {
					style_str,
					"--Wno-error=unknown",
				}
			end,
		},
	},
})

vim.cmd("colorscheme jojolion")
