{ config, lib, pkgs, hostname, ... }:

{
    imports = [
        ../modules/base/audio.nix
        ../modules/base/boot.nix
        ../modules/base/fonts.nix
        ../modules/base/home-manager.nix
        ../modules/base/user.nix

        ../modules/neovim
        ../modules/bash.nix
        ../modules/firefox.nix
        ../modules/git.nix
        ../modules/xorg/i3.nix
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
