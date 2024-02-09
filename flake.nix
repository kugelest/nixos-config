{
  description = "NixOS Configuration";

  inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

	outputs = inputs@{ nixpkgs, home-manager, ... }:
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

		lib = nixpkgs.lib;

	in {

		nixosConfigurations = {
			system = lib.nixosSystem {
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
				];
				specialArgs = {
					# inherit nixpkgs;
					inherit systemSettings;
          inherit userSettings;
				};
      };
    };


  };
}
