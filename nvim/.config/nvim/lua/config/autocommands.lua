-------------------
--- Autocommands---
-------------------

local uv = vim.loop

--- Use tmux-rename upon launching nvim ---
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
		end
	end,
})

--- Write md buffers as you leave them
vim.api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "set awa" })
-- Use the following if your buffer is set to become hidden
vim.api.nvim_create_autocmd("BufLeave", { pattern = "*.md", command = "silent! wall" })

-- Run all commands in interactive so that I can use bash
vim.api.nvim_create_autocmd("VimEnter", { pattern = "*", command = "let &shell='/bin/bash -i'" })

--- Fix Clipboard in WSL ---
if not vim.env.SSH_TTY then
	-- only set clipboard if not in ssh, to make sure the OSC 52
	-- integration works automatically. Requires Neovim >= 0.10.0
	-- WSL Clipboard support
	if is_wsl then
		-- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
		-- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
		vim.g.clipboard = {
			name = "WslClipboard",
			copy = {
				["+"] = "clip.exe",
				["*"] = "clip.exe",
			},
			paste = {
				["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
				["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			},
			cache_enabled = 0,
		}
	end
	if is_linux then
		vim.g.clipboard = {
			copy = {
				["+"] = "wl-copy --trim-newline",
				["*"] = "wl-copy --trim-newline",
			},
			paste = {
				["+"] = "wl-paste",
				["*"] = "wl-paste",
			},
		}
	end
end
