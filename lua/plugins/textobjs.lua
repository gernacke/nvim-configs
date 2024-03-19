return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true, lookForwardSmall = 50, lookForwardBig = 50 })
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
    enabled = true,
    keys = {
      { "ie", "<cmd>lua require('various-textobjs').entireBuffer()<CR>", mode = { "o", "x" }, desc = "Entire Buffer" },
      {
        "<leader>;",
        "<cmd>lua require('various-textobjs').multiCommentedLines()<CR>",
        mode = { "o", "x" },
        desc = "Select Commented Lines",
      },
    },
  },
  { "axieax/urlview.nvim", enabled = false, cmd = { "UrlView" } },
}
