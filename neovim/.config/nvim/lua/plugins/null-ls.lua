return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.code_actions.cspell,
          nls.builtins.code_actions.gitsigns,
          nls.builtins.code_actions.proselint,
          nls.builtins.code_actions.shellcheck,
          nls.builtins.code_actions.ts_node_action,
          nls.builtins.completion.luasnip,
          nls.builtins.completion.tags,
          nls.builtins.diagnostics.alex,
          nls.builtins.diagnostics.checkstyle.with({ extra_args = { "-c", "/google_checks.xml" } }),
          nls.builtins.diagnostics.chktex,
          nls.builtins.diagnostics.codespell,
          nls.builtins.diagnostics.jshint,
          nls.builtins.diagnostics.jsonlint,
          nls.builtins.diagnostics.luacheck,
          nls.builtins.diagnostics.markdownlint_cli2,
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.proselint,
          nls.builtins.diagnostics.ruff,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.standardjs,
          nls.builtins.diagnostics.stylelint,
          nls.builtins.diagnostics.tidy,
          nls.builtins.diagnostics.vint,
          nls.builtins.diagnostics.write_good,
          nls.builtins.diagnostics.zsh,
        },
      }
    end,
  },
}
