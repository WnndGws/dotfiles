local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"
Plugin.opts = {
	plugins = { spelling = true },
	defaults = {
      mode = { "n", "v" },
      { "<leader>a", group = "aerial" },
      { "<leader>d", group = "delete-all-marks" },
      { "<leader>e", group = "tree" },
      { "<leader>f", group = "find-something" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "list-things" },
      { "<leader>q", group = "quit-session" },
      { "<leader>s", group = "spell-corrections" },
      { "<leader>t", group = "telescope" },
      { "<leader>w", group = "write" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
	},
}
Plugin.config = function(_, opts)
	local wk = require("which-key")
	wk.setup(opts)
    wk.add({
        opts.defaults,
    })
end

return Plugin
