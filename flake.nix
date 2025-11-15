{
  description = "Nix configuration for the Shevek host";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cli-config = {
      url = "github:hayesHowYaDoin/cli_config";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    desktop-config = {
      url = "github:hayesHowYaDoin/desktop_config";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    cli-config,
    desktop-config,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    user = {
      name = "jordan";
      home = "/home/jordan";
      fullName = "Jordan Hayes";
      gitUser = "hayesHowYaDoin";
      gitEmail = "jordanhayes98@gmail.com";
    };
  in {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user;};
        modules = [
          ./host/configuration.nix
          stylix.nixosModules.stylix
        ];
      };
    };

    homeConfigurations = {
      default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs pkgs user;};
        modules = [
          ./home/default.nix
          cli-config.homeManagerModules.default
          desktop-config.homeManagerModules.default
          stylix.homeModules.stylix
        ];
      };
    };
  };
}
