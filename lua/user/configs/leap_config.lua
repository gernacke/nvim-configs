local keymap = vim.keymap

require("leap").set_default_keymaps()

keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-backward-to)')
