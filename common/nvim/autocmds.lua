-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = "*",
})

-- checktime on these events. (For better autoread after git checkout)
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

--- Remove all trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[:%s/\s\+$//e]],
})

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
	command = [[set formatoptions-=cro]]
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})




-- dont delete clipboard on close
-- vim.api.nvim_create_autocmd(
-- 	"VimLeave",
-- 	{ callback = function() vim.fn.system('xclip -o | xclip -selection c', { detach = true }) end }
-- )
