local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.jdtls.setup {
	-- capabilities = capabilities,
	cmd = { "jdt-language-server", "-configuration", "/home/stefan/.cache/jdtls/config", "-data", "/home/stefan/.cache/jdtls/workspace" },
}


lspconfig.lua_ls.setup {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	},
	capabilities = capabilities,
}

lspconfig.volar.setup {
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
	capabilities = capabilities,
}

lspconfig.nil_ls.setup {
	capabilities = capabilities,
}

-- lspconfig.metals.setup {
-- 	capabilities = capabilities,
-- }

--Enable (broadcasting) snippet capability for completion
local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup {
	capabilities = cap,
	cmd = { "css-languageserver", "--stdio" }
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_deep_extend("error", opts, { desc = "rename" }))
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>p', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
