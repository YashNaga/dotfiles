-- Settings

vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Keybinds

vim.keymap.set("n", " ", "<Nop>", { desc = "Ignore space", silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Autocmds

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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

        -- Kanagawa theme (wave variant i think)
        {
            "rebelot/kanagawa.nvim",
            config = function()
                require("kanagawa").setup({
                    transparent = true,
                    colors = {
                        theme = {
                            all = {
                                ui = {
                                    bg_gutter = "none"
                                },
                            },
                        },
                    },
                })
                vim.cmd("colorscheme kanagawa-wave")
            end,
            build = function()
                vim.cmd("KanagawaCompile")
            end,
        },

        -- The cool little bar at the bottom
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                require("lualine").setup({
                    options = {
                        theme = "kanagawa",
                        section_separators = { left = "", right = "" },   -- section_separators = { left = "", right = "" },
                        component_separators = { left = "", right = "" }, -- component_separators = { left = "", right = "" },
                        icons_enabled = false                             -- icons_enabled = true,
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_b = { { "filename", color = { bg = "#2a2a37" } } }, -- lualine_b = { "branch", "diff", "diagnostics" },
                        lualine_c = {},
                        lualine_x = {},                                             -- lualine_x = {"encoding", "fileformat", "filetype"},
                        lualine_y = { { "location", color = { bg = "2a2a37" } } },  -- lualine_y = { "progress" },
                        lualine_z = { "filetype" }                                  -- lualine_z = {"location"}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = { "filename" },
                        lualine_x = { "location" },
                        lualine_y = {},
                        lualine_z = {}
                    },
                    extensions = { "nvim-tree", "quickfix" }
                })
            end,
        },

        -- The lines for indentation guiding cause my eyes get lost
        {
            "lukas-reineke/indent-blankline.nvim",
            event = { "BufReadPre", "BufNewFile" }, --Ensures it only enables when loaded in a buffer
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
        {
            "sphamba/smear-cursor.nvim",
            opts = {},
        },

        -- Git signs for like git n shi
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require('gitsigns').setup()
            end,
        },

        -- Markdown preview for my workflow (in the event you wanna switch check out 'brianhuster/live-preview')
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = 'cd app && yarn install',
            init = function()
                vim.g.mkdp_filetypes = { 'markdown' }
            end,
            ft = { 'markdown' },
            config = function()
                vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'Markdown preview toggle' })
            end,
            -- init = function()
            -- local g = vim.g
            -- g.mkdp_auto_start = 1
            -- end,
        },

        -- Vimtex for my mathematical workflow (its not really setup and i dont really know how to use it yet)
        {
            "lervag/vimtex",
            lazy = false, -- we don't want to lazy load VimTeX
            -- tag = "v2.15", -- uncomment to pin to a specific release
            init = function()
                -- VimTeX configuration goes here, e.g.
                vim.g.vimtex_viewer_method = "zathura --fork"
                vim.g.vimtex_view_general_viewer = "zathura --fork"
                vim.g.vimtex_viewer_automatic = 1
                vim.g.vimtex_compiler_method = "latexmk"
                vim.g.vimtex_view_zathura_options = '--synctex-forward %l:%c:%s %f'
                vim.g.vimtex_compiler_latexmk = {
                    aux_dir = "./.latexmk/aux",
                    out_dir = "./.latexmk/out",
                }
            end
        },

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
                { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        },

        -- To open links with gx
        {

            "chrishrb/gx.nvim",
            keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
            cmd = { "Browse" },
            init = function()
                vim.g.netrw_nogx = 1                    -- disable netrw gx
            end,
            dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
            config = true,                              -- default settings
            submodules = false,                         -- not needed, submodules are required only for tests

            -- you can specify also another config if you want
            config = function()
                require("gx").setup {
                    open_browser_app = "open",              -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
                    open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".

                    open_callback = false,                  -- optional callback function to be called with the selected url on open
                    open_callback = function(url)
                        vim.fn.setreg("+", url)             -- for example, you can set the url to clipboard here
                    end,

                    select_prompt = true, -- shows a prompt when multiple handlers match; disable to auto-select the top one

                    handlers = {
                        plugin = true,       -- open plugin links in lua (e.g. packer, lazy, ..)
                        github = true,       -- open github issues
                        brewfile = true,     -- open Homebrew formulaes and casks
                        package_json = true, -- open dependencies from package.json
                        search = true,       -- search the web/selection on the web if nothing else is found
                        go = true,           -- open pkg.go.dev from an import statement (uses treesitter)
                        jira = {             -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
                            name = "jira",   -- set name of handler
                            handle = function(mode, line, _)
                                local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
                                if ticket and #ticket < 20 then
                                    return "http://jira.company.com/browse/" .. ticket
                                end
                            end,
                        },
                        rust = {                     -- custom handler to open rust's cargo packages
                            name = "rust",           -- set name of handler
                            filetype = { "toml" },   -- you can also set the required filetype for this handler
                            filename = "Cargo.toml", -- or the necessary filename
                            handle = function(mode, line, _)
                                local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

                                if crate then
                                    return "https://crates.io/crates/" .. crate
                                end
                            end,
                        },
                    },
                    handler_options = {
                        search_engine = "google",                             -- you can select between google, bing, duckduckgo, ecosia and yandex
                        search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
                        select_for_search = false,                            -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link

                        git_remotes = { "upstream", "origin" },               -- list of git remotes to search for git issue linking, in priority
                        git_remotes = function(fname)                         -- you can also pass in a function
                            if fname:match("myproject") then
                                return { "mygit" }
                            end
                            return { "upstream", "origin" }
                        end,

                        git_remote_push = false,          -- use the push url for git issue linking,
                        git_remote_push = function(fname) -- you can also pass in a function
                            return fname:match("myproject")
                        end,
                    },
                }
            end,
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
                -- your configuration comes here
                -- or leave it empty to use the default settings
            }
        },

        -- File explorer
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            keys = {
                { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Open/Close Neovim file tree" },
            },
            config = function()
                require("nvim-tree").setup {
                    actions = {
                        open_file = {
                            quit_on_open = true,
                        },
                    },
                }
            end,
        },

        -- Edit directories in buffer
        {
            'stevearc/oil.nvim',
            ---@module 'oil'
            ---@type oil.SetupOpts
            opts = {},
            keys = {
                { '-', '<cmd>Oil --float<cr>', desc = 'Opens Oil in floating window' }
            },
            dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
            lazy = false,
            config = function()
                require('oil').setup({
                    default_file_explorer = true,
                    delete_to_trash = true,
                    skip_confirm_for_simple_edits = true,
                    view_options = {
                        show_hidden = true,
                        natural_order = true,
                    },
                    win_options = {
                        wrap = true,
                    }
                })
            end,
        },

        -- Tree sitter (tbh i dont really know what it does)
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "cpp", "cmake", "html", "css", "java", "javascript", "javadoc", "json", "latex", "kotlin", "make", "markdown", "matlab", "python", "regex", "runescript", "rust", "sql", "tmux", "toml", "typescript", "zathurarc" }
                })
            end,
        },

        -- Auto pairing
        {
            'altermo/ultimate-autopair.nvim',
            event = { 'InsertEnter', 'CmdlineEnter' },
            branch = 'v0.6', --recommended as each new version will have breaking changes
            opts = {
                --Config goes here
            },
        },

        -- Auto formatter
        {
            "stevearc/conform.nvim",
            event = { "BufReadPre", 'BufNewFile' },
            config = function()
                require('conform').setup({
                    formatters_by_ft = {
                        markdown = { "prettier" },
                        python = { "isort", 'black' },
                    },
                    format_on_save = {
                        lsp_fallback = true,
                        async = false,
                        timeout_ms = 1000,
                    },
                })
            end,
        },

        -- fzf lua replacement for telescope
        {
            "ibhagwan/fzf-lua",
            -- optional for icon support
            dependencies = { "nvim-tree/nvim-web-devicons" },
            cmd = "FzfLua",
            opts = {
                oldfiles = {
                    include_current_sessions = true,
                },
                fzf_colors = true,
            },
            keys = {
                { "<leader>ff", "<cmd>FzfLua files<cr>",        desc = "Search files" },
                { "<leader>fb", "<cmd>FzfLua resume<cr>",       desc = "Resume search" },
                { "<leader>fg", "<cmd>FzfLua grep<cr>",         desc = "Search by grep" },
                { "<leader>fl", "<cmd>FzfLua live_grep<cr>",    desc = "Search by live grep" },
                { "<leader>fk", "<cmd>FzfLua keymaps<cr>",      desc = "Keymaps" },
                { "<leader>fs", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Fuzzily search in current buffer" },
                { "<leader>fo", "<cmd>FzfLua buffers<cr>",      desc = "Find opened buffers in current neovim instance" },


            },
        },

        -- Autocompletions
        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
            dependencies = { 'rafamadriz/friendly-snippets' },

            -- use a release tag to download pre-built binaries
            version = '1.*',

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
                keymap = { preset = 'default' },
                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono'
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = { documentation = { auto_show = false }, accept = { auto_brackets = { enabled = false } }, },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },

        -- Automating disabling LSP to save explorer
        {
            "zeioth/garbage-day.nvim",
            dependencies = "neovim/nvim-lspconfig",
            event = "VeryLazy",
            opts = {
                -- Options/
            }
        },

        -- Main LSP configuration
        {
            "mason-org/mason.nvim",
            lazy = false,
            dependencies = {
                "mason-org/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                "neovim/nvim-lspconfig",
                "saghen/blink.cmp"
            },

            keys = {
                { '<leader>grn', vim.lsp.buf.rename,                           desc = '[R]e[n]ame' },
                { '<leader>gra', vim.lsp.buf.code_action,                      desc = '[G]oto Code [A]ction' },
                { '<leader>grr', '<cmd>FzfLua lsp_references<cr>',             desc = '[G]oto [R]eferences' },
                { '<leader>gri', '<cmd>FzfLua lsp_implementations<cr>',        desc = '[G]oto [I]mplementations' },
                { '<leader>grd', '<cmd>FzfLua lsp_definitions<cr>',            desc = '[G]oto [D]efinitions' },
                { '<leader>grD', vim.lsp.buf.declaration,                      desc = '[G]oto [D]eclaration' },
                { '<leader>gO',  '<cmd>FzfLua lsp_document_symbols<cr>',       desc = 'Open Document Symbols' },
                { '<leader>gW',  '<cmd>FzfLua lsp_live_workspace_symbols<cr>', desc = 'Open Workspace Symbols' },
                { '<leader>grt', '<cmd>FzfLua lsp_typedefs<cr>',               desc = '[G]oto [T]ype Definition' },
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
                            package_uninstalled = "✗"
                        }
                    }
                })

                mason_lspconfig.setup({
                    ensure_installed = {
                        "lua_ls",
                        "basedpyright",
                        "clangd",
                        "cmake",
                        "jdtls",
                        "ltex",
                        "ltex_plus"
                    },

                    automatic_installation = true,
                })

                mason_tool_installer.setup({
                    ensure_installed = {
                        "prettier",
                        "stylua",
                        "isort",
                        "clangd",
                        "pylint"
                    },
                })

                local servers = {
                    lua_ls = {
                        cmd = { 'lua-language-server' },
                        filetypes = { 'lua' },
                        root_markers = {
                            '.luarc.json',
                            '.luarc.jsonc',
                            '.luacheckrc',
                            '.stylua.toml',
                            'stylua.toml',
                            'selene.toml',
                            'selene.yml',
                            '.git',
                        },
                        vim.lsp.config('lua_ls', {
                            on_init = function(client)
                                if client.workspace_folders then
                                    local path = client.workspace_folders[1].name
                                    if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                                        return
                                    end
                                end

                                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using (most
                                        -- likely LuaJIT in the case of Neovim)
                                        version = 'LuaJIT',
                                        -- Tell the language server how to find Lua modules same way as Neovim
                                        -- (see `:h lua-module-load`)
                                        path = {
                                            'lua/?.lua',
                                            'lua/?/init.lua',
                                        },
                                    },
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            vim.env.VIMRUNTIME
                                            -- Depending on the usage, you might want to add additional paths
                                            -- here.
                                            -- '${3rd}/luv/library'
                                            -- '${3rd}/busted/library'
                                        }
                                        -- Or pull in all of 'runtimepath'.
                                        -- NOTE: this is a lot slower and will cause issues when working on
                                        -- your own configuration.
                                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                                        -- library = {
                                        --   vim.api.nvim_get_runtime_file('', true),
                                        -- }
                                    }
                                })
                            end,
                            settings = {
                                Lua = {}
                            }
                        })
                    },

                    -- Define custom configs for LSPs otherwise nvim-lspconfig lets us use predefined configs

                    -- clangd = {}
                    -- basedpyright = {}
                }

                mason_lspconfig.setup({
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}

                            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities,
                                server.capabilities or {})
                            lspconfig[server_name].setup(server)
                        end,
                    }
                })

                vim.api.nvim_create_autocmd('LspAttach', {
                    callback = function(event)
                        vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.goto_prev() end,
                            { desc = 'Go to the [D]iagnostic [P]revious' })
                        vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.goto_next() end,
                            { desc = 'Go to the [D]iagnostic [N]ext' })
                        vim.keymap.set('n', '<leader>do', function() vim.diagnostic.open_float() end,
                            { desc = 'Hover over Diagnostic and open menu' })
                    end
                })

                -- Diagnostic Config
                -- See :help vim.diagnostic.Opts
                vim.diagnostic.config {
                    severity_sort = true,
                    float = { border = 'rounded', source = 'if_many' },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = vim.g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = '󰅚 ',
                            [vim.diagnostic.severity.WARN] = '󰀪 ',
                            [vim.diagnostic.severity.INFO] = '󰋽 ',
                            [vim.diagnostic.severity.HINT] = '󰌶 ',
                        },
                    } or {},
                    virtual_text = {
                        source = 'if_many',
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
                }
            end
        },

        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {
            colorscheme = { "kanagawa" }
        },
        -- automatically check for plugin updates
        checker = { enabled = true },
    }
})
