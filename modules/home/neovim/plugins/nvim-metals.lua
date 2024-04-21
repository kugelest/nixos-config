local metals_config = require("metals").bare_config()


-- Example of settings
metals_config.settings = {
	metalsBinaryPath = '/nix/store/cc6h1m7rass3sdvc17f0zr5i8y76ymfa-metals-1.2.2/bin/metals',
	-- metalsBinaryPath = vim.fn.system('nix path-info nixpkgs#metals'),
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.init_options.statusBarProvider = "off"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

metals_config.on_attach = function(client, bufnr)
	-- your on_attach function
end


local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
