local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.dependencies = {
	-- Sources
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-cmdline" },

	-- Snippets
	{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp", dependencies= { "rafamadriz/friendly-snippets"}},
}

Plugin.event = "InsertEnter"

function Plugin.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").load({paths = "/home/wynand/.config/nvim/lua/snippets/"})

	local select_opts = { behavior = cmp.SelectBehavior.Select }

	-- See :help cmp-config
	cmp.setup({
		preselect = "item",
		completion = { completeopt = "menu,menuone,noinsert" },
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "mkdnflow" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "nvim_lsp" },
			{ name = "luasnip", keyword_length = 2 },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			fields = { "menu", "abbr", "kind" },
			format = function(entry, item)
				local menu_icon = {
					mkdnflow = "m",
					nvim_lsp = "λ",
					luasnip = "⋗",
					buffer = "Ω",
					path = "🖫",
				}

				item.menu = menu_icon[entry.source.name]
				return item
			end,
		},
		-- See :help cmp-mapping
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(select_opts),
			["<Down>"] = cmp.mapping.select_next_item(select_opts),

			["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
			["<C-n>"] = cmp.mapping.select_next_item(select_opts),

			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),

			["<C-e>"] = cmp.mapping.abort(),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			["<C-f>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-b>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<Tab>"] = cmp.mapping(function(fallback)
				local col = vim.fn.col(".") - 1

				if cmp.visible() then
					cmp.select_next_item(select_opts)
				elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					fallback()
				else
					cmp.complete()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item(select_opts)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
end

return Plugin
