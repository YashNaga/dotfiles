-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.format_on_save.enabled = true

lvim.colorscheme="tokyonight"
vim.g.tokyonight_style="storm"

require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }

-- lua
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})


lvim.plugins={
  {"folke/tokyonight.nvim"},
  {"ahmedkhalf/project.nvim"},
  {"kyazdani42/nvim-tree.lua"},
  {"nvim-telescope/telescope.nvim"},
  {"phaazon/hop.nvim"},
  {"wfxr/minimap.vim"},
  {"windwp/nvim-spectre"},
  {"andymass/vim-matchup"},
  {"sindrets/diffview.nvim"},
  {"f-person/git-blame.nvim"},
  {"pwntester/octo.nvim"},
  {"mattn/vim-gist"},
  {"Pocco81/auto-save.nvim"},
  {"karb94/neoscroll.nvim"},
  {"folke/todo-comments.nvim"},
  {"wakatime/vim-wakatime"},
  {"turbio/bracey.vim"},
}
