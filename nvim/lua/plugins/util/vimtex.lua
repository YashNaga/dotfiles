return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
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
}
