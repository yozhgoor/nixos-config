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
        mkFonts = pkgs: {
            main = {
                package = pkgs.liberation_ttf;
                serif = "Liberation Serif";
                sans = "Liberation Sans";
            };
            nerd = {
                package = pkgs.nerd-fonts.hack;
                name = "Hack Nerd Font";
            };
            symbols = {
                package = pkgs.nerd-fonts.symbols-only;
                name = "Symbols Nerd Font";
            };
        };
        mkTerm = pkgs: {
            package = pkgs.xterm;
            name = "xterm";
        };
        username = "yozhgoor";
        colors = {
            background = "282828";
            foreground = "ebdbb2";
            black = "1d2021";
            red = "cc241d";
            green = "98971a";
            yellow = "d79921";
            blue = "458588";
            magenta = "b16286";
            cyan = "689d6a";
            white = "a89984";

            brightBlack = "928374";
            brightRed = "fb4934";
            brightGreen = "b8bb26";
            brightYellow = "fabd2f";
            brightBlue = "83a598";
            brightMagenta = "d3869b";
            brightCyan = "8ec07c";
            brightWhite = "ebdbb2";

            orange = "d65d0e";
            brightOrange = "fe8019";
        };
    in {
        nixosConfigurations = {
            "nostromo" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    userFonts = mkFonts nixpkgs.legacyPackages.x86_64-linux;
                    term = mkTerm nixpkgs.legacyPackages.x86_64-linux;
                    inherit username;
                    inherit colors;
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
                    userFonts = mkFonts nixpkgs.legacyPackages.x86_64-linux;
                    term = mkTerm nixpkgs.legacyPackages.x86_64-linux;
                    inherit username;
                    inherit colors;
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
                    userFonts = mkFonts nixpkgs.legacyPackages.x86_64-linux;
                    term = mkTerm nixpkgs.legacyPackages.x86_64-linux;
                    inherit username;
                    inherit colors;
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
