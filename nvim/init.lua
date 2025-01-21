local opt = vim.opt
local keymap = vim.keymap

-- Settings
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.wrap = false

opt.number = true
opt.relativenumber = true

opt.mouse="a"

opt.smartcase=true
opt.ignorecase=true

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

opt.rtp:prepend(lazypath)

require("lazy").setup({ 
   -- {import = "plugins"}, 
    {import = "plugins.lsp"}, 
    {import = "plugins.ui"},
    {import = "plugins.util"},
    {import = "plugins.qol"},
    checker = {
        enabled = true
    }, 
    install = {
        colorscheme = {"kanagawa-wave"} 
    }, 
})

-- Keybinds
keymap.set('n', '<CR>', function() -- Whole ahh complicated function to open a markdown link smh
    local line = vim.fn.getline(".")
    local cur = vim.api.nvim_win_get_cursor(0)

    for i = cur[2] + 1, #line - 1 do
        if string.sub(line, i, i + 1) == "](" then
            vim.api.nvim_win_set_cursor(0, { cur[1], cur[2] + i - cur[2] + 1 })
            if vim.fn.expand("<cfile>:e") == "md" then
                vim.api.nvim_feedkeys('gf', 'n', false)
            else
                vim.cmd"call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})"
            end
            return
        elseif i ~= cur[2] + 1 and string.sub(line, i, i) == "[" then
            break;
        end
    end

    for i = cur[2] + 1, 2, -1 do
        if string.sub(line, i - 1, i) == "](" then
            vim.api.nvim_win_set_cursor(0, { cur[1], i })
            if vim.fn.expand("<cfile>:e") == "md" then
                vim.api.nvim_feedkeys('gf', 'n', false)
            else
                vim.cmd"call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})"
            end
            return
        elseif i ~= cur[2] + 1 and string.sub(line, i, i) == ")" then
            break
        end
    end
end, {buffer = true})

local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Telescope: find files"})
keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Telescope: live grep"})
keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Telescope: buffers"})
keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Telescope: help tags"})

-- Autocmds

