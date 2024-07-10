local Plugin = { "MeanderingProgrammer/markdown.nvim" }

Plugin.dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Mandatory
        'nvim-tree/nvim-web-devicons', -- Optional but recommended
    }

Plugin.config = function()
    local md = require('render-markdown')
    md.setup({file_types = { 'markdown'}, headings = {'󰬺 ', '󰬻 ', '󰬼 ', '󰬽 ', '󰬾 ', '󰬿 '},
    highlights = {
        heading = {
            -- Background of heading line
            backgrounds = { 'NONE', 'NONE', 'NONE' },
            -- Foreground of heading character only
            foregrounds = {
                'markdownH1',
                'markdownH2',
                'markdownH3',
                'markdownH4',
                'markdownH5',
                'markdownH6',
            },
        },
    },})
end

return Plugin
