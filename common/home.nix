{ config, pkgs, ... }:

{
	home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  home.stateVersion = "23.05"; # Please read the comment before changing.

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
				config = toLuaFile ./nvim/plugins/oil.lua;
			}
			{
				plugin = which-key-nvim;
				config = toLuaFile ./nvim/plugins/which-key.lua;
			}
			{
				plugin = nvim-autopairs;
				config = toLuaFile ./nvim/plugins/autopairs.lua;
			}
			{
				plugin = comment-nvim;
				config = toLuaFile ./nvim/plugins/comment.lua;
			}
			{
				plugin = indent-blankline-nvim;
				config = toLuaFile ./nvim/plugins/indent-blankline.lua;

			}
			{
				plugin = nvim-lspconfig;
				config = toLuaFile ./nvim/plugins/lspconfig.lua;
			}
			{
				plugin = lualine-nvim;
				config = toLuaFile ./nvim/plugins/lualine.lua;
			}
			{
				plugin = nvim-navic;
				config = toLuaFile ./nvim/plugins/navic.lua;
			}
			{
				plugin = nvim-cmp;
				config = toLuaFile ./nvim/plugins/cmp.lua;
			}
			{
				plugin = nvim-surround;
				config = toLuaFile ./nvim/plugins/surround.lua;
			}
			{
				plugin = telescope-nvim;
				config = toLuaFile ./nvim/plugins/telescope.lua;
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
				config = toLuaFile ./nvim/plugins/treesitter.lua;
			}
			{
				plugin = nvim-treesitter-context;
				config = toLuaFile ./nvim/plugins/treesitter-context.lua;
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
		];

		extraLuaConfig = ''
			vim.cmd[[colorscheme tokyonight-moon]]
			${builtins.readFile ./nvim/options.lua}
			${builtins.readFile ./nvim/keymaps.lua}
			${builtins.readFile ./nvim/autocmds.lua}
		'';

		extraPackages = with pkgs; [
			lua-language-server
			nil
			nodePackages.typescript-language-server
			nodePackages_latest.vscode-css-languageserver-bin
			nodePackages.volar
			jdt-language-server
			metals
		];
	};

	home.sessionPath = [
		"$HOME/.npm-global"
  ];


	programs.zsh = {
    enable = true;
		dotDir = ".config/zsh";
		defaultKeymap = "emacs";
		autocd = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		history = {
			path = "$ZDOTDIR/.zsh_history";
			save = 900000;
			size = 10000;
			extended = true;
			ignoreDups = true;
			share = true;
		};
		# historySubstringSearch = {
		# 	enable = true;
			# searchUpKey = "$key[Up]";
			# searchDownKey = "$key[Down]";
		# };
		shellAliases = {
		 ls="exa -al";
		};
		zplug = {
			enable = true;
			plugins = [
				 { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
				 # { name = "~/.config/zsh/.p10k.zsh"; tags = [ from:local defer:2 ];  }
			];
		};
    initExtra = ''
			autoload -U up-line-or-beginning-search
			autoload -U down-line-or-beginning-search
			zle -N up-line-or-beginning-search
			zle -N down-line-or-beginning-search
			bindkey "''${key[Up]}" up-line-or-beginning-search
			bindkey "''${key[Down]}" down-line-or-beginning-search
    '';
    initExtraFirst = ''
		'';
		profileExtra = ''
			setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
		'';
		completionInit = ''
			zstyle ':completion:*' completer _complete _ignored _approximate
			zstyle ':completion:*' completions 1
			zstyle ':completion:*' ignore-parents parent pwd .. directory
			zstyle ':completion:*' insert-unambiguous true
			zstyle ':completion:*' max-errors 4
			zstyle ':completion:*' menu select=1
			zstyle ':completion:*' original false

			autoload -Uz compinit
			compinit
		'';
		localVariables = {
			POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;

			POWERLEVEL9K_LEFT_PROMPT_ELEMENTS = [
				"os_icon"
				"dir"
				"vcs"
				"newline"
			];

			POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS = [
				# =========================[ Line #1 ]=========================
				"status"                  # exit code of the last command
				"command_execution_time"  # duration of the last command
				"background_jobs"         # presence of background jobs
				"direnv"                  # direnv status (https://direnv.net/)
				"asdf"                    # asdf version manager (https://github.com/asdf-vm/asdf)
				"virtualenv"              # python virtual environment (https://docs.python.org/3/library/venv.html)
				"anaconda"                # conda environment (https://conda.io/)
				"pyenv"                   # python environment (https://github.com/pyenv/pyenv)
				"goenv"                   # go environment (https://github.com/syndbg/goenv)
				"nodenv"                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
				"nvm"                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
				"nodeenv"                 # node.js environment (https://github.com/ekalinin/nodeenv)
				# "node_version"          # node.js version
				# "go_version"            # go version (https://golang.org)
				# "rust_version"          # rustc version (https://www.rust-lang.org)
				# "dotnet_version"        # .NET version (https://dotnet.microsoft.com)
				# "php_version"           # php version (https://www.php.net/)
				# "laravel_version"       # laravel php framework version (https://laravel.com/)
				# "java_version"          # java version (https://www.java.com/)
				# "package"               # name@version from package.json (https://docs.npmjs.com/files/package.json)
				"rbenv"                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
				"rvm"                     # ruby version from rvm (https://rvm.io)
				"fvm"                     # flutter version management (https://github.com/leoafarias/fvm)
				"luaenv"                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
				"jenv"                    # java version from jenv (https://github.com/jenv/jenv)
				"plenv"                   # perl version from plenv (https://github.com/tokuhirom/plenv)
				"perlbrew"                # perl version from perlbrew (https://github.com/gugod/App-perlbrew)
				"phpenv"                  # php version from phpenv (https://github.com/phpenv/phpenv)
				"scalaenv"                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
				"haskell_stack"           # haskell version from stack (https://haskellstack.org/)
				"kubecontext"             # current kubernetes context (https://kubernetes.io/)
				"terraform"               # terraform workspace (https://www.terraform.io)
				# "terraform_version"     # terraform version (https://www.terraform.io)
				"aws"                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
				"aws_eb_env"              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
				"azure"                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
				"gcloud"                  # google cloud cli account and project (https://cloud.google.com/)
				"google_app_cred"         # google application credentials (https://cloud.google.com/docs/authentication/production)
				"toolbox"                 # toolbox name (https://github.com/containers/toolbox)
				"context"                 # user@hostname
				"nordvpn"                 # nordvpn connection status, linux only (https://nordvpn.com/)
				"ranger"                  # ranger shell (https://github.com/ranger/ranger)
				"nnn"                     # nnn shell (https://github.com/jarun/nnn)
				"lf"                      # lf shell (https://github.com/gokcehan/lf)
				"xplr"                    # xplr shell (https://github.com/sayanarijit/xplr)
				"vim_shell"               # vim shell indicator (:sh)
				"midnight_commander"      # midnight commander shell (https://midnight-commander.org/)
				"nix_shell"               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
				"chezmoi_shell"           # chezmoi shell (https://www.chezmoi.io/)
				# "vi_mode"                 # vi mode (you don't need this if you've enabled prompt_char)
				# "vpn_ip"                # virtual private network indicator
				# "load"                  # CPU load
				# "disk_usage"            # disk usage
				# "ram"                   # free RAM
				# "swap"                  # used swap
				"todo"                    # todo items (https://github.com/todotxt/todo.txt-cli)
				"timewarrior"             # timewarrior tracking status (https://timewarrior.net/)
				"taskwarrior"             # taskwarrior task count (https://taskwarrior.org/)
				"per_directory_history"   # Oh My Zsh per-directory-history local/global indicator
				"cpu_arch"              	# CPU architecture
				# "time"                  # current time
				# =========================[ Line #2 ]=========================
				"newline"                 # \n
				# "ip"                    # ip address and bandwidth usage for a specified network interface
				# "public_ip"             # public IP address
				# "proxy"                 # system-wide http/https/ftp proxy
				# "battery"               # internal battery
				# "wifi"                  # wifi speed
				# "example"               # example user-defined segment (see prompt_example function below)
			];

			POWERLEVEL9K_MODE = "nerdfont-complete";
  		POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR = "·";
		};
  };

	programs.kitty = {
		enable = true;
		theme = "Alien Blood";
		font = {
			# name = "MesloLGS NF";
			# name = "FiraCode Nerd Font Mono";
			# name = "Iosevka Nerd Font Mono";
			name = "DejaVu Sans Mono";
			size = 11;
		};
		keybindings = {
			# reload config
			"ctrl+shift+r" = "load_config_file";

			# clipboard
			"ctrl+shift+c" = "copy_to_clipboard";
			"ctrl+shift+v" = "paste_from_clipboard";

			#font
			"ctrl+plus" = "change_font_size all +0.1";
			"ctrl+minus" = "change_font_size all -0.1";

			# windows
			# "ctrl+shift+enter" = "new_window";
			"ctrl+shift+enter" = "launch --cwd=current";
			"ctrl+shift+w" = "close_window";
			"ctrl+shift+right" = "next_window";
			"ctrl+shift+left" = "previous_window";
			"ctrl+shift+up" = "move_window_forward";
			"ctrl+shift+down" = "move_window_backward";
			"ctrl+shift+plus" = "start_resizing_window";


			# tabs
			"ctrl+shift+t" = "new_tab_with_cwd !neighbor";
			"ctrl+shift+q" = "close_tab";
			"ctrl+alt+right" = "move_tab_forward";
			"ctrl+alt+left" = "move_tab_backward";
			"ctrl+shift+," = "set_tab_title";
			"ctrl+shift+1" = "goto_tab 1";
			"ctrl+shift+2" = "goto_tab 2";
			"ctrl+shift+3" = "goto_tab 3";
			"ctrl+shift+4" = "goto_tab 4";
			"ctrl+shift+5" = "goto_tab 5";
			"ctrl+shift+6" = "goto_tab 6";
			"ctrl+shift+7" = "goto_tab 7";
			"ctrl+shift+8" = "goto_tab 8";
			"ctrl+shift+9" = "goto_tab 9";

			# layout
			"ctrl+shift+l" = "next_layout";
			"ctrl+alt+p" = "last_used_layout";
			"ctrl+shift+f" = "toggle_layout stack";
		};
		settings = {
			hide_window_decorations = true;
			tab_bar_edge = "top";
			tab_bar_style = "powerline";
			tab_switch_strategy = "left";
			tab_powerline_style = "slanted";
			tab_bar_align = "left";
			tab_activity_symbol = "~";
			tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index} {title}{fmt.italic}({num_windows}){fmt.noitalic}";
			active_tab_foreground = "#000";
			active_tab_background = "#eee";
			active_tab_font_style = "bold-italic";
			inactive_tab_foreground = "#444";
			inactive_tab_background = "#999";
			inactive_tab_font_style = "normal";
			tab_bar_background = "none";
			tab_bar_margin_color = "none";
			selection_foreground = "none";
			selection_background = "none";
			enable_audio_bell = "no";
			cursor_shape = "block";
		};
	};

	programs.git = {
    enable = true;
    userName  = "Stefan Kugele";
    userEmail = "stefan.kugele@gmail.com";
		extraConfig = {
			init = {
				defaultBranch = "main";
			};
			diff.tool = "vimdiff";
			merge.tool = "vimdiff";
			difftool.prompt = false;
			safe.directory = "/etc/nixos";
			core.autocrlf = "input";
		};
  };

	programs.zoxide = {
		enable = true;
	};

	gtk = {
		enable = true;
		theme.name = "Adwaita";
		# cursorTheme.name = "Vanilla-DMZ";
		# iconTheme.name = "Papirus";
	};

  # `dconf dump /org/gnome/`
  # Another way to do this is to do `dconf watch /org/gnome` and then make the changes you want and then migrate them in as you see what they are.
	dconf.settings = {
		"org/gnome/desktop/interface" = {
			enable-hot-corners=false;
			enable-animations = false;
			color-scheme= "prefer-dark";
		};
		# "org/gnome/desktop/background" = {
		# 	picture-uri-dark="file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.webp";
		# };
		"org/gnome/desktop/wm/keybindings" = {
			close = [ "<Super>w" ];
			move-to-workspace-1=[ "<Shift><Super>1" ];
			move-to-workspace-2=[ "<Shift><Super>2" ];
			move-to-workspace-3=[ "<Shift><Super>3" ];
			move-to-workspace-4=[ "<Shift><Super>4" ];
			switch-applications=[ "<Alt>Tab" ];
			switch-applications-backward=[ "<Shift><Alt>Tab" ];
			switch-to-workspace-1=[ "<Super>1" ];
			switch-to-workspace-2=[ "<Super>2" ];
			switch-to-workspace-3=[ "<Super>3" ];
			switch-to-workspace-4=[ "<Super>4" ];
			switch-windows=[ "<Super>Tab" ];
			switch-windows-backward=[ "<Shift><Super>Tab" ];
			toggle-fullscreen=[ "F11" ];
			switch-to-workspace-left = [];
			switch-to-workspace-right = [];
		};
		# https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/1250
		"org/gnome/shell/keybindings" = {
			switch-to-application-1 = [];
			switch-to-application-2 = [];
			switch-to-application-3 = [];
			switch-to-application-4 = [];
			switch-to-application-5 = [];
			switch-to-application-6 = [];
			switch-to-application-7 = [];
			switch-to-application-8 = [];
			switch-to-application-9 = [];
		};
		"org/gnome/desktop/search-providers" = {
			disabled=["org.gnome.clocks.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.Contacts.desktop" "org.gnome.Photos.desktop"];
			sort-order=[
				"org.gnome.Nautilus.desktop"
				"org.gnome.Settings.desktop"
				"org.gnome.Calendar.desktop"
				"org.gnome.Calculator.desktop"
				"org.gnome.Characters.desktop"
				"org.gnome.Photos.desktop"
				"org.gnome.clocks.desktop"
				"org.gnome.seahorse.Application.desktop"
				"org.gnome.Weather.desktop"
				"org.gnome.Contacts.desktop"
				"org.gnome.Documents.desktop"
			];
		};
		"org/gnome/settings-daemon/plugins/media-keys" = {
    	custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
  	};
  	"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
			binding = "<Shift><Super>p";
			command = "tessen --pass=pass --dmenu=rofi --action=copy";
			name = "tessen";
		};
	};

	# xdg.mimeApps = {
	# 	enable = true;
		# defaultApplications = {
		# 	"text/html" = "brave-browser.desktop";
		# 	"x-scheme-handler/http" = "brave-browser.desktop";
		# 	"x-scheme-handler/https" = "brave-browser.desktop";
		# 	"x-scheme-handler/about" = "brave-browser.desktop";
		# 	"x-scheme-handler/unknown" = "brave-browser.desktop";
		# };
  # };

	# programs.brave = {
	# 	enable = true;
	# 	extensions = [
	# 		"dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
	# 		"cofdbpoegempjloogbagkncekinflcnj" # deepl
	# 	];
 #  };

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 36000;
		defaultCacheTtlSsh = 36000;
		enableSshSupport = true;
		sshKeys = [
			"8303DB27D1F5BCF26070AE79835FC0DB530C4C71"
		];
	};

	programs.rofi = {
		enable = true;
		location = "center";
		cycle = false;
		theme = "purple";
		extraConfig = {
			show-icons = true;
		};
	};

	programs.vscode = {
		enable = true;
		extensions = [
			pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
		];
	};

  home.packages = [];
  home.file = {};
  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
