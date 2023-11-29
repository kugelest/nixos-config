# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  # imports = [ # Include the results of the hardware scan.
  #   ./hardware-configuration.nix
  # ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking = {
  	# hostName = "nixos";
  	# hostName = hostName;
  	hostName = "desktop";
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
		extraHosts = ''
			139.144.183.163 server
		'';
		firewall.enable = false;
	};

	security.sudo.extraConfig = ''
		Defaults timestamp_timeout=60
	'';

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = (with pkgs; [
		gnome-tour
	]) ++ (with pkgs.gnome; [
	]);

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

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


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stefan = {
    isNormalUser = true;
    description = "Stefan";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		man-pages
		man-pages-posix
		docker-compose
		firefox
		wl-clipboard
		xclip
		syncthing
		unzip
    vim
		# python39
		# brave
		gcc
		wget
		# nodejs_20
		fzf
		kitty
		gnupg
		git
		pass
		zoxide
		eza
		ripgrep
		fd
		rofi
		# tessen
		neofetch
		tree
		gnumake
		thunderbird
		feh
  ];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		dejavu_fonts
		liberation_ttf
		(nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "DroidSansMono" ]; })
		meslo-lgs-nf
	];

	documentation.dev.enable = true;

	# use gpg-agent instead of ssh-agent
	programs.ssh.startAgent = false;
	environment.shellInit = ''
		export SYSTEMD_COLORS=1

    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];


	programs.htop = {
		enable = true;
	};

	virtualisation.docker.enable = true;

	# virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
