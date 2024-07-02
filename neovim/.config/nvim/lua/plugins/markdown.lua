local Plugin = { "MeanderingProgrammer/markdown.nvim" }

Plugin.dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Mandatory
        'nvim-tree/nvim-web-devicons', -- Optional but recommended
    }

Plugin.config = function()
    local md = require('render-markdown')
    md.setup({file_types = { 'markdown'}, log_level = "debug" })
end

return Plugin
