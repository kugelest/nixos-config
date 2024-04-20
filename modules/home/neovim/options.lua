-- vim.g["no_man_maps"] = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- "foo-bar" should count as one word
vim.opt.iskeyword:append("-")
vim.opt_global.shortmess:remove("F")

local options = {
	autochdir = false,
	autoindent = true,
	autoread = true,
	clipboard = "unnamedplus",                          -- allows neovim to access the system clipboard
	cmdheight = 0,                                  -- more space in the neovim command line for displaying messages
	completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
	-- conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true,                              -- highlight the current line
	-- cursorcolumn = true,
	fileencoding = "utf-8",                         -- the encoding written to a file
	-- guifont = "monospace:h17", -- the font used in graphical neovim applications
	hidden = true,
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true,
	-- laststatus = 3,
	mouse = "a",          -- allow tHe mouse to be used in neovim
	number = true,        -- set numbered lines
	numberwidth = 4,      -- set number column width to 2 {default 4}
	-- pumheight = 10, -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 0,        -- is one of my fav
	shiftwidth = 2,       -- the number of spaces inserted for each indentation
	showmode = false,     -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1,      -- always show tabs
	sidescrolloff = 8,
	signcolumn = "yes",
	smartcase = true,  -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- FORce all vertical splits to go to the right of current window
	swapfile = true,   -- creatEs a swapfile
	tabstop = 2,       -- insert 2 spaces for a tab
	termguicolors = true,
	timeout = true,
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 250, -- faster completion (4000ms default)
	-- wrap = false, -- display lines as one long line
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Keep signcolumn on by default
-- vim.wo.signcolumn = 'yes'

-- Decrease update time
-- vim.o.updatetime = 250
-- vim.o.timeout = true
-- vim.o.timeoutlen = 300
