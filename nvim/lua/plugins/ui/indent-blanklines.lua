return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" }, --Ensures it only enables when loaded in a buffer
  config = function()
	require("ibl").setup()
  end,
  opts = {
      -- char = "▏",
      char = "│",
      highlight = {"Function", "Label"},
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
}


