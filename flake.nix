{
  description = "NixOS Configuration";

  inputs = {
		# nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# helix.url = "github:helix-editor/helix/master";
  };


	# {lib, config, options, pkgs, modulesPath, ...}: //auto-passed parameters
	outputs = { self, nixpkgs, home-manager, ... }@inputs :
	let
		systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "desktop"; # hostname
      profile = "personal"; # select a profile defined from my profiles directory
      timezone = "Europe/Berlin"; # select timezone
      locale = "de_DE.UTF-8"; # select locale
			keymap = "de";
    };

		userSettings = {
      username = "stefan"; # username
			name = "Stefan";
		};

	in {

		# nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
		nixosConfigurations."${systemSettings.hostname}" = nixpkgs.lib.nixosSystem {
			system = systemSettings.system;
			modules = [
				(./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix")
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.${userSettings.username} = import ./profiles/personal/home.nix;
					home-manager.extraSpecialArgs = {
						inherit userSettings;
					};
				}
				{
          _module.args = {
						inherit systemSettings;
						inherit userSettings;
						inherit inputs;
					};
        }
			];
			# specialArgs = {
			# 	inherit systemSettings;
			# 	inherit userSettings;
			# };
		};

	};
}
