{ config, pkgs, userSettings, ... }:

{
  programs.neovim =
	let
		toLua = str: "lua << EOF\n${str}\nEOF\n";
		toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
	in
	{
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		vimdiffAlias = true;

		plugins = with pkgs.vimPlugins; [
			{
				plugin = oil-nvim;
				config = toLuaFile ./plugins/oil.lua;
			}
			{
				plugin = which-key-nvim;
				config = toLuaFile ./plugins/which-key.lua;
			}
			{
				plugin = nvim-autopairs;
				config = toLuaFile ./plugins/autopairs.lua;
			}
			{
				plugin = comment-nvim;
				config = toLuaFile ./plugins/comment.lua;
			}
			{
				plugin = indent-blankline-nvim;
				config = toLuaFile ./plugins/indent-blankline.lua;
			}
			{
				plugin = nvim-lspconfig;
				config = toLuaFile ./plugins/lspconfig.lua;
			}
			{
				plugin = lualine-nvim;
				config = toLuaFile ./plugins/lualine.lua;
			}
			{
				plugin = nvim-navic;
				config = toLuaFile ./plugins/navic.lua;
			}
			{
				plugin = nvim-cmp;
				config = toLuaFile ./plugins/cmp.lua;
			}
			{
				plugin = nvim-surround;
				config = toLuaFile ./plugins/surround.lua;
			}
			{
				plugin = telescope-nvim;
				config = toLuaFile ./plugins/telescope.lua;
			}
			{
				plugin = nvim-metals;
				config = toLuaFile ./plugins/nvim-metals.lua;
			}
			# {
			# 	plugin = nvim-jdtls;
			# 	config = toLuaFile /home/stefan/.setup/nvim/plugins/jdtls.lua;
			# }
			{
				plugin = (nvim-treesitter.withPlugins (p: [
					p.tree-sitter-nix
					p.tree-sitter-lua
					p.tree-sitter-html
					p.tree-sitter-css
					p.tree-sitter-typescript
					p.tree-sitter-javascript
					p.tree-sitter-json
					p.tree-sitter-vue
					p.tree-sitter-java
					p.tree-sitter-scala
					p.tree-sitter-python
					p.tree-sitter-bash
					p.tree-sitter-c
					p.tree-sitter-make
					p.tree-sitter-markdown
					p.tree-sitter-dockerfile
				]));
				config = toLuaFile ./plugins/treesitter.lua;
			}
			{
				plugin = nvim-treesitter-context;
				config = toLuaFile ./plugins/treesitter-context.lua;
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
			vim.cmd[[colorscheme tokyonight-moon]]
			${builtins.readFile ./options.lua}
			${builtins.readFile ./keymaps.lua}
			${builtins.readFile ./autocmds.lua}
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
		];
	};
}
