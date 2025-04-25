----------------
--- LAZY VIM ---
----------------
vim.g.mapleader = ","

local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

require("config.lazy")
load("config.keymaps")
load("config.nvim_settings")

spec("treesitter")

require'lspconfig'.awk_ls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.basedpyright.setup{}
require'lspconfig'.basics_ls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.css_variables.setup{}
require'lspconfig'.cssmodules_ls.setup{}
require'lspconfig'.custom_elements_ls.setup{}
require'lspconfig'.diagnosticls.setup{}
require'lspconfig'.docker_compose_language_service.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.emmylua_ls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.htmx.setup{}
require'lspconfig'.hyprls.setup{}
require'lspconfig'.jedi_language_server.setup{}

vim.filetype.add {
    extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'jinja',
    },
}
require'lspconfig'.jinja_lsp.setup{}

require'lspconfig'.jsonls.setup{}
require'lspconfig'.lemminx.setup{}
require'lspconfig'.ltex_plus.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.prosemd_lsp.setup{}
require'lspconfig'.ruff.setup{}
require'lspconfig'.snakeskin_ls.setup{}
require'lspconfig'.spectral.setup{}
require'lspconfig'.systemd_ls.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.ts_query_ls.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
