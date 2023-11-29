vim.keymap.set('', '<space>', '<nop>', {})
vim.keymap.set('', 'ö', 'l', {desc = 'Right'})
vim.keymap.set('', 'l', 'k', {desc = 'Up'})
vim.keymap.set('', 'k', 'j', {desc = 'Down'})
vim.keymap.set('', 'j', 'h', {desc = 'Left'})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'File'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc = 'Git File'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Buffer File'})
vim.keymap.set('n', '<leader>f?', builtin.help_tags, {desc = 'Help File'})
vim.keymap.set('n', '<leader>fp', builtin.oldfiles, {desc = 'Previous File'})
vim.keymap.set('n', '<leader>f/', builtin.live_grep, {desc = 'Grep Files'})
vim.keymap.set('n', '<leader>fx', builtin.commands, {desc = 'Command'})


local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
