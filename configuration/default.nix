{ config, lib, pkgs, hostname, ... }:

{
    imports = [
        ../modules/home-manager.nix

        ../modules/audio.nix
        ../modules/boot.nix
        ../modules/fonts.nix
        ../modules/user.nix

        ../modules/neovim
        ../modules/bash.nix
        ../modules/firefox.nix
        ../modules/git.nix
        ../modules/i3.nix
        ../modules/rust.nix
    ];

    networking.hostName = "${hostname}";

    time.timeZone = "Europe/Brussels";

    nix = {
        gc.automatic = true;
        settings = {
            auto-optimise-store = true;
            experimental-features = [
                "nix-command"
                "flakes"
            ];
        };
    };

    nixpkgs.config.allowUnfree = true;

    system.autoUpgrade = {
        enable = true;
        allowReboot = false;
    };
}
