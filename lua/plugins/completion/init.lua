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
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "hrsh7th/nvim-cmp",
        },
        config = function()
          require("codeium").setup({})
        end,
      },
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
          -- completeopt = "menu,menuone,noinsert",
          keyword_length = 2,
        },
        -- how to set up boarder in nvim-cmp preview window
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            col_offset = -4,
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
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end,
          }),
          -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
          --   if cmp.visible() and has_words_before() then
          --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          --   else
          --     fallback()
          --   end
          -- end),
          -- Complete common string (similar to shell completion behavior).
          ["<C-l>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              return cmp.complete_common_string()
            end
            fallback()
          end, { "i", "c" }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif neogen.jumpable() then
              neogen.jump_next()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
        }),
        sources = cmp.config.sources({
          --           /**
          --  * The kind of a completion entry.
          --  */
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
          -- { name = "nvim_lsp_signature_help" },
          { name = "copilot", keyword_length = 1 },
          { name = "luasnip", max_item_count = 3, group_index = 2 },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, context)
              local kind = entry:get_kind()
              local line = context.cursor_line
              local col = context.cursor.col
              local char_before_cursor = string.sub(line, col - 1, col - 1)

              if char_before_cursor == "." then
                if kind == 2 or kind == 5 then
                  return true
                else
                  return false
                end
              elseif string.match(line, "^%s*%w*$") then
                if kind == 3 or kind == 6 then
                  return true
                else
                  return false
                end
              end

              return true
            end,
            group_index = 1,
            max_item_count = 3,
          },
          { name = "path", max_item_count = 3 },
          { name = "buffer", keyword_length = 4, max_item_count = 3 },
          { name = "treesitter", max_item_count = 5 },
          -- { name = "codeium", group_index = 1 },
          { name = "crates" },
        }),
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
              codeium = "(codeium)",
              copilot = "(copilot)",
            }
            local duplicates = {
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 0,
            }
            local duplicates_default = 0
            if max_width ~= 0 and #item.abbr > max_width then
              item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            item.kind = icons.kind[item.kind]
            item.menu = source_names[entry.source.name]
            item.dup = duplicates[entry.source.name] or duplicates_default

            if entry.source.name == "vim-daddod-completion" then
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

      -- Use buffer source only in Command History ('q:') window
      cmp.setup.filetype({ "vim" }, {
        sources = {
          { name = "buffer" },
        },
      })
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
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
      vim.api.nvim_exec(
        [[
          autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
          autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
        ]],
        false
      )
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
        "<A-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, remap = true, silent = true, mode = "i",
      },
      { "<A-j>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<A-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}
