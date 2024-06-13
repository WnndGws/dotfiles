local Plugin = { "lervag/wiki.vim" }
Plugin.lazy = false
Plugin.priority = 950

Plugin.init = function()
    vim.g.wiki_root = "~/git/wiki/"
    vim.g.wiki_mappings_prefix = "<leader>x"
    vim.g.wiki_mappings_use_defaults = "none"
    vim.g.wiki_toc_depth = 4
    vim.g.wiki_link_schemes = {
        jira = {
            resolver = function(url)
                return {
                    scheme = "https",
                    stripped = "frogco.atlassian.net/browse/" .. url.stripped,
                    url = "https://frogco.atlassian.net/browse/" .. url.stripped,
                }
            end,
        },
    }
    vim.g.wiki_templates = {
        {
            match_re = "\\d\\d\\d\\d-\\d\\d-\\d\\d",
            source_filename = "/home/wynand/git/wiki/templates/daily.md"
        },
    }
end

Plugin.keys = {
    { "<leader>xi", "<cmd>WikiIndex<cr>", desc="Open wiki index"},
    { "<leader>xp", "<cmd>WikiPages<cr>", desc="List wiki files in current wiki"},
    { "<leader>xo", "<cmd>WikiOpen<cr>", desc="Open wiki file"},
    { "<leader>xr", "<cmd>WikiReload<cr>", desc="Reload wiki plugin"},
    { "<leader>xb", "<cmd>WikiGraphFindBacklinks<cr>", desc="Find backlinks to current page"},
    { "<leader>xg", "<cmd>WikiGraphRelated<cr>", desc="Show all page relations"},
    { "<leader>xlb", "<cmd>WikiGraphCheckLinksG<cr>", desc="Check entire wiki for broken links"},
    { "<leader>xlo", "<cmd>WikiGraphCheckOrphans<cr>", desc="Check entire wiki for pages with no incoming links"},
    { "<leader>xla", "<cmd>WikiLinkAdd<cr>", desc="Add links"},
    { "<leader>xln", "<cmd>WikiLinkNext<cr>", desc="Go to next link"},
    { "<leader>xlp", "<cmd>WikiLinkPrev<cr>", desc="Go to previous link"},
    { "<leader>xlf", "<cmd>WikiLinkFollow<cr>", desc="Create or follow a link"},
    { "<cr>", "<cmd>WikiLinkFollow<cr>", desc="Create or follow a link"},
    { "<leader>xlb", "<cmd>WikiLinkReturn<cr>", desc="Return to previous"},
    { "<bs>", "<cmd>WikiLinkReturn<cr>", desc="Return to previous"},
    { "<leader>xli", "<cmd>WikiLinkShow<cr>", desc="Show info about current link"},
    { "<leader>xtg", "<cmd>WikiTocGenerate<cr>", desc="Create/Update Table of Contents"},
    { "<leader>xtl", "<cmd>WikiTocGenerateLocal<cr>", desc="Create/Update Table of Contents (Local)"},
    { "<leader>xs", "<cmd>WikiPages<cr>", desc="Search for page"},
}

return Plugin
