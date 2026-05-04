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

  outputs = { nixpkgs, ... }@inputs: let
    shared = import ./shared { inherit nixpkgs; };

    mkHost = hostname: modules: nixpkgs.lib.nixosSystem {
      system = shared.system;
      specialArgs = {
        inherit hostname;
        username = shared.username;
        colors = shared.colors;
        userFonts = shared.userFonts;
        term = shared.term;
      };
      modules = modules ++ [
        ./configuration/${hostname}

        inputs.home-manager.nixosModules.home-manager
        inputs.nixvim.nixosModules.nixvim
        inputs.nur.modules.nixos.default
      ];
    };
  in {
    nixosConfigurations = {
      sanctuary = mkHost "sanctuary" [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
      ];
      atlantis = mkHost "atlantis" [];
    };

    devShells.${shared.system} = import ./dev-shells.nix {
      pkgs = shared.pkgs;
    };
  };
}
