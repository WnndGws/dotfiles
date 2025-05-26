------------------------------------------------------------------
local Plugin = { "neovim/nvim-lspconfig" }
------------------------------------------------------------------

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }
Plugin.dependencies = { { "hrsh7th/cmp-nvim-lsp" } }
Plugin.version = false

Plugin.init = function()
	local sign = function(opts)
		-- See :help sign_define()
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	-- See :help vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	vim.lsp.buf.format({ async = true })

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

Plugin.config = function()
	-- This is where all the LSP shenanigans will live
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	------------
	-- Python --
	------------
	-- pir pylyzer
	-- wasnt ready for use. replace with jedi
	-- vim.lsp.enable("pylyzer")

	-- pir jedi-language-server
	vim.lsp.enable("jedi_language_server")

	--pir ruff
	vim.lsp.config("ruff", {
		init_options = {
			settings = {
				-- Server settings should go here
				configuration = "~/.config/ruff/ruff.toml",
			},
		},
	})
	vim.lsp.enable("ruff")

	----------
	-- Rust --
	----------
	-- pir bacon
	vim.lsp.enable("bacon_ls")

	-------------
	-- Systemd --
	-------------
	-- pir systemd-language-server
	vim.lsp.enable("systemd_ls")

	--------------
	-- Markdown --
	--------------
	-- pir
	vim.lsp.enable("marksman")

	-----------
	-- Shell --
	-----------
	-- pir bash-language-server
	vim.lsp.enable("bashls")

	----------
	-- JSON --
	----------
	-- pir vscode-json-langserver
	vim.lsp.enable("jsonls")

	----------------
	-- Javascript --
	----------------
	-- pir biome
	vim.lsp.enable("biome")

	----------
	-- YAML --
	----------
	-- pir yaml-language-server
	vim.lsp.enable("yamlls")

	---------
	-- VIM --
	---------
	-- pir vim-language-server
	vim.lsp.enable("vimls")

	---------
	-- CSS --
	---------
	-- pir vscode-css-languageserver
	vim.lsp.enable("cssls")

	-- pir cssmodules-language-server
	vim.lsp.enable("cssmodules_ls")

	-- pir tailwind-language-server
	vim.lsp.enable("tailwindcss")

	----------
	-- HTML --
	----------
	-- pir vscode-html-languageserver
	vim.lsp.enable("html")

	-- cargo install htmx-lsp
	vim.lsp.enable("htmx")

	----------
	-- Hypr --
	----------
	-- pir hyprls-git
	vim.lsp.enable("hyprls")

	---------
	-- TeX --
	---------
	-- pir digestif-git
	vim.lsp.enable("digestif")

	-- pir ltex-ls-plus-bin
	vim.lsp.enable("ltex_plus")

	------------
	-- Docker --
	------------
	-- pir dockerfile-language-server
	vim.lsp.enable("dockerls")

	---------
	-- Lua --
	---------
	-- pir lua-language-server-git
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
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
					-- library = vim.api.nvim_get_runtime_file("", true)
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
	-- cargo install jinja-lsp
	vim.filetype.add({
		extension = {
			jinja = "jinja",
			jinja2 = "jinja",
			j2 = "jinja",
		},
	})
	vim.lsp.enable("jinja_lsp")
end

------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
