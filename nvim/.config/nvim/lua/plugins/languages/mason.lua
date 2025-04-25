local Mason = { "williamboman/mason.nvim" }

Mason.cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" }
Mason.event = "UIEnter"
Mason.dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", }
Mason.config = true

local MasonTool = { "WhoIsSethDaniel/mason-tool-installer.nvim" }
MasonTool.config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSPs
          -- Enable these in the lsp file!
          "awk-language-server",  -- awk
          "bash-language-server",  -- bash
          "basedpyright",  -- Static python
          "basics-language-server",  -- buffer, path, and snippets
          "css-lsp",  -- CSS, SCSS, LESS
          "css-variables-language-server",  -- Autocomplete CSS variables
          "cssmodules-language-server",  -- Autocomplete for modules
          "custom-elements-languageserver",  -- Web components
          "diagnostic-languageserver",  -- Integrates with linters
          "docker-compose-language-service",  -- Docker Compose
          "dockerfile-language-server",  -- Docker
          "emmylua_ls",  -- Lua
          "html-lsp",  -- HTML
          "htmx-lsp",  -- HTMX
          "hyprls",  -- Hyprland
          "jedi-language-server",  -- Python
          "jinja-lsp",  -- Jinja
          "json-lsp",  -- Json
          "jsonld-lsp",  -- Json-D
          "lemminx",  -- XML
          "ltex-ls-plus",  -- Text like Tex and md
          "marksman",  -- Md
          "prosemd-lsp",  -- Prose in md
          "ruff",  -- Python
          "snakeskin-cli",  -- Javascript
          "sourcery",  -- Refactoring server
          "spectral-language-server",  -- OpenApi Json
          "superhtml",  -- HTML
          "systemd-language-server",  -- Systemd
          "tailwindcss-language-server",  -- Tailwind
          "texlab",  -- Latex
          "ts_query_ls",  -- Treesitter
          "vim-language-server",  -- Vim
          "yaml-language-server",  -- yaml
          -- Linters
          "api-linter",  -- Api
          "bacon",  -- rust
          "bandit",  -- Python security
          "biome",  -- Javascript
          "checkstyle",  -- Java
          "curlylint",  -- HTML templating langs
          "dotenv-linter",  -- dotenv
          "hadolint",  -- Dockerfile
          "htmlhint",  -- html
          "jinja-lsp",  -- jinja
          "jsonlint",  -- json
          "markdownlint",  -- md
          "mypy",  -- static python
          "oxlint",  -- Javascript
          "protolint",  -- Protocol Buffers
          "pydocstyle",  -- Python docs
          "pylama",  -- Pylama
          "pymarkdownlnt",  -- Markdown
          "refurb",  -- Python modernizing tool
          "selene",  -- Lua
          "semgrep",  -- bug finder
          "shellcheck",  -- shell
          "shellharden",  -- shell
          "snyk",  -- Security checker
          "stylelint",  -- CSS
          "systemdlint",  -- systemd
          "trufflehog",  -- Secrets checkers
          "vacuum",  -- OpenApi
          "vint",  -- vim
          "vulture",  -- Dead python
          "yamllint",  -- yaml
          -- Formatters
          "beautysh",  -- shell
          "bibtex-tidy",  -- bibtex
          "cbfmt",  -- md, format code in md
          "docformatter",  -- python docs
          "doctoc",  -- md toc
          "fixjson",  -- fixjson
          "google-java-format",  -- Java
          "jq",  -- json
          "latexindent",  -- Latex
          "mdformat",  -- md
          "mdsf",  -- md code blocks
          "mdslw",  -- md sentence wrapper
          "prettierd",  -- lots of stuff, html, md, json
          "rustfmt",  -- rust
          "rustywind",  -- tailwind
          "shfmt",  -- shell
          "tex-fmt",  -- latex
          "xmlformatter",  -- xml
          "yamlfix",  -- yaml
        },
    auto_update = true,
    modifiable = true
    })
end

return { Mason, MasonTool }
