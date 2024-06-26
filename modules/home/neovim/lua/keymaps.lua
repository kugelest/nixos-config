vim.keymap.set('', '<space>', '<nop>', {})
vim.keymap.set('', 'ö', 'l', {desc = 'Right'})
vim.keymap.set('', 'l', 'k', {desc = 'Up'})
vim.keymap.set('', 'k', 'j', {desc = 'Down'})
vim.keymap.set('', 'j', 'h', {desc = 'Left'})


local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() telescope.find_files({hidden = true, no_ignore = true}) end, {desc = 'File'})
vim.keymap.set('n', '<leader>fg', telescope.git_files, {desc = 'Git File'})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {desc = 'Buffer File'})
vim.keymap.set('n', '<leader>f?', telescope.help_tags, {desc = 'Help File'})
vim.keymap.set('n', '<leader>fp', telescope.oldfiles, {desc = 'Previous File'})
vim.keymap.set('n', '<leader>f/', telescope.live_grep, {desc = 'Grep Files'})
vim.keymap.set('n', '<leader>fx', telescope.commands, {desc = 'Command'})
vim.keymap.set('n', '<leader>fs', telescope.lsp_dynamic_workspace_symbols, {desc = 'Symbols'})
vim.keymap.set('n', '<leader>fr', telescope.lsp_references, {desc = 'References'})


local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)


local metals_tvp = require("metals.tvp")
vim.keymap.set('n', '<leader>mt', metals_tvp.toggle_tree_view, {desc = 'Toggle [t]ree view'})
vim.keymap.set('n', '<leader>mr', metals_tvp.reveal_in_tree, {desc = '[R]eveal in tree'})


local oil = require("oil")
vim.keymap.set('n', '-', oil.open, {desc = 'Oil'})
