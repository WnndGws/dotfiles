-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

-- Set XDG folders

-- Always show statusline
opt.laststatus = 2

-- Save history
opt.history = 1000

-- Spelling stuff
opt.spelllang = { "en_au" }
opt.spell = false

-- Wrapping

opt.wrap = true
opt.linebreak = true
