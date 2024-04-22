local Plugin = {'nvim-treesitter/nvim-treesitter-context'}

Plugin.event = "VeryLazy"
Plugin.enabled = true
Plugin.opts = { mode = "cursor", max_lines = 3 }
Plugin.keys = {
{
    "<leader>ut",
    function()
    local tsc = require("treesitter-context")
    tsc.toggle()
    if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
        LazyVim.info("Enabled Treesitter Context", { title = "Option" })
    else
        LazyVim.warn("Disabled Treesitter Context", { title = "Option" })
    end
    end,

    desc = "Toggle Treesitter Context",
},
}

return Plugin
