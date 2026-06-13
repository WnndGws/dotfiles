local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.dependencies = {
	-- Sources
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-cmdline" },

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "honza/vim-snippets" },
}

Plugin.event = "InsertEnter"

function Plugin.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()

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
			{ name = "path", keyword_length = 0 },
			-- { name = "buffer", keyword_length = 2 },
			{ name = "luasnip", keyword_length = 0 },
			{ name = "nvim_lsp", keyword_length = 0 },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			fields = { "menu", "abbr", "kind" },
			format = function(entry, item)
				local menu_icon = {
					nvim_lsp = "λ",
					luasnip = "⋗",
					-- buffer = "Ω",
					path = "🖫",
				}
				local highlights_info = require("colorful-menu").cmp_highlights(entry)

				-- highlight_info is nil means we are missing the ts parser, it's
				-- better to fallback to use default `vim_item.abbr`. What this plugin
				-- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
				if highlights_info ~= nil then
					item.abbr_hl_group = highlights_info.highlights
					item.abbr = highlights_info.text
				end

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
			-- Just a random combo i mapped to my keyboard
			["<C-Y>"] = cmp.mapping.confirm({ select = false }),
			["'"] = cmp.mapping.confirm({ select = false }),

			-- Use 'c' then " to wrap corrected text in the snippet
			['"'] = cmp.mapping(function(fallback)
				cmp.mapping.confirm({ select = false })(fallback)
				local done_once = false
				cmp.event:on("confirm_done", function(entry)
					if done_once then
						return
					end
					done_once = true
					-- Schedule past the cmp confirm cycle
					vim.schedule(function()
						vim.paste({ vim.fn.getreg('"') }, -1)
						-- Schedule again past the paste processing
						vim.schedule(function()
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<Esc>2wi", true, false, true),
								"n",
								false
							)
						end)
					end)
				end)
			end, { "i", "s" }),

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
