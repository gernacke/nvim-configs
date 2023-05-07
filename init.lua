require("user.options")
require("user.keymappings")
require("user.autocommands")
require("user.plugins").setup()
require("user.lsp").setup()
require("user.colorscheme")
require("user.navic")

vim.cmd [[
    source $XDG_CONFIG_HOME/nvim/lua/user/myplugins/grep-operator.vim
]]
