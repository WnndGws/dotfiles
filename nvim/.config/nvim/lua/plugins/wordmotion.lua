local Plugin = { "chaoren/vim-wordmotion" }

Plugin.lazy = false
Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" }

return Plugin
