local M = {}
-- aff734c
-- fix requiring :Noerg sync-parsers every time when openinng a norg file
function M.setup()
    require("neorg").setup({
        load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.highlights"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/repositories/notes",
                        gtd = "~/repositories/Neorg/GTD",
                        neorg = "~/repositories/Neorg/",
                    },
                    index = "index.norg",
                },
            },
            ["core.norg.esupports.metagen"] = {
                config = {
                    type = "auto",
                },
            },
            ["core.norg.qol.toc"] = {},
            ["core.integrations.telescope"] = {},
            ["core.gtd.base"] = {
                config = {
                    workspace = "gtd",
                },
            },
            ["core.gtd.helpers"] = {
                config = {},
            },
            ["core.gtd.queries"] = {
                config = {},
            },
            ["core.gtd.ui"] = {
                config = {},
            },
            ["core.norg.news"] = {
                config = {
                    check_news = false,
                },
            },
        },
    })

    local neorg_callbacks = require("neorg.callbacks")

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
            n = { -- Bind keys in normal mode
                { "<C-g>", "core.integrations.telescope.find_linkable" },
            },

            i = { -- Bind in insert mode
                { "<C-l>", "core.integrations.telescope.insert_link" },
                { "<C-f>", "core.integrations.telescope.insert_file_link" },
            },
        }, {
            silent = true,
            noremap = true,
        })
    end)
end

return M
