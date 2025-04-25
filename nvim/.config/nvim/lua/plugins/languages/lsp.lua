------------------------------------------------------------------
local Plugin = { "neovim/nvim-lspconfig" }
------------------------------------------------------------------

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }
Plugin.dependencies = { { "hrsh7th/cmp-nvim-lsp", "HallerPatrick/py_lsp.nvim" } }
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

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

Plugin.config = function()
	-- This is where all the LSP shenanigans will live
	local lspconfig = require("lspconfig")
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local py_lsp = require("py_lsp")
    local nvim_lsp_configs = require("lspconfig.configs")


end



------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
