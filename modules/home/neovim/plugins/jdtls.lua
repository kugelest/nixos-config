local config = {
	cmd = {
		'java', -- or '/path/to/java17_or_newer/bin/java'
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		'/nix/store/w8c5iyrsbh0i380j3l6802ih56s0044z-jdt-language-server-1.21.0/share/java/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
		'-configuration', '/nix/store/w8c5iyrsbh0i380j3l6802ih56s0044z-jdt-language-server-1.21.0/share/config/config.ini',
		-- '-data', '/path/to/unique/per/project/workspace/folder'
	},
	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
	settings = {
		java = {
		}
	},
	init_options = {
		bundles = {}
	},
}


vim.api.nvim_create_autocmd("FileType", {
	callback = function() require('jdtls').start_or_attach(config) end,
	pattern = "java"
})
