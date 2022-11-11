require('hop').setup()

-- vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('v', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap('v', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>j', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('v', '<leader>j', "<cmd>lua require'hop'.hint_lines()<cr>", {})
