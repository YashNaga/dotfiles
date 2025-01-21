return {

  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
    lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        }
    },
    win_options = {
        winhighlight = {
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#FFFFFF", bg = "NONE" }),
            vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#FFFFFF" }), -- white border color
            -- vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", {fg = "#FFFFFF", bg = "NONE"}),
        },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
