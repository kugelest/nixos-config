{ config, pkgs, userSettings, lib, ... }:

{
  programs.neovim =
	let
		plugin_path = ./lua/plugins;
	in
	{
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		vimdiffAlias = true;

		plugins = with pkgs.vimPlugins; [
			{
				plugin = neodev-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/neodev.lua");
			}
			{
				plugin = oil-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/oil.lua");
			}
			{
				plugin = which-key-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/which-key.lua");
			}
			{
				plugin = nvim-autopairs;
				type = "lua";
				config = lib.readFile(plugin_path + "/autopairs.lua");
			}
			{
				plugin = comment-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/comment.lua");
			}
			{
				plugin = indent-blankline-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/indent-blankline.lua");
			}
			{
				plugin = nvim-lspconfig;
				type = "lua";
				config = lib.readFile(plugin_path + "/lspconfig.lua");
			}
			{
				plugin = lualine-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/lualine.lua");
			}
			{
				plugin = nvim-navic;
				type = "lua";
				config = lib.readFile(plugin_path + "/navic.lua");
			}
			{
				plugin = nvim-cmp;
				type = "lua";
				config = lib.readFile(plugin_path + "/cmp.lua");
			}
			{
				plugin = nvim-surround;
				type = "lua";
				config = lib.readFile(plugin_path + "/surround.lua");
			}
			{
				plugin = telescope-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/telescope.lua");
			}
			{
				plugin = fidget-nvim;
				type = "lua";
				config = lib.readFile(plugin_path + "/fidget.lua");
			}
			{
				plugin = nvim-metals;
				type = "lua";
				config = lib.readFile(plugin_path + "/nvim-metals.lua");
			}
			# {
			# 	plugin = nvim-jdtls;
			# 	config = toLuaFile /home/stefan/.setup/nvim/plugins/jdtls.lua;
			# }
			{
				plugin = nvim-treesitter.withAllGrammars;
				type = "lua";
				config = lib.readFile(plugin_path + "/treesitter.lua");
			}
			{
				plugin = nvim-treesitter-context;
				type = "lua";
				config = lib.readFile(plugin_path + "/treesitter-context.lua");
			}
			nvim-treesitter-textobjects
			vim-repeat
			gitsigns-nvim
			tokyonight-nvim
			luasnip
			cmp_luasnip
			cmp-nvim-lsp
			cmp-path
			cmp-cmdline
			cmp-buffer
			plenary-nvim
		];

		extraLuaConfig = ''
			vim.cmd 'colorscheme tokyonight-moon'
			${lib.readFile ./lua/options.lua}
			${lib.readFile ./lua/keymaps.lua}
			${lib.readFile ./lua/autocmds.lua}
		'';

		extraPackages = with pkgs; [
			lua-language-server
			nil
			nodePackages.typescript-language-server
			nodePackages_latest.vscode-css-languageserver-bin
			nodePackages.volar
			jdt-language-server
			metals
			coursier
			jdk17
			bloop
		];
	};
}
