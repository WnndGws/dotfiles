-----------------------------
--- SETTINGS FOR LSP-ZERO ---
-----------------------------
------------------------------------------------------------------
local Plugin = { "neovim/nvim-lspconfig" }
local user = {}
------------------------------------------------------------------

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }
Plugin.dependencies = { { "hrsh7th/cmp-nvim-lsp" } }

Plugin.init = function()
	local sign = function(opts)
		-- See :help sign_define()
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	sign({ name = "DiagnosticSignError", text = "" })
	sign({ name = "DiagnosticSignWarn", text = "" })
	sign({ name = "DiagnosticSignHint", text = "" })
	sign({ name = "DiagnosticSignInfo", text = "»" })

	-- See :help vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

Plugin.config = function()
	-- This is where all the LSP shenanigans will live
	local lspconfig = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	-------------------------------------------
	--- Lua via pikaur(lua-language-server) ---
	-------------------------------------------
	lspconfig.lua_ls.setup({
		capabilities = lsp_capabilities,
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
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
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			})
		end,
		settings = {
			Lua = {},
		},
	})

	-------------------------------
	--- Python via pikaur(ruff) ---
	-------------------------------
	lspconfig.ruff.setup({ capabilities = lsp_capabilities })

	------------------------------------
	--- Javascript via pikaur(biome) ---
	------------------------------------
	lspconfig.biome.setup({ capabilities = lsp_capabilities })

	-------------------------------------------
	--- Sh via pikaur(bash-language-server) ---
	-------------------------------------------
	lspconfig.bashls.setup({ capabilities = lsp_capabilities })

	----------------------------------------------------------------------------------------------------------
	--- CSS via pikaur(vscode-css-languageserver, cssmodules-language-server, tailwindcss-language-server) ---
	----------------------------------------------------------------------------------------------------------
	--Enable (broadcasting) snippet capability for completion

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	lspconfig.cssls.setup({ capabilities = lsp_capabilities, capabilities = capabilities })
	lspconfig.cssmodules_ls.setup({ capabilities = lsp_capabilities })
	lspconfig.tailwindcss.setup({ capabilities = lsp_capabilities })

	---------------------------------------------------
	--- JSON via pikaur(vscode-json-languageserver) ---
	---------------------------------------------------
	lspconfig.jsonls.setup({ capabilities = lsp_capabilities, capabilities = capabilities })

	---------------------------------------------------
	--- HTML via pikaur(vscode-html-languageserver) ---
	---------------------------------------------------
	lspconfig.jsonls.setup({ capabilities = lsp_capabilities, capabilities = capabilities })

	--------------------------------
	--- HTMX via cargo(htmx-lsp) ---
	--------------------------------
	lspconfig.htmx.setup({ capabilities = lsp_capabilities })

	------------------------
	--- Jinja via native ---
	------------------------
	vim.filetype.add({
		extension = {
			jinja = "jinja",
			jinja2 = "jinja",
			j2 = "jinja",
		},
	})
	lspconfig.jinja_lsp.setup({ capabilities = lsp_capabilities })

	-----------------------------------------
	--- Markdown via pikaur(marksman-bin) ---
	-----------------------------------------
	lspconfig.marksman.setup({ capabilities = lsp_capabilities })

	-----------------------------------------
	--- LaTex via pikaur(texlab-bin) ---
	-----------------------------------------
	lspconfig.texlab.setup({ capabilities = lsp_capabilities })
end

------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
