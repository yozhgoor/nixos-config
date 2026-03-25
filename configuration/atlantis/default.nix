{ lib, pkgs, username, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../default.nix

        ../../modules/steam.nix
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.libinput.enable = true;

    home-manager.users.${username} = {
        home.packages = with pkgs; [
            spotify
            telegram-desktop
        ];

        imports = let
            path = /etc/nixos/secrets.nix;
        in lib.optional (builtins.pathExists path) path;
    };

    # This option defines the first version of NixOS you have installed on this particular machine
    # and is used to maintain compatibility with application data (e.g. databases) created on older
    # NixOS version.
    system.stateVersion = "25.11"; # NEVER change this value after the initial install.
}
