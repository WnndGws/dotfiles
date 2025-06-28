------------------------------------------------------------------
local Plugin = { "neovim/nvim-lspconfig" }
------------------------------------------------------------------

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "FileWritePost", "BufReadPost", "BufWritePost", "BufNewFile" }
Plugin.dependencies = { { "hrsh7th/cmp-nvim-lsp" } }
Plugin.version = false

Plugin.opts = function()
	---@class PluginLspOpts
	local ret = {
		-- options for vim.diagnostic.config()
		---@type vim.diagnostic.Opts
		diagnostics = {
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
		},
		-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the inlay hints.
		inlay_hints = {
			enabled = false,
			exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
		},
		-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the code lenses.
		codelens = {
			enabled = false,
		},
		-- add any global capabilities here
		capabilities = {
			workspace = {
				fileOperations = {
					didRename = true,
					willRename = true,
				},
			},
		},
		-- options for vim.lsp.buf.format
		-- `bufnr` and `filter` is handled by the LazyVim formatter,
		-- but can be also overridden when specified
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@type lspconfig.options
		servers = {
			systemd_ls = {},
			marksman = {},
			htmx = {},
			ltex = {
				enabled = {
					"bib",
					"context",
					"gitcommit",
					"html",
					"markdown",
					"org",
					"pandoc",
					"plaintex",
					"quarto",
					"mail",
					"mdx",
					"rmd",
					"rnoweb",
					"rst",
					"tex",
					"latex",
					"text",
					"typst",
					"xhtml",
				},
			},
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				includeLanguages = {
					eelixir = "html-eex",
					elixir = "phoenix-heex",
					eruby = "erb",
					heex = "phoenix-heex",
					htmlangular = "html",
					templ = "html",
				},
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							autopep8 = false,
							jedi_completion = {
								include_class_objects = true,
								include_function_objects = true,
								fuzzy = true,
							},
							ruff = {
								enabled = true, -- Enable the plugin
								formatEnabled = true, -- Enable formatting using ruffs formatter
								config = "/home/wynand/.config/ruff/ruff.toml", -- Custom config for ruff to use
								extendSelect = { "I" },
								format = { "I" },
								unsafeFixes = true,
							},
							pylsp_mypy = {
								live_mode = false,
								enabled = true,
							},
							bashls = {},
						},
					},
				},
			},
		},
	}
	-- you can do any additional lsp server setup here
	-- return true if you don't want this server to be setup with lspconfig
	---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
	return ret
end

Plugin.config = function(_, opts)
	vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
		opts.capabilities or {}
	)
end

------------
-- Python --
------------
vim.lsp.enable("pylsp")

----------
-- Rust --
----------

-------------
-- Systemd --
-------------
vim.lsp.enable("systemd_ls")

--------------
-- Markdown --
--------------
vim.lsp.enable("marksman")

-----------
-- Shell --
-----------
vim.lsp.enable("bashls")

----------
-- JSON --
----------
vim.lsp.enable("jsonls")

----------------
-- Javascript --
----------------

----------
-- YAML --
----------
vim.lsp.enable("yamlls")

---------
-- VIM --
---------

---------
-- CSS --
---------
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

------------
-- Docker --
------------

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
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
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
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
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

------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
