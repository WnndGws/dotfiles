-----------------------------
--- SETTINGS FOR LSP-ZERO ---
-----------------------------
-- https://lsp-zero.netlify.app/v3.x/tutorial.html
------------------------------------------------------------------
local Plugin = { 'VonHeikemen/lsp-zero.nvim' }
------------------------------------------------------------------

Plugin.branch = 'v3.x'
Plugin.lazy = true
Plugin.dependencies = {
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },    -- For completion
	{ 'hrsh7th/cmp-buffer' },  -- For completion
	{ 'L3MON4D3/LuaSnip' },    -- For custom snippets
}

Plugin.config = false
Plugin.init = function()
    -- Disable automatic setup, we are doing it manually
    vim.g.lsp_zero_extend_cmp = 0    -- See ./completion.lua
    vim.g.lsp_zero_extend_lspconfig = 0    -- see ./lsp.lua
end

------------------------------------------------------------------
return Plugin
------------------------------------------------------------------
