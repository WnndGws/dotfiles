return {
  "krissen/snacks-bibtex.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    -- global_files = { "~/Documents/library.bib" },
  },
  keys = {
    { "<leader>bc", function() require("snacks-bibtex").bibtex() end, desc = "BibTeX citations" },
  },
},
