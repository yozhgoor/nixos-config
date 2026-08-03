{
  description = "Yozhgoor's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      sanctuary = let
        system = "x86_64-linux";
        username = "yozhgoor";
        hostname = "sanctuary";
        shared = import ./shared { inherit system nixpkgs; };
      in nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit hostname;
          inherit username;
          inherit (shared) colors term userFonts;
        };
        modules = [
          ./configuration/sanctuary

          inputs.home-manager.nixosModules.home-manager
          inputs.nur.modules.nixos.default
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd

          {
            home-manager.sharedModules = [
              inputs.nixvim.homeModules.nixvim
              { programs.nixvim.nixpkgs.source = nixpkgs.outPath; }
            ];
          }
        ];
      };
    };

    homeConfigurations = {
      "deck" = let
        system = "x86_64-linux";
        username = "deck";
        shared = import ./shared { inherit system nixpkgs; };
      in inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = shared.pkgs;
        extraSpecialArgs = {
          inherit username;
          inherit (shared) colors term userFonts;
        };
        modules = [
          ./home-manager/deck.nix

          inputs.nur.modules.homeManager.default
          inputs.nixvim.homeModules.nixvim
          { programs.nixvim.nixpkgs.source = nixpkgs.outPath; }
        ];
      };
    };
  };
}
