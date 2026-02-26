local Plugin = { "tpope/vim-fugitive" }

Plugin.lazy = true
Plugin.event = { "BufReadPost", "BufWritePost", "VeryLazy" }

return Plugin
