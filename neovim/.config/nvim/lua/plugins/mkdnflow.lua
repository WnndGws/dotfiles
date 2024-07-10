local Plugin = { "jakewvincent/mkdnflow.nvim" }

Plugin.dependencies = {
	{ "nvim-lua/plenary.nvim" },
}

Plugin.config = function()
	local mkdn = require("mkdnflow")
	mkdn.setup({
        modules = {
            bib = true,
            buffers = true,
            conceal = true,
            cursor = true,
            folds = false,
            foldtext = true,
            links = true,
            lists = true,
            maps = true,
            paths = true,
            tables = true,
            yaml = true,
            cmp = true,
        },
        perspective = {
            priority = 'current',
            fallback = 'current',
            root_tell = false,
            nvim_wd_heel = true,
            update = false
        },
        wrap = true,
        links = {
            style = 'markdown',
            name_is_source = false,
            conceal = true,
            context = 0,
            implicit_extension = nil,
            transform_implicit = false,
            transform_explicit = function(text)
                text = text:gsub(" ", "-")
                text = text:lower()
                -- text = os.date('%Y-%m-%d_')..text
                return(text)
            end,
            create_on_follow_failure = true
        },
        new_file_template = {
            use_template = true,
            template = [[
---
Title: {{ title }}
Date Created: {{ date }}
Filename: {{ filename }}
Tags: ["", "", ""]
bib: /home/wynand/git/wiki/references.bib
---

<!-- toc -->]],
                placeholders = {
                    before = {
                        date = function()
                            return os.date("%A, %B %d %Y") -- Wednesday, March 1, 2023
                        end
                    },
                    after = {
                        filename = function()
                            return vim.api.nvim_buf_get_name(0)
                        end
                    }
                }
        },
	})
end

return Plugin
