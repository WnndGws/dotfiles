return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    opts = function(_, opts)
      if require("lazyvim.util").has("noice.nvim") then
        opts.defaults["<leader>sn"] = { name = "+noice" }
        opts.defaults["<leader>d"] = { name = "+debug" }
        opts.defaults["<leader>da"] = { name = "+adapters" }
      end
    end,
  }
}
