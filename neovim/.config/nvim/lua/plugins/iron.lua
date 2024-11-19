local Plugin = { "hkupty/iron.nvim" }

Plugin.event = "InsertEnter"

function Plugin.config()
	local iron = require("iron.core")

	-- See :help cmp-config
	iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          python = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "python" },

          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require("iron.view").right(60),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<leader>rc",
        visual_send = "<leader>rc",
        send_file = "<leader>rf",
        send_line = "<leader>rl",
        send_mark = "<leader>rm",
        mark_motion = "<leader>rmc",
        mark_visual = "<leader>rmc",
        remove_mark = "<leader>rmd",
        cr = "<leader>r<cr>",
        interrupt = "<leader>r<leader>",
        exit = "<leader>rq",
        clear = "<leader>rx",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

 Plugin.keys = {
	{
		"<leader>rs",
        "<cmd>IronRepl<cr>",
		desc = "Open IronRepl",
	},
	{
		"<leader>rr",
        "<cmd>IronRestart<cr>",
		desc = "Restart IronRepl",
	},
	{
		"<leader>rF",
        "<cmd>IronFocus<cr>",
		desc = "Focus IronRepl",
	},
	{
		"<leader>rh",
        "<cmd>IronHide<cr>",
		desc = "Hide IronRepl",
	},
}
end

return Plugin
