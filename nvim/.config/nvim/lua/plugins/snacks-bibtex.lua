return {
  "krissen/snacks-bibtex.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    global_files = { "~/git/git-wiki/references.bib"},
  },
  keys = {
    { "<leader>bc", function() require("snacks-bibtex").bibtex() end, desc = "BibTeX citations" },
  },
},
