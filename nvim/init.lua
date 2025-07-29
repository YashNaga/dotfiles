local opt = vim.opt
local keymap = vim.keymap

-- Settings
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

opt.clipboard="unnamedplus"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.wrap = false

opt.number = true
-- opt.relativenumber = true

opt.mouse="a"

opt.smartcase=true
opt.ignorecase=true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

opt.rtp:prepend(lazypath)

require("lazy").setup({ 
    {import = "plugins.lsp"}, 
    {import = "plugins.ui"},
    {import = "plugins.util"},
    checker = {
        enabled = true
    }, 
    install = {
        colorscheme = {"kanagawa-wave"} 
    }, 
})

-- Keybinds
local builtin = require('telescope.builtin') -- the following are all telescope keymaps
keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Telescope: find files"})
keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Telescope: live grep"})
keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Telescope: buffers"})
keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Telescope: help tags"})

-- Ctrl + u and d move cursor to middle of screen easier to follow
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')

-- Autocmds

