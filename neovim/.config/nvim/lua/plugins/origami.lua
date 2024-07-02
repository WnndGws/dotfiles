local Plugin = { "chrisgrieser/nvim-origami" }

Plugin.event = "BufReadPost"

Plugin.config = function()
    require("origami").setup ({}) -- setup call needed
end

Plugin.opts = { true }

return Plugin
