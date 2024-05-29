local metals_config = require("metals").bare_config()


-- Example of settings
metals_config.settings = {
	-- metalsBinaryPath = '/nix/store/cc6h1m7rass3sdvc17f0zr5i8y76ymfa-metals-1.2.2/bin/metals',
	metalsBinaryPath = vim.trim(vim.fn.system('nix path-info nixpkgs#metals')) .. '/bin/metals',
	showImplicitArguments = true,
	excludedPackages = {},
	autoImportBuild = "all",
}

metals_config.init_options.statusBarProvider = "off"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

metals_config.on_attach = function(client, bufnr)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
	vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references)
	vim.keymap.set('n', '<space>p', function()
		vim.lsp.buf.format { async = true }
	end)
end


local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
