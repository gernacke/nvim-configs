local keymap = vim.keymap

require("leap").setup({})

keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')
