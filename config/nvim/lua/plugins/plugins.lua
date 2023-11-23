return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~Coding/org/notes",
                home = "~/Coding/org/home",
              },
            },
          },
        },
      })
    end,
  },
  { "alanfortlink/blackjack.nvim", event = "VeryLazy" },
}
