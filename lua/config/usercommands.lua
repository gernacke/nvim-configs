vim.api.nvim_create_user_command("DotfilesPicker", function()
  Snacks.picker.files({
    cwd = os.getenv("HOME") .. "/repositories/all-dotfiles/",
    prompt = " 󱁼 Find Dot File 󰅂 ",
    finder = "files",
    format = "file",
    show_empty = true,
    hidden = true,
    follow = true,
    untracked = false,
    exclude = { "*.glsl", "nvim/", "nvim-legacy/" },
  })
end, {})

vim.api.nvim_create_user_command("NvimConfigsPicker", function()
  Snacks.picker.files({
    cwd = os.getenv("HOME") .. "/repositories/all-dotfiles/nvim/",
    prompt = " 󱁼 Find Nvim Configs 󰅂 ",
    finder = "files",
    format = "file",
    show_empty = true,
    hidden = true,
    follow = true,
    untracked = false,
    exclude = { "oil:/", "luac/" },
  })
end, {})
