return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = false, lookForwardSmall = 50, lookForwardBig = 50 })
      vim.keymap.set("n", "gx", function()
        -- select URL
        require("various-textobjs").url()
        -- plugin only switches to visual mode when textobj found
        local foundURL = vim.fn.mode():find("v")
        -- if not found, search whole buffer via urlview.nvim instead
        -- if not foundURL then
        --   vim.cmd.UrlView("buffer")
        --   return
        -- end
        -- retrieve URL with the z-register as intermediary
        vim.cmd.normal({ '"zy', bang = true })
        local url = vim.fn.getreg("z")

        -- open with the OS-specific shell command
        local opener
        if vim.fn.has("macunix") == 1 then
          opener = "open"
        elseif vim.fn.has("linux") == 1 then
          opener = "xdg-open"
        elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
          opener = "start"
        end
        local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
        os.execute(openCommand)
      end, { desc = "Smart URL Opener" })
    end,
    -- event = "VeryLazy",
    keys = {
      { "ie", "<cmd>lua require('various-textobjs').entireBuffer()<CR>", mode = { "o", "x" }, desc = "Entire Buffer" },
      {
        "ii",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Inner Indentation",
      },
      {
        "ai",
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Outer Indentation",
      },
      {
        "iI",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Inner Indentation",
      },
      {
        "aI",
        "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
        mode = { "o", "x" },
        desc = "Outer Indentation",
      },

      {
        "ig",
        "<cmd>lua require('various-textobjs').greedyOuterIndentation('inner')<CR>",
        mode = { "o", "x" },
        desc = "Greedy Outer Indentation (Inner)",
      },
      {
        "ag",
        "<cmd>lua require('various-textobjs').greedyOuterIndentation('outer')<CR>",
        mode = { "o", "x" },
        desc = "Greedy Outer Indentation (Outer)",
      },

      {
        "iS",
        "<cmd>lua require('various-textobjs').subword('inner')<CR>",
        mode = { "o", "x" },
        desc = "Subword (Inner)",
      },
      {
        "aS",
        "<cmd>lua require('various-textobjs').subword('outer')<CR>",
        mode = { "o", "x" },
        desc = "Subword (Outer)",
      },

      {
        "C",
        "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>",
        mode = { "o", "x" },
        desc = "To Next Closing Bracket",
      },

      {
        "Q",
        "<cmd>lua require('various-textobjs').toNextQuotationMark()<CR>",
        mode = { "o", "x" },
        desc = "To Next Quotation Mark",
      },

      {
        "iq",
        "<cmd>lua require('various-textobjs').anyQuote('inner')<CR>",
        mode = { "o", "x" },
        desc = "Any Quote (Inner)",
      },
      {
        "aq",
        "<cmd>lua require('various-textobjs').anyQuote('outer')<CR>",
        mode = { "o", "x" },
        desc = "Any Quote (Outer)",
      },

      {
        "io",
        "<cmd>lua require('various-textobjs').anyBracket('inner')<CR>",
        mode = { "o", "x" },
        desc = "Any Bracket (Inner)",
      },
      {
        "ao",
        "<cmd>lua require('various-textobjs').anyBracket('outer')<CR>",
        mode = { "o", "x" },
        desc = "Any Bracket (Outer)",
      },

      {
        "r",
        "<cmd>lua require('various-textobjs').restOfParagraph()<CR>",
        mode = { "o", "x" },
        desc = "Rest of Paragraph",
      },

      { "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>", mode = { "o", "x" }, desc = "Near End of Line" },

      { "g;", "<cmd>lua require('various-textobjs').lastChange()<CR>", mode = { "o", "x" }, desc = "Last Change" },

      {
        "i_",
        "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<CR>",
        mode = { "o", "x" },
        desc = "Line Characterwise (Inner)",
      },
      {
        "a_",
        "<cmd>lua require('various-textobjs').lineCharacterwise('outer')<CR>",
        mode = { "o", "x" },
        desc = "Line Characterwise (Outer)",
      },

      { "|", "<cmd>lua require('various-textobjs').column()<CR>", mode = { "o", "x" }, desc = "Column" },

      {
        "<leader>;",
        "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
        mode = { "o", "x" },
        desc = "Multi-Commented Lines",
      },

      -- { "iN", "<cmd>lua require('various-textobjs').notebookCell('inner')<CR>", mode = { "o", "x" }, desc = "Notebook Cell (Inner)" },
      -- { "aN", "<cmd>lua require('various-textobjs').notebookCell('outer')<CR>", mode = { "o", "x" }, desc = "Notebook Cell (Outer)" },

      { "iv", "<cmd>lua require('various-textobjs').value('inner')<CR>", mode = { "o", "x" }, desc = "Value (Inner)" },
      { "av", "<cmd>lua require('various-textobjs').value('outer')<CR>", mode = { "o", "x" }, desc = "Value (Outer)" },

      { "ik", "<cmd>lua require('various-textobjs').key('inner')<CR>", mode = { "o", "x" }, desc = "Key (Inner)" },
      { "ak", "<cmd>lua require('various-textobjs').key('outer')<CR>", mode = { "o", "x" }, desc = "Key (Outer)" },

      -- { "ie", "<cmd>lua require('various-textobjs').url()<CR>", mode = { "o", "x" }, desc = "URL" },

      {
        "iN",
        "<cmd>lua require('various-textobjs').number('inner')<CR>",
        mode = { "o", "x" },
        desc = "Number (Inner)",
      },
      {
        "aN",
        "<cmd>lua require('various-textobjs').number('outer')<CR>",
        mode = { "o", "x" },
        desc = "Number (Outer)",
      },

      -- { "ie", "<cmd>lua require('various-textobjs').diagnostic()<CR>", mode = { "o", "x" }, desc = "Diagnostic" },

      {
        "iz",
        "<cmd>lua require('various-textobjs').closedFold('inner')<CR>",
        mode = { "o", "x" },
        desc = "Closed Fold (Inner)",
      },
      {
        "az",
        "<cmd>lua require('various-textobjs').closedFold('outer')<CR>",
        mode = { "o", "x" },
        desc = "Closed Fold (Outer)",
      },

      {
        "im",
        "<cmd>lua require('various-textobjs').chainMember('inner')<CR>",
        mode = { "o", "x" },
        desc = "Chain Member (Inner)",
      },
      {
        "am",
        "<cmd>lua require('various-textobjs').chainMember('outer')<CR>",
        mode = { "o", "x" },
        desc = "Chain Member (Inner)",
      },

      {
        "gw",
        "<cmd>lua require('various-textobjs').visibleInWindow()<CR>",
        mode = { "o", "x" },
        desc = "Visible Window",
      },
      { "gW", "<cmd>lua require('various-textobjs').restOfWindow()<CR>", mode = { "o", "x" }, desc = "Rest of Window" },
    },
  },
  { "axieax/urlview.nvim", enabled = false, cmd = { "UrlView" } },
}
