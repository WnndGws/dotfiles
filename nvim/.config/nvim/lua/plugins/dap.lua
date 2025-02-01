local Plugin = { "mfussenegger/nvim-dap" }

Plugin.dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
}

Plugin.config = function()
	local dap = require("dap")
    local python = require("dap-python")
    local dapui = require("dapui")

    --- UI stuff
    local opts = {
        layouts = {
            {
                elements = {
                    { id = "repl"},
                },
                position = "bottom",
                size = 10,
            },
            {
                elements = {
                    { id = "scopes", size = 0.50 },
                    { id = "stacks", size = 0.50 },
                },
                position = "bottom",
                size = 10,

            },
        },
    }
    dapui.setup(opts)
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end

    --- Python stuff
    python.setup("uv")
    python.test_runner = 'pytest'
    python.ft = "python"

end

return Plugin
