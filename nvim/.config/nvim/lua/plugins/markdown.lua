return {
	"tadmccorkle/markdown.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	ft = "markdown", -- or 'event = "VeryLazy"'
	opts = {
		-- Disable all keymaps by setting mappings field to 'false'.
		-- Selectively disable keymaps by setting corresponding field to 'false'.
		mappings = {
			inline_surround_toggle = "<leader>msa", -- (string|boolean) toggle inline style
			inline_surround_toggle_line = "<leader>mst", -- (string|boolean) line-wise toggle inline style
			inline_surround_delete = "<leader>msx", -- (string|boolean) delete emphasis surrounding cursor
			inline_surround_change = "<leader>msc", -- (string|boolean) change emphasis surrounding cursor
			link_add = false, -- (string|boolean) add link
			link_follow = false, -- (string|boolean) follow link
			go_curr_heading = "<leader>mh", -- (string|boolean) set cursor to current section heading
			go_parent_heading = false, -- (string|boolean) set cursor to parent section heading
			go_next_heading = false, -- (string|boolean) set cursor to next section heading
			go_prev_heading = false, -- (string|boolean) set cursor to previous section heading
		},
		inline_surround = {
			-- For the emphasis, strong, strikethrough, and code fields:
			-- * 'key': used to specify an inline style in toggle, delete, and change operations
			-- * 'txt': text inserted when toggling or changing to the corresponding inline style
			emphasis = {
				key = "i",
				txt = "*",
			},
			strong = {
				key = "b",
				txt = "**",
			},
			strikethrough = {
				key = "s",
				txt = "~~",
			},
			code = {
				key = "c",
				txt = "`",
			},
		},
		link = {
			paste = {
				enable = true, -- whether to convert URLs to links on paste
			},
		},
		toc = {
			-- Comment text to flag headings/sections for omission in table of contents.
			omit_heading = "toc omit heading",
			omit_section = "toc omit section",
			-- Cycling list markers to use in table of contents.
			-- Use '.' and ')' for ordered lists.
			markers = { ")" },
		},
		-- Hook functions allow for overriding or extending default behavior.
		-- Called with a table of options and a fallback function with default behavior.
		-- Signature: fun(opts: table, fallback: fun())
		hooks = {
			-- Called when following links. Provided the following options:
			-- * 'dest' (string): the link destination
			-- * 'use_default_app' (boolean|nil): whether to open the destination with default application
			--   (refer to documentation on <> mappings for explanation of when this option is used)
			follow_link = nil,
		},
		on_attach = function(bufnr)
			local map = vim.keymap.set
			map({ "n" }, "<leader>mli", "<Cmd>MDListItemBelow<CR>", { buffer = bufnr, desc = "Insert List item below" })
			map(
				{ "n", "v" },
				"<leader>mlr",
				"<Cmd>MDResetListNumbering<CR>",
				{ buffer = bufnr, desc = "Fix List Numbering" }
			)
			map({ "n" }, "<leader>mti", function()
				vim.api.nvim_win_set_cursor(0, { 8, 0 }) -- move to line 8
				-- Synchronously delete the paragraph at line 8
				local start_line = 8
				local end_line = start_line
				local line_count = vim.api.nvim_buf_line_count(0)
				-- Find end of paragraph (first blank line at or after start_line)
				while end_line <= line_count do
					local line = vim.api.nvim_buf_get_lines(0, end_line - 1, end_line, false)[1]
					if line:match("^%s*$") then
						break
					end
					end_line = end_line + 1
				end
				-- Find start of paragraph (walk back to first non-blank line)
				while start_line > 1 do
					local line = vim.api.nvim_buf_get_lines(0, start_line - 2, start_line - 1, false)[1]
					if line:match("^%s*$") then
						break
					end
					start_line = start_line - 1
				end
				-- Delete the paragraph lines (0-indexed, end is exclusive)
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line - 1, false, {})
				-- Move cursor back to where the paragraph was
				vim.api.nvim_win_set_cursor(0, { start_line, 0 })
				vim.cmd("MDInsertToc") -- now runs after deletion, synchronously
			end, { buffer = bufnr, desc = "Insert TOC on line 8" })
		end,
	},
	config = function(_, opts)
		require("markdown").setup(opts)

		local wk = require("which-key")
		wk.add({
			{ "<leader>m", group = "Markdown", icon = "" },
		})
		wk.add({
			{ "<leader>ms", group = "Surrounding", icon = "󰗅" },
		})
		wk.add({
			{ "<leader>ml", group = "List Items", icon = "" },
		})
		wk.add({
			{ "<leader>mt", group = "TOC", icon = "󰠶" },
		})
	end,
}
