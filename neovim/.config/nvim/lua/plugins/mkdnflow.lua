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
            foldtext = false,
            links = true,
            lists = true,
            maps = true,
            paths = true,
            tables = true,
            yaml = true,
            cmp = true
        },
        filetypes = {md = true, rmd = true, markdown = true, wiki = true},
        create_dirs = true,
        perspective = {
            priority = 'current',
            fallback = 'root',
            root_tell = false,
            nvim_wd_heel = true,
            update = false
        },
        wrap = true,
        bib = {
            default_path = nil,
            find_in_root = false
        },
        silent = false,
        cursor = {
            jump_patterns = nil
        },
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
            },
            template =[[
---
Title: {{ title }}
Date Created: {{ date }}
Filename: {{ filename }}
Tags: ["", "", ""]
bib: /home/wynand/git/wiki-mdbook/src/references.bib"
---

]],
        },
        to_do = {
            symbols = {' ', '-', 'X'},
            update_parents = true,
            not_started = ' ',
            in_progress = '-',
            complete = 'X'
        },
        foldtext = {
            object_count = true,
            object_count_icons = 'emoji',
            object_count_opts = function()
                return require('mkdnflow').foldtext.default_count_opts()
            end,
            line_count = true,
            line_percentage = true,
            word_count = false,
            title_transformer = nil,
            separator = ' · ',
            fill_chars = {
                left_edge = '⢾',
                right_edge = '⡷',
                left_inside = ' ⣹',
                right_inside = '⣏ ',
                middle = '⣿',
            },
        },
        tables = {
            trim_whitespace = true,
            format_on_move = true,
            auto_extend_rows = false,
            auto_extend_cols = false,
            style = {
                cell_padding = 1,
                separator_padding = 1,
                outer_pipes = true,
                mimic_alignment = true
            }
        },
        yaml = {
            bib = { override = true }
        },
	})
end

return Plugin
