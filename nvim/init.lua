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
vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.selection = "inclusive"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

vim.opt.signcolumn = "yes" -- Experiment for LSP signs and gitsigns
vim.opt.relativenumber = false
vim.opt.number = true -- Constantly switching trying diff combos of these two

-- Neovide specific
if vim.g.neovide then
	vim.o.guifont = "CaskaydiaCove NF:h14"
	vim.g.neovide_progress_bar_enabled = false

	vim.keymap.set("n", "<S-CR>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end, { desc = "Toggle neovide fullscreen" })

	if vim.fn.has("win32") == 1 then
		if vim.fn.executable("pwsh") == 1 then
			vim.opt.shell = "pwsh" -- Check for powershell 7
		else
			vim.opt.shell = "powershell" -- Fall back to disgusting other powershell
		end
		vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy Bypass -Command"
		vim.opt.shellxquote = ""
	end
end

-- Keybinds
-- local silent = { silent = true }

vim.keymap.set("n", "<leader>pu", function() vim.pack.update(nil, { force = true }) end, { desc = "Run vim.pack.update()" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Bottom Split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Top Split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Split" })

local function smart_resize(direction, amount)
	amount = amount or 3
	local current_win = vim.fn.winnr()

	if direction == "left" or direction == "right" then
		-- check the right to see if we're on the edge of screen
		vim.cmd("wincmd l")
		local has_right = vim.fn.winnr() ~= current_win
		vim.cmd(current_win .. "wincmd w") -- snap back

		if direction == "left" then
			vim.cmd("vertical resize " .. (has_right and "-" or "+") .. amount)
		else -- right
			vim.cmd("vertical resize " .. (has_right and "+" or "-") .. amount)
		end
	elseif direction == "up" or direction == "down" then
		-- check down to see if we're on the edge of screen
		vim.cmd("wincmd j")
		local has_below = vim.fn.winnr() ~= current_win
		vim.cmd(current_win .. "wincmd w") -- Snap back safely

		if direction == "up" then
			vim.cmd("resize " .. (has_below and "-" or "+") .. amount)
		else -- down
			vim.cmd("resize " .. (has_below and "+" or "-") .. amount)
		end
	end
end

vim.keymap.set("n", "H", function() smart_resize("left") end)
vim.keymap.set("n", "J", function() smart_resize("down") end)
vim.keymap.set("n", "K", function() smart_resize("up") end)
vim.keymap.set("n", "L", function() smart_resize("right") end)

vim.keymap.set("n", "<leader>z", ":tab split<cr>", { desc = "Move split into standalone tab", noremap = true, silent = true })

-- Navigate terminal splits like regular splits
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

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

vim.keymap.set("n", "<leader>tp", "<cmd>:TypstPreviewToggle<cr>", { desc = "Toggle typst preview" })

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Search files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "Resume search" })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua live_grep<cr>", { desc = "Search by live grep" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua lgrep_curbuf<cr>", { desc = "Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Look at currently open buffers" })
vim.keymap.set("n", "<leader>fG", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua files cwd='~/.config'<cr>", { desc = "Open fuzzy find in config dir" })

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git: Open Fugitive status dashboard" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git: Open diff split" })
-- vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git: Run blame history" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Git: Toggle current line blame" })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git: Preview current chunk float" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Git: Reset surgical chunk edits" })
vim.keymap.set("n", "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Git: Add/Stage surgical chunk edits" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Git: Jump to next edited chunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Git: Jump to prior edited chunk" })

vim.keymap.set("n", "<leader>d", function()
	local exec = vim.fn.input("Path to executable: ", "./")
	if exec ~= "" then vim.cmd("vsplit | term gdb -tui " .. exec) end
end, { desc = "Debug: Open GDB TUI in Vertical Split" })

-- Autocommands

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then vim.cmd('normal! g`"zz') end
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
	callback = function() vim.opt_local.formatoptions:remove({ "c", "r", "o" }) end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- Enter Insert Mode every time you enter a terminal, comment out if its too annoying
vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
	group = vim.api.nvim_create_augroup("terminal_insert", { clear = true }),
	callback = function()
		if vim.bo.buftype == "terminal" then vim.cmd("startinsert") end
	end,
})

-- Hook into vim.pack.update and automate the binary downloads for any plugins update incase its missing
vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function() require("typst-preview").update() end,
})

-- Plugins

require("vim._core.ui2").enable({ enable = true }) -- Can delete once it becomes default probs in 0.13
vim.pack.add({
	{ src = "https://www.github.com/YashNaga/jojolion.nvim" },
	{ src = "https://www.github.com/nvim-mini/mini.nvim" },
	{ src = "https://www.github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://www.github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://www.github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://www.github.com/stevearc/oil.nvim" },
	{ src = "https://www.github.com/tpope/vim-fugitive" },
	{ src = "https://www.github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://www.github.com/chomosuke/typst-preview.nvim" }, -- Rmb you can export typst to pandoc
	{ src = "https://www.github.com/ibhagwan/fzf-lua" },
	{ src = "https://www.github.com/stevearc/conform.nvim" },
	{ src = "https://www.github.com/saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://www.github.com/neovim/nvim-lspconfig" },
	{ src = "https://www.github.com/mason-org/mason.nvim" },
	{ src = "https://www.github.com/mason-org/mason-lspconfig.nvim" },
})
vim.cmd("packadd nohlsearch")

require("jojolion").setup()

require("mini.icons").setup()
require("mini.indentscope").setup({
	draw = {
		delay = 100,
		animation = function() return 0 end,
	},
	symbol = "▏",
	options = {
		indent_at_cursor = true,
		try_as_border = false,
	},
})

require("mini.clue").setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<leader>" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = { "n", "x" }, keys = "z" },
		{ mode = { "n", "x" }, keys = "s" },
	},
	clues = {
		require("mini.clue").gen_clues.square_brackets(),
		require("mini.clue").gen_clues.builtin_completion(),
		require("mini.clue").gen_clues.g(),
		require("mini.clue").gen_clues.marks(),
		require("mini.clue").gen_clues.registers(),
		require("mini.clue").gen_clues.windows(),
		require("mini.clue").gen_clues.z(),
	},
	window = {
		delay = 200,
		config = {
			width = "auto",
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
})

require("mini.surround").setup() -- ysiw) would be saiw) | ds) would be sd) | cs({ would be sr({

if not vim.g.neovide then
	require("smear_cursor").setup({
		stiffness = 0.8,
		trailing_stiffness = 0.6,
		stiffness_insert_mode = 0.7,
		trailing_stiffness_insert_mode = 0.7,
		damping = 0.85,
		damping_insert_mode = 0.85,
		distance_stop_animating = 0.5,
	})
end

vim.schedule(function()
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
		"nasm",
	}
	require("nvim-treesitter").install(ensureInstalled)
end)

require("lualine").setup({
	options = {
		theme = require("jojolion.lualine"),
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		icons_enabled = false,
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

require("oil").setup({
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = { show_hidden = true },
	win_options = { wrap = true },
	float = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
})

require("gitsigns").setup({
	sign_priority = 6,
	current_line_blame_opts = {
		virt_text_pos = "eol", -- switch between "right_align" and "eol"
		delay = 300,
	},
})

require("typst-preview").setup({
	dependencies_bin = {
		tinymist = "tinymist.cmd", -- "tinymist.cmd" on windows
	},
	open_cmd = "start %s", -- uncomment "open %s" for mac and "xdg-open %s" for linux and "start %s" for windows
})

require("fzf-lua").setup({
	{ "borderless-full" },
	winopts = {
		preview = {
			scrollbar = "none",
			scrollchars = { "", "" },
		},
	},
	oldfiles = { include_current_sessions = true },
	fzf_colors = true,
})

require("blink.cmp").setup({
	signature = { enabled = false }, -- Set to true to get the popup that displays values when writing functions (C-k to toggle)
	keymap = { preset = "default" },
	completion = {
		documentation = { auto_show = false }, -- set to true to automatically show documentation popup
	},
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
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT", -- Tell the language server which version of Lua you're using
						path = { "lua/?.lua", "lua/?/init.lua" }, -- Tell the language server how to find Lua modules same way as Neovim
					},
					workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } }, -- Make the server aware of Neovim runtime files
				})
			end,
			settings = { Lua = {} },
		}),
	},
	clangd = {
		-- Im gonna list some flags to keep in mind
		-- -g (debug info) -O0 (zero compiler optimisations) -Wall -Wextra (all & extra warnings) -fsanitize=address,undefined (catches a bunch of crashing bugs, undefined catches UB)
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		cmd = {
			"clangd",
			"--fallback-style=llvm",
			-- inject style rules
			[[--config={
            Diagnostics: {
                ClangTidy: {
                    Add: [
                        "bugprone-*",
                        "modernize-*",
                        "performance-*",
                        "readability-identifier-naming"
                    ],
                    Remove: [
                        "modernize-using-using"
                    ],
                    CheckOptions: {
                        "readability-identifier-naming.ClassCase": "PascalCase",
                        "readability-identifier-naming.FunctionCase": "PascalCase",
                        "readability-identifier-naming.VariableCase": "camelCase",
                        "readability-identifier-naming.ParameterCase": "camelCase",
                        "readability-identifier-naming.MemberCase": "camelCase",
                        "readability-identifier-naming.MemberSuffix": "_",
                        "readability-identifier-naming.ConstantPrefix": "k",
                        "readability-identifier-naming.ConstantCase": "PascalCase",
                        "readability-identifier-naming.GlobalVariableCase": "camelCase"
                    }
                }
            }
        }]],
		},
	},
	tinymist = {
		single_file_support = true,
		settings = {
			exportPdf = "onSave",
		},
	},
	asm_lsp = { filetypes = { "asm", "s", "S", "nasm" }, single_file_support = true, settings = {} },
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
local capabilities = require("blink.cmp").get_lsp_capabilities()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"basedpyright",
		"clangd",
		"neocmake",
		"jdtls", -- I hate java
		"tinymist",
		"rust_analyzer",
		not vim.uv.os_uname().sysname:find("Windows") and "asm_lsp" or nil, -- Cause on windows i installed it seperately
	},
	automatic_installation = true,
	auto_update = false,
	handlers = {
		function(server_name)
			local server = lspConfigs[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

-- custom lua scripting to replace mason tool installer
local registry = require("mason-registry")
local masonTools = {
	"prettier",
	"stylua",
	"isort",
	"clang-format",
	"pylint",
}
registry.refresh(function()
	for _, name in ipairs(masonTools) do
		local ok, pkg = pcall(registry.get_package, name)
		if ok and not pkg:is_installed() then
			-- hooks a listener onto the package before installing it
			pkg:once("install:success", function()
				vim.schedule(function() vim.notify("Mason: Installed " .. name, vim.log.levels.INFO) end)
			end)
			pkg:install()
		end
	end
end)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function make_opts(desc) return { buffer = ev.buf, silent = true, desc = desc } end

		local fzf = require("fzf-lua")

		-- set keybinds
		vim.keymap.set("n", "gR", function() fzf.lsp_references({ jump1 = true }) end, make_opts("Show LSP references")) -- show definition, references
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, make_opts("Go to declaration")) -- go to declaration
		vim.keymap.set("n", "gd", function() fzf.lsp_definitions({ jump1 = true }) end, make_opts("Show LSP definitons"))
		vim.keymap.set("n", "gi", function() fzf.lsp_implementations({ jump1 = true }) end, make_opts("Show LSP implementations"))
		vim.keymap.set("n", "gt", function() fzf.lsp_typedefs({ jump1 = true }) end, make_opts("Show LSP type definitions"))
		vim.keymap.set({ "n", "v" }, "<leader>ca", function() fzf.lsp_code_actions() end, make_opts("See available code actions"))
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, make_opts("Smart rename")) -- smart rename
		vim.keymap.set("n", "<leader>lt", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, make_opts("Toggle diagnostics"))
		vim.keymap.set("n", "<leader>lb", function() fzf.diagnostics_document() end, make_opts("Show buffer diagnostics"))
		vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, make_opts("Show line diagnostics"))
		vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.jump({ count = -1, float = true }) end, make_opts("Go to previous diagnostic"))
		vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.jump({ count = 1, float = true }) end, make_opts("Go to next diagnostic"))
		vim.keymap.set("n", "D", vim.lsp.buf.hover, make_opts("Show documentation for whats under cursor")) -- Double press D to enter hover as buffer
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = true,
	virtual_text = false,
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		c = { "clang_format" }, -- Took me two days to figure out its clang_format not clang-format
		cpp = { "clang_format" },
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
	default_format_opts = { lsp_format = "never" },
	format_on_save = {
		lsp_format = "never",
		async = false,
		timeout_ms = 1000,
	},
	formatters = {
		prettier = { args = { "--tab-width", "4" } },
		stylua = { prepend_args = { "--column-width", "160", "--collapse-simple-statement", "Always" } },
		clang_format = {
			-- Acts as a global .clang-format file
			prepend_args = function(self, ctx)
				return {
					"--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Always, SpaceAfterControlStatementKeyword: false, AllowShortFunctionsOnASingleLine: false, NamespaceIndentation: All, AllowShortIfStatementsOnASingleLine: false, AllowShortBlocksOnASingleLine: false, IndentAccessModifiers: true, AccessModifierOffset: -1, ColumnLimit: 120, PointerAlignment: Right, DerivePointerAlignment: false}",
					"--Wno-error=unknown",
				}
			end,
		},
	},
})

vim.cmd("colorscheme jojolion")
