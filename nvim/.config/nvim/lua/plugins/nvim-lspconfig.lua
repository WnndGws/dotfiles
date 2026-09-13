return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo" },
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { { "hrsh7th/cmp-nvim-lsp" } },
	version = false, -- follow default branch (master)

	config = function()
		-- Diagnostics
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Global capabilities, applied as a base to every server (:h lsp-config)
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		vim.lsp.config("*", {
			capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				{
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				}
			),
		})

		------------
		-- Python --
		------------
		vim.lsp.enable("pyrefly")
		vim.lsp.enable("ruff")
		vim.lsp.enable("jedi_language_server")

		---------
		-- XML --
		---------
		vim.lsp.enable("lemminx")

		----------
		-- Rust --
		----------
		vim.lsp.enable("rust_analyzer")

		----------
		-- TOML --
		----------
		vim.lsp.enable("tombi")

		--------------
		-- Markdown --
		--------------
		vim.lsp.enable("marksman")

		-----------
		-- Shell --
		-----------
		vim.lsp.enable("shuck")

		----------
		-- JSON --
		----------
		vim.lsp.enable("jsonls")

		----------
		-- YAML --
		----------
		vim.lsp.config("yamlls", {
			log_level = vim.log.levels.DEBUG,
			settings = {
				yaml = {
					schemaStore = {
						enable = true,
						url = "https://www.schemastore.org/api/json/catalog.json",
					},
				},
			},
		})
		vim.lsp.enable("yamlls")

		---------
		-- CSS --
		---------
		vim.lsp.enable("css-lsp")
		vim.lsp.enable("cssmodules-language-server")
		vim.lsp.enable("tailwindcss")

		----------
		-- HTML --
		----------
		vim.lsp.enable("htmx")

		----------
		-- Hypr --
		----------
		vim.lsp.enable("hyprls")

		---------
		-- TeX --
		---------
		vim.lsp.enable("ltex_plus")

		---------
		-- Lua --
		---------
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- LuaJIT, matching Neovim's embedded Lua
						version = "LuaJIT",
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
		vim.lsp.enable("lua_ls")

		-----------
		-- Jinja --
		-----------
		vim.filetype.add({
			extension = {
				jinja = "jinja",
				jinja2 = "jinja",
				j2 = "jinja",
			},
		})
		vim.lsp.enable("jinja_lsp")
	end,
}
