local Plugin = { "jakewvincent/mkdnflow.nvim" }

Plugin.dependencies = {
	{ "nvim-lua/plenary.nvim" },
}

Plugin.config = function()
	local mkdn = require("mkdnflow")
	mkdn.setup({
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
                text = os.date('%Y-%m-%d_')..text
                return(text)
            end,
            create_on_follow_failure = true
        },
        new_file_template = {
            use_template = true,
            placeholders = {
                before = {
                    title = "link_title",
                    date = "os_date"
                },
                after = {}
            },
            template = "# {{ title }}"
        },
	})
end

return Plugin
