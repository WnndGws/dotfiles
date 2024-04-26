local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.build = ":TSUpdate"
Plugin.event = { "VeryLazy" }
Plugin.init = function(plugin)
	-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
	-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
	-- no longer trigger the **nvim-treesitter** module to be loaded in time.
	-- Luckily, the only things that those plugins need are the custom queries, which we make available
	-- during startup.
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end
Plugin.dependencies = {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
}
Plugin.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }
---@type TSConfig
---@diagnostic disable-next-line: missing-fields
Plugin.opts = {
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"bash",
		"c",
		"diff",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
		"bibtex",
		"json5",
		"latex",
		"ninja",
		"rst",
	},
	incremental_selection = {
		enable = true,
	},
}
---@param opts TSConfig
Plugin.config = function(_, opts)
	if type(opts.ensure_installed) == "table" then
		---@type table<string, boolean>
		local added = {}
		opts.ensure_installed = vim.tbl_filter(function(lang)
			if added[lang] then
				return false
			end
			added[lang] = true
			return true
		end, opts.ensure_installed)
	end
	require("nvim-treesitter.configs").setup(opts)
end

return Plugin
