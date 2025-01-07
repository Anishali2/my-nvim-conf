{
    "DaikyXendo/nvim-material-icon",
    lazy = false,
    priority = 1000,
    config = function()
        local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
        local material_icons_ok, material_icons = pcall(require, "nvim-material-icons")

        if web_devicons_ok and material_icons_ok then
            local icons = material_icons.get_icons()

            -- Add folder-specific overrides
            icons[".git"] = { icon = "", color = "#F14C28", name = "GitFolder" }
            icons["node_modules"] = { icon = "", color = "#E7A713", name = "NodeModules" }
            icons["src"] = { icon = "", color = "#5A9E6F", name = "SrcFolder" }
            icons["app"] = { icon = "", color = "#4E88C2", name = "AppFolder" }
            icons["home"] = { icon = "", color = "#FAB795", name = "HomeFolder" }
            icons["functions"] = { icon = "", color = "#C678DD", name = "FunctionsFolder" }
            icons["hooks"] = { icon = "ﯠ", color = "#98C379", name = "HooksFolder" }
            icons["api"] = { icon = "", color = "#56B6C2", name = "ApiFolder" }
            icons["extensions"] = { icon = "", color = "#E5C07B", name = "ExtensionsFolder" }
            icons["plugins"] = { icon = "", color = "#61AFEF", name = "PluginsFolder" }
            icons["core"] = { icon = "", color = "#D19A66", name = "CoreFolder" }

            -- Explicitly define the folder override behavior
            web_devicons.set_icon({
                -- Your folder-specific overrides
                [".git"] = icons[".git"],
                ["node_modules"] = icons["node_modules"],
                ["src"] = icons["src"],
                ["app"] = icons["app"],
                ["home"] = icons["home"],
                ["functions"] = icons["functions"],
                ["hooks"] = icons["hooks"],
                ["api"] = icons["api"],
                ["extensions"] = icons["extensions"],
                ["plugins"] = icons["plugins"],
                ["core"] = icons["core"],
            })

            web_devicons.setup({
                override = icons,
                default = true,
            })
        end
    end,
},

