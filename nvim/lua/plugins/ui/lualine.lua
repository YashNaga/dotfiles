return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
  config = function()
    require("lualine").setup({
      options = {
        theme = "kanagawa", 
        section_separators = { left = "", right = "" },-- section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },-- component_separators = { left = "", right = "" },
        icons_enabled = false -- icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "filename", color = { bg = "#2a2a37"} } }, -- lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {}, 
        lualine_x = {},-- lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = { { "location", color = { bg = "2a2a37"} } }, -- lualine_y = { "progress" },
        lualine_z = { "filetype" } -- lualine_z = {"location"}
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
}

