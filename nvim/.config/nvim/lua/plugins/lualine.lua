return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.icons", "arkav/lualine-lsp-progress" },
	enabled = true,

	config = function()
		-- lualine require madness 🤷
		local lualine_require = require("lualine_require")
		lualine_require.require = require

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
				local icons = { "", "", "", "»" }
				local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
				local length_max = 905
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

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "onedark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 16, -- ~60fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return (
								str:gsub("(%a)([%a']*)", function(first, rest)
									return first:upper() .. rest:lower()
								end)
							)
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						draw_empty = true,
					},
					"diff",
				},
				lualine_c = {
					{
						"lsp_progress",
						display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
						spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					},
					diagnostics_message,
				},
				lualine_x = { "filename", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
