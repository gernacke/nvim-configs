local M = {}

function M.setup()
    local cmp = require("cmp")

    local has_any_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local press = function(key)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
    end

    -- local feedkey = function(key, mode)
    --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    -- end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
        return
    end

    require("luasnip/loaders/from_vscode").lazy_load()

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
    }

    cmp.setup({
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[luasnip]",
                    vsnip = "[vsnip]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    treesitter = "[TreeSitter]",
                    codeium = "[Codeium]",
                })[entry.source.name]
                return vim_item
            end,
        },
        --[[ formatting = {
            format = require("lspkind").cmp_format({
                mode = "symbol", -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = "...",
            }),
            source_names = {
                nvim_lsp = "(LSP)",
                -- emoji = "(Emoji)",
                path = "(Path)",
                -- calc = "(Calc)",
                -- cmp_tabnine = "(Tabnine)",
                vsnip = "(Snippet)",
                luasnip = "(Snippet)",
                buffer = "(Buffer)",
                tmux = "(TMUX)",
                -- copilot = "(Copilot)",
                treesitter = "(TreeSitter)",
            },
        }, ]]
        -- sets up the snippet engine
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = {
            ["<C-j>"] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                        -- vim.api.nvim_feedkeys(t "<Down>", "n", true)
                    end
                end,
            }),
            ["<C-k>"] = cmp.mapping({
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                    end
                end,
                i = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        -- vim.api.nvim_feedkeys(t "<Up>", "n", true)
                        fallback()
                    end
                end,
            }),
            ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            -- ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            -- ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),

            -- ["<C-Space>"] = cmp.mapping({
            --     i = function(fallback)
            --         if cmp.visible() then
            --             if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            --                 return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
            --             end
            --             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
            --         elseif has_any_words_before() then
            --             press("<Space>")
            --         else
            --             fallback()
            --         end
            --     end,
            --     c = function()
            --         if cmp.visible() then
            --             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
            --         else
            --             vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            --         end
            --     end,
            -- }),
        },
        sources = {
            { name = "nvim_lsp", max_item_count = 10 },
            { name = "nvim_lua", max_item_count = 5 },
            -- { name = "ultisnips", max_item_count = 5 },
            { name = "vsnip", max_item_count = 5 },
            { name = "luasnip", max_item_count = 5 },
            { name = "buffer", keyword_length = 4, max_item_count = 5 },
            { name = "path" },
            { name = "treesitter", max_item_count = 10 },
            { name = "codeium", max_item_count = 1 },
            -- { name = "crates" },
            -- { name = "cmp_openai_codex" },
            -- { name = "emoji" },
            -- { name = "neorg" },
            -- { name = "look" },
            -- { name = "calc" },
            -- { name = "spell" },
            -- { name = "cmp_tabnine" },
        },
        experimental = { native_menu = false, ghost_text = false },
        -- documentation = {
        --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },

        -- },
        window = {

            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 1,
                border = "rounded",
                winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = cmp.config.window.bordered(),
        },
    })

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
            { name = "path", max_item_count = 5 },
        }, {
            { name = "cmdline", max_item_count = 15 },
        }),
    })
end

function SetAutoCmp(mode)
    local cmp = require("cmp")
    if mode then
        cmp.setup({
            completion = {
                autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
            },
        })
    else
        cmp.setup({
            completion = {
                autocomplete = false,
            },
        })
    end
end
SetAutoCmp(true)

-- enable automatic completion popup on typing
vim.cmd("command AutoCmpOn lua SetAutoCmp(true)")

-- disable automatic competion popup on typing
vim.cmd("command AutoCmpOff lua SetAutoCmp(false)")

return M

--[[
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp", max_item_count = 10 },
        { name = "nvim_lua", max_item_count = 5 },
        { name = "luasnip" },
        -- { name = "ultisnips", max_item_count = 5 },
        -- { name = "vsnip", max_item_count = 5 },
        { name = "buffer", keyword_length = 5, max_item_count = 5 },
        { name = "path" },
        { name = "treesitter", max_item_count = 10 },
        -- { name = "crates" },
        -- { name = "cmp_openai_codex" },
        -- { name = "emoji" },
        { name = "neorg" },
        -- { name = "look" },
        -- { name = "calc" },
        -- { name = "spell" },
        -- { name = "cmp_tabnine" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
} ]]
