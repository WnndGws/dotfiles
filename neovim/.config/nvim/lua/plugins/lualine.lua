return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("lazyvim.config").icons
            local Util = require("lazyvim.util")
            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1,
                                right = 0,
                            },
                        },
                        {
                            "filename",
                            path = 0,
                            shortening_target = 40,
                            symbols = { modified = "  ", readonly = "", unnamed = "" },
                        },
                    },
                    lualine_x = {
                        {
                            function()
                                bufnr = 0
                                line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
                                opts = { ["lnum"] = line_nr }
                                local line_diagnostics = vim.diagnostic.get(bufnr, opts)
                                if vim.tbl_isempty(line_diagnostics) then
                                    return
                                end
                                local best_diagnostic = nil
                                for _, diagnostic in ipairs(line_diagnostics) do
                                    if best_diagnostic == nil or diagnostic.severity < best_diagnostic.severity then
                                        best_diagnostic = diagnostic
                                    end
                                end
                                if not best_diagnostic or not best_diagnostic.message then
                                    return
                                end
                                local message = vim.split(best_diagnostic.message, "\n")[1]
                                local max_width = 90
                                if string.len(message) < max_width then
                                    return message
                                else
                                    return string.sub(message, 1, max_width) .. "..."
                                end
                            end,
                        },
                        {
                            function()
                                return "  " .. require("dap").status()
                            end,
                            cond = function()
                                return package.loaded["dap"] and require("dap").status() ~= ""
                            end,
                            color = Util.ui.fg("Debug"),
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = Util.ui.fg("Special"),
                        },
                    },
                    lualine_y = {
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_z = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                },
                extensions = { "neo-tree", "lazy" },
            }
        end,
    },
}
