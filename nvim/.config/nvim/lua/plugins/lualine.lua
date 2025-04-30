local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.event = "VeryLazy"
Plugin.dependencies = { "nvim-tree/nvim-web-devicons" }

Plugin.config = function()
	-- lualine require madness 🤷
	local lualine_require = require("lualine_require")
	lualine_require.require = require

	vim.o.laststatus = vim.g.lualine_laststatus

	local utils = require("lualine.utils.utils")
	local highlight = require("lualine.highlight")

	local diagnostics_message = require("lualine.component"):extend()

	diagnostics_message.default = {
		colors = {
			error = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
				"#e32636"
			),
			warning = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
				"#ffa500"
			),
			info = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
				"#ffffff"
			),
			hint = utils.extract_color_from_hllist(
				{ "fg", "sp" },
				{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
				"#273faf"
			),
		},
	}
	function diagnostics_message:init(options)
		diagnostics_message.super:init(options)
		self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
		self.highlights = { error = "", warn = "", info = "", hint = "" }

		self.highlights.error = highlight.create_component_highlight_group(
			{ fg = self.options.colors.error },
			"diagnostics_message_error",
			self.options
		)
		self.highlights.warn = highlight.create_component_highlight_group(
			{ fg = self.options.colors.warn },
			"diagnostics_message_warn",
			self.options
		)
		self.highlights.info = highlight.create_component_highlight_group(
			{ fg = self.options.colors.info },
			"diagnostics_message_info",
			self.options
		)
		self.highlights.hint = highlight.create_component_highlight_group(
			{ fg = self.options.colors.hint },
			"diagnostics_message_hint",
			self.options
		)
	end

	function diagnostics_message:update_status(is_focused)
		local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
		local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
		if #diagnostics > 0 then
			local diag = diagnostics[1]
			for _, d in ipairs(diagnostics) do
				if d.severity < diag.severity then
					diag = d
				end
			end
			local icons = { "", "", "", "»" }
			local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
			local length_max = 75
			local message = diag.message
			local code = diag.code
			if code == nil then
				code = ""
			end
			if #message > length_max then
				message = string.sub(diag.message, 1, length_max) .. "…"
			end
			return highlight.component_format_highlight(hl[diag.severity])
				.. icons[diag.severity]
				.. " "
				.. utils.stl_escape(diag.source)
				.. "("
				.. utils.stl_escape(code)
				.. "): "
				.. utils.stl_escape(message)
		else
			return ""
		end
	end

	local lualine = require("lualine")
	lualine.setup({
		options = {
			globalstatus = true,
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "NvimTree" },
			},
		},
		sections = {
			lualine_a = { "mode", "searchcount" },
			lualine_b = {
				"branch",
				{
					"diff",
					colored = true,
					diff_color = {
						added = { fg = "#c3e88d" },
						modified = { fg = "#7aa2f7" },
						removed = { fg = "#ff757f" },
					},
					symbols = { added = "+", modified = "~", removed = "-" },
				},
			},
			lualine_c = {
				{
					diagnostics_message,
					colors = { error = "#c53b53", warn = "#ffc777", info = "#7aa2f7", hint = "#737aa2" },
				},
			},
			lualine_x = {},
			lualine_y = { { "filename", file_status = true }, "filetype" },
			lualine_z = { "progress" },
		},
	})
end

Plugin.init = function()
	vim.opt.showmode = false
	vim.g.lualine_laststatus = vim.o.laststatus
	if vim.fn.argc(-1) > 0 then
		-- set an empty statusline till lualine loads
		vim.o.statusline = " "
	else
		-- hide the statusline on the starter page
		vim.o.laststatus = 0
	end
end

return Plugin
