# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, config, systemSettings, userSettings, inputs, ... }:

{
  imports = [
		../../system/hardware-configuration.nix
  ];

	# # amd gpu stuff
	# # boot.initrd.kernelModules = [ "amdgpu" ];
	# boot.initrd.kernelModules = [ "radeon" ];
	# # services.xserver.videoDrivers = [ "amdgpu" ];
	# services.xserver.videoDrivers = [ "modesetting" ];
	hardware.opengl.enable = true;
	hardware.opengl.driSupport = true;
	# hardware.opengl.extraPackages = with pkgs; [
 #  	rocmPackages.clr.icd
 #  	amdvlk
	# ];
	# environment.variables = {
 #  	ROC_ENABLE_PRE_VEGA = "1";
	# };
	# hardware.opengl.driSupport = true; # This is already enabled by default

	environment.variables = {
		ROC_ENABLE_PRE_VEGA = "1";
	};
	systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
	hardware.opengl.extraPackages = with pkgs; [
  	rocmPackages.clr.icd
		amdvlk
	];
	hardware.opengl.extraPackages32 = with pkgs; [
  	driversi686Linux.amdvlk
	];

	# environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
	environment.variables.AMD_VULKAN_ICD = "RADV";


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


    # Bootloader.
	boot = {
  	loader = {
			grub = {
				enable = true;
				device = "/dev/sda";
				useOSProber = true;
				configurationLimit = 10;
			};
			timeout = 2;
		};
	};

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Enable networking
  networking = {
  	# hostName = "nixos";
  	# hostName = hostName;
		# interfaces = {
		# 	eth0.ipv4.addresses = [{
		# 		address = "192.168.178.20";
		# 		prefixLength = 24;
		# 	}];
		# };
  	hostName = systemSettings.hostname;
		enableIPv6 = true;
		networkmanager = {
			enable = true;
			# insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
			# unmanaged = [ "wlp3s0" ];
		};
  	# wireless = {
			# enable = true;
			# networks."eduroam".psk = "<psk>";
		# };
		# extraHosts = ''
		# 	139.144.183.163 server
		# '';
		firewall.enable = false;
	};

	security.sudo.extraConfig = ''
		Defaults timestamp_timeout=120
	'';

  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };


  # Enable the GNOME Desktop Environment.
	services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
	# services.displayManager.sddm.enable = true;
	# services.desktopManager.plasma6.enable = true;
	# environment.gnome.excludePackages = (with pkgs; [
	# 	gnome-photos
	# 	gnome-tour
	# 	geoclue2
	# ]) ++ (with pkgs.gnome; [
	# 	gnome-music
	# 	gnome-terminal
	# 	epiphany # web browser
	# 	geary # email reader
	# 	totem # video player
	# ]);
	services.displayManager.autoLogin.enable = true;
	services.displayManager.autoLogin.user = "stefan";
	systemd.services."getty@tty1".enable = false;
	systemd.services."autovt@tty1".enable = false;


	# services.gnome.gnome-keyring.enable = lib.mkForce false;

  # Configure keymap in X11
  services.xserver = {
		xkb = {
			layout =	systemSettings.keymap;
			variant = "";
			options = "caps:escape";
		};
  };

  # Configure console keymap
  # console.keyMap = systemSettings.keymap;
	console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

	# services.syncthing = {
	# 	enable = true;
	# 	user = "stefan";
	# 	dataDir = "/home/stefan";
	# 	configDir = "/home/stefan/.config/syncthing";
	# 	overrideDevices = true;     # overrides any devices added or deleted through the WebUI
	# 	overrideFolders = true;     # overrides any folders added or deleted through the WebUI
	# 	devices = {
	# 		"server" = { id = "GFXJA2R-2R3PUVX-EQFOUZJ-XY4QD4Y-PM4SEOK-CBNKDNS-MR6YCC7-SI3ZRA5"; };
	# 	};
	# 	folders = {
	# 		"studium" = {        # Name of folder in Syncthing, also the folder ID
	# 			path = "/home/stefan/studium";    # Which folder to add to Syncthing
	# 			devices = [ "server" ];      # Which devices to share the folder with
	# 			ignorePerms = false;     # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
	# 		};
	# 		"bewerbungen" = {        # Name of folder in Syncthing, also the folder ID
	# 			path = "/home/stefan/bewerbungen";    # Which folder to add to Syncthing
	# 			devices = [ "server" ];      # Which devices to share the folder with
	# 			ignorePerms = false;     # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
	# 		};
	# 		"zsh_history" = {        # Name of folder in Syncthing, also the folder ID
	# 			path = "/home/stefan/.config/zsh";    # Which folder to add to Syncthing
	# 			devices = [ "server" ];      # Which devices to share the folder with
	# 			ignorePerms = false;     # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
	# 		};
	# 	};
	# 	extraOptions = {
	# 		gui = {
	# 			username = "stefan";
	# 			password = "N`1/<H1^t^K,KarF";
	# 			address = "0.0.0.0:8384";
	# 		};
	# 	};
	# };

	# hardware.pulseaudio.enable = true;
	# hardware.pulseaudio.support32Bit = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "sound" "libvirtd" "networkmanager" "wheel" "docker" ];
  };

	programs.steam = {
  	enable = true;
		# remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		# dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	};

	environment.etc."current-system-packages".text =
  let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;


  environment.systemPackages = with pkgs; [
		man-pages
		man-pages-posix
		firefox
		chromium
		libreoffice
		openvpn3
		wl-clipboard
		jetbrains.idea-community
		oh-my-git
		vscodium
		xclip
		syncthing
		obs-studio
		mpv
		zsh-completions
		transmission
		vcv-rack
		usbutils
		alsa-utils
		unzip
    vim
		reaper
		nix-tree
		yabridge
		tldr
		yabridgectl
		gcc
		wget
		fzf
		kitty
		pass
		zoxide
		eza
		ripgrep
		fd
		rofi
		fastfetch
		tree
		gnumake
		thunderbird
		feh
		vulkan-tools
		mesa
  	mesa-demos
		# pkg-config
		# go
  ];
	# ++
	# [
	# 	nixpkgs-vcv-rack.vcv-rack
	# ];

	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			ubuntu_font_family
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			dejavu_fonts
			liberation_ttf
			(nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "DroidSansMono" ]; })
			meslo-lgs-nf
		];
		# fontconfig = {
		# 	defaultFonts = {
		# 		monospace = [ "Ubuntu Monospace" ];
		# 	};
		# };
	};

	virtualisation.docker.enable = true;

	documentation.dev.enable = true;

	# use gpg-agent instead of ssh-agent
	programs.ssh.startAgent = false;
	environment.shellInit = ''
		export SYSTEMD_COLORS=1

    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

	# programs.gnupg = {
	# 	agent = {
	# 		enable = true;
	# 		enableSSHSupport = true;
	# 	};
	# };

	# environment.pathsToLink = [ "/share/zsh" ];

	programs.zsh = {
		enable = true;
	};
		# promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	# };
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];


	programs.htop = {
		enable = true;
	};


	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?

}
