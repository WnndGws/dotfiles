local Plugin = { "iamcco/markdown-preview.nvim" }

Plugin.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
Plugin.build = "cd app && yarn install"
Plugin.init = function()
	vim.g.mkdp_filetypes = { "markdown" }
end
Plugin.ft = { "markdown" }

return Plugin
