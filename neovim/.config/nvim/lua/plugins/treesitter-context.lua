local Plugin = {'nvim-treesitter/nvim-treesitter-context'}

Plugin.event = "VeryLazy"
Plugin.enabled = true
Plugin.opts = { mode = "cursor", max_lines = 3 }

return Plugin
