-- Create a function and keymappings to delete surrounding indentation
vim.keymap.set("n", "dsi", function()
  -- select outer indentation
  require("various-textobjs").indentation("outer", "outer")

  -- plugin only switches to visual mode when a textobj has been found
  local indentationFound = vim.fn.mode():find("V")
  if not indentationFound then
    return
  end

  -- dedent indentation
  vim.cmd.normal({ "<", bang = true })

  -- delete surrounding lines
  local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
  local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
  vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
  vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete Surrounding Indentation" })

vim.keymap.set("n", "ysii", function()
  local startPos = vim.api.nvim_win_get_cursor(0)

  -- identify start- and end-border
  require("various-textobjs").indentation("outer", "outer")
  local indentationFound = vim.fn.mode():find("V")
  if not indentationFound then
    return
  end
  vim.cmd.normal({ "V", bang = true }) -- leave visual mode so the `'<` `'>` marks are set

  -- copy them into the + register
  local startLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
  local endLn = vim.api.nvim_buf_get_mark(0, ">")[1] - 1
  local startLine = vim.api.nvim_buf_get_lines(0, startLn, startLn + 1, false)[1]
  local endLine = vim.api.nvim_buf_get_lines(0, endLn, endLn + 1, false)[1]
  vim.fn.setreg("+", startLine .. "\n" .. endLine .. "\n")

  -- highlight yanked text
  local ns = vim.api.nvim_create_namespace("ysi")
  vim.highlight.range(0, ns, "IncSearch", { startLn, 0 }, { startLn, -1 })
  vim.highlight.range(0, ns, "IncSearch", { endLn, 0 }, { endLn, -1 })
  vim.defer_fn(function()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  end, 1000)

  -- restore cursor position
  vim.api.nvim_win_set_cursor(0, startPos)
end, { desc = "Yank surrounding indentation" })

vim.keymap.set("n", "P", function()
  require("various-textobjs").lastChange()
  local changeFound = vim.fn.mode():find("v")
  if changeFound then
    vim.cmd.normal({ ">", bang = true })
  end
end)

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
        "aI",
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Outer Indentation",
      },
      {
        "iI",
        "<cmd>lua require('various-textobjs').indentation('inner', 'outer')<CR>",
        mode = { "o", "x" },
        desc = "Inner Indentation",
      },
      {
        "ai",
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

      -- {
      --   "iq",
      --   "<cmd>lua require('various-textobjs').anyQuote('inner')<CR>",
      --   mode = { "o", "x" },
      --   desc = "Any Quote (Inner)",
      -- },
      -- {
      --   "aq",
      --   "<cmd>lua require('various-textobjs').anyQuote('outer')<CR>",
      --   mode = { "o", "x" },
      --   desc = "Any Quote (Outer)",
      -- },
      --
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
        "iv",
        "<cmd>lua require('various-textobjs').lineCharacterwise('inner')<CR>",
        mode = { "o", "x" },
        desc = "Line Characterwise (Inner)",
      },
      {
        "av",
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

      { "i_", "<cmd>lua require('various-textobjs').value('inner')<CR>", mode = { "o", "x" }, desc = "Value (Inner)" },
      { "a_", "<cmd>lua require('various-textobjs').value('outer')<CR>", mode = { "o", "x" }, desc = "Value (Outer)" },

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
