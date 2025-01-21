return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup ({
        
        options = {
            -- Override 'encoding': Don't display if encoding is UTF-8.
            encoding = function()
                local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
                return ret
            end,
        
            -- fileformat: Don't display if &ff is unix
            fileformat = function()
                local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
                return ret
            end,
            }
	    })
    end,
}
