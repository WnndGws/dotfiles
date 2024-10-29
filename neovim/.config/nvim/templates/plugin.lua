local Plugin = { "" }

Plugin.dependencies = {
	-- Sources
	{ "" },
    { "" },
	{ "", version = "", build = "make install_jsregexp", dependencies= { ""}},
}

Plugin.event = "InsertEnter"

function Plugin.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	-- See :help cmp-config
	cmp.setup({
		preselect = "item",
		completion = { completeopt = "menu,menuone,noinsert" },
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
	})
end

return Plugin
