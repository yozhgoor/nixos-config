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

    outputs = { self, nixpkgs, ... }@inputs: let
        username = "yozhgoor";
    in {
        nixosConfigurations = {
            "nostromo" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit username;
                    hostname = "nostromo";
                };
                modules = [
                    ./configuration/nostromo

                    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x270
                    inputs.home-manager.nixosModules.home-manager
                    inputs.nixvim.nixosModules.nixvim
                    inputs.nur.modules.nixos.default
                ];
            };
            "sanctuary" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit username;
                    hostname = "sanctuary";
                };
                modules = [
                    ./configuration/sanctuary

                    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
                    inputs.home-manager.nixosModules.home-manager
                    inputs.nixvim.nixosModules.nixvim
                    inputs.nur.modules.nixos.default
                ];
            };
            "atlantis" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit username;
                    hostname = "atlantis";
                };
                modules = [
                    ./configuration/atlantis

                    inputs.home-manager.nixosModules.home-manager
                    inputs.nixvim.nixosModules.nixvim
                    inputs.nur.modules.nixos.default
                ];
            };
        };
    };
}
