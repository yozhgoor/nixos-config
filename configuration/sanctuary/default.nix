{ inputs, config, lib, pkgs, username, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../default.nix
    ];

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
    };

    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersafe";

            DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
            DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
            DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";

            USB_AUTOSUSPEND = 0;
        };
    };

    services.libinput = {
        enable = true;
        touchpad = {
            disableWhileTyping = true;
        };
    };

    home-manager.users.${username}.programs.git.settings = let
        path = /etc/nixos/secrets.nix;
    in lib.optionalAttrs (
        builtins.pathExists path
    ) {
        url = (import path).url;
    };

    # This option defines the first version of NixOS you have installed on this particular machine
    # and is used to maintain compatibility with application data (e.g. databases) created on older
    # NixOS version.
    system.stateVersion = "25.11"; # NEVER change this value after the initial install.
}
