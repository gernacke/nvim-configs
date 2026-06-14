return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "octaltree/cmp-look",
      "hrsh7th/cmp-emoji",
      {
        "jcdickinson/http.nvim",
        build = "cargo build --workspace --release",
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local neogen = require("neogen")
      local icons = require("config.icons")
      local lspkind = require("lspkind")
      local kind_mapper = require("cmp.types").lsp.CompletionItemKind
      local kind_score = {
        Text = 1,
        Field = 2,
        Method = 3,
        Function = 4,
        Constructor = 5,
        Variable = 6,
        Class = 7,
        Interface = 8,
        Module = 9,
        Property = 10,
        Unit = 11,
        Value = 12,
        Enum = 13,
        Keyword = 14,
        Snippet = 15,
        Color = 16,
        File = 17,
        Reference = 18,
        Folder = 19,
        EnumMember = 20,
        Constant = 21,
        Struct = 22,
        Event = 23,
        Operator = 24,
        TypeParameter = 25,
      }
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      -- local has_words_before = function()
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert,noselect,popup",
          keyword_length = 2,
        },
        -- how to set up boarder in nvim-cmp preview window
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            col_offset = -4,
            -- border = { " ", "▔", " ", "▕", " ", "▁", " ", "▏" },
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
          }),
          -- border = "rounded",
          -- winhighlight = "Normal:MyPmenu,NormalFloat:yPmenu,CursorLine:PmenuSel,Search:None",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping({
            -- If you didn't select any item and the option table contains `select = true`
            -- nvim-cmp will automatically select the first item.
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
          }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif neogen.jumpable() then
              neogen.jump_next()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", "c" }),

          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        }),
        --  * The kind of a completion entry.
        -- export namespace CompletionItemKind {
        -- 	export const Text = 1;
        -- 	export const Method = 2;
        -- 	export const Function = 3;
        -- 	export const Constructor = 4;
        -- 	export const Field = 5;
        -- 	export const Variable = 6;
        -- 	export const Class = 7;
        -- 	export const Interface = 8;
        -- 	export const Module = 9;
        -- 	export const Property = 10;
        -- 	export const Unit = 11;
        -- 	export const Value = 12;
        -- 	export const Enum = 13;
        -- 	export const Keyword = 14;
        -- 	export const Snippet = 15;
        -- 	export const Color = 16;
        -- 	export const File = 17;
        -- 	export const Reference = 18;
        -- 	export const Folder = 19;
        -- 	export const EnumMember = 20;
        -- 	export const Constant = 21;
        -- 	export const Struct = 22;
        -- 	export const Event = 23;
        -- 	export const Operator = 24;
        -- 	export const TypeParameter = 25;
        -- }
        sources = cmp.config.sources({
          -- { name = "nvim_lsp_signature_help" },
          {
            name = "nvim_lsp",
            keyword_length = 2,
            group_index = 1,
            -- max_item_count = 3,
          },
          { name = "luasnip", max_item_count = 5, group_index = 2 },
          { name = "path", max_item_count = 3, group_index = 3 },
          { name = "treesitter", max_item_count = 5, group_index = 2 },
          { name = "crates", group_index = 2 },
        }, {
          { name = "buffer", keyword_length = 4, max_item_count = 3, group_index = 2 },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            function(entry1, entry2)
              local kind1 = kind_score[kind_mapper[entry1:get_kind()]] or 100
              local kind2 = kind_score[kind_mapper[entry2:get_kind()]] or 100

              if kind1 < kind2 then
                return true
              end
            end,
          },
        },
        formatting = {
          -- fields = { "kind", "abbr" },
          -- format = function(_, vim_item)
          --   vim_item.kind = cmp_kinds[vim_item.kind] or ""
          --   return vim_item
          -- end,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local max_width = 0
            local source_names = {
              nvim_lsp = "(lsp)",
              path = "(path)",
              luasnip = "(snippet)",
              buffer = "(buffer)",
              treesitter = "(treesitter)",
              look = "(look)",
              crates = "(crates)",
            }
            -- dup - when non-zero this match will be added even when an
            -- item with the same word is already present.
            local duplicates = {
              buffer = 0,
              path = 1,
              nvim_lsp = 1,
              luasnip = 0,
            }
            local duplicates_default = 0
            if max_width ~= 0 and #item.abbr > max_width then
              item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            item.kind = icons.kind[item.kind]
            item.menu = source_names[entry.source.name]
            item.dup = duplicates[entry.source.name] or duplicates_default

            if entry.source.name == "vim-dadbod-completion" then
              item.kind = ""
              item.menu = "(sql)"
            elseif entry.source.name == "crates" then
              item.kind = " "
              item.menu = "(crates)"
            end
            return item
          end,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })
      cmp.setup.filetype({ "taskedit", "help" }, {
        sources = {
          { name = "path" },
          { name = "buffer" },
        },
      })

      -- Use buffer source only in Command History ('q:') window
      cmp.setup.filetype({ "vim" }, {
        sources = {
          { name = "buffer" },
        },
      })
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<Tab>"] = cmp.mapping({
            -- If you didn't select any item and the option table contains `select = true`
            -- nvim-cmp will automatically select the first item.
            c = function(fallback)
              if cmp.visible() then
                -- 'Tab' confirms the highlighted selection,
                -- or selects the first item if nothing's highlighted
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end,
          }),
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Auto pairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

      function SetAutoCmp(mode)
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

      -- Database completion
      vim.cmd([[
        autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
      ]])
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "honza/vim-snippets",
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()

          -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
          -- are stored in `ls.snippets._`.
          -- We need to tell luasnip that "_" contains global snippets:
          require("luasnip").filetype_extend("all", { "_" })
        end,
      },
    },
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<A-k>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, remap = true, silent = true, mode = "i",
      },
      { "<A-k>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<A-j>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}
