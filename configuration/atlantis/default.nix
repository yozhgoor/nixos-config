{ inputs, config, pkgs, ... }:

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

    networking.wireless.networks = {
        Ilfaitbeau.pskRaw = "ext:ilfaitbeau_psk";
        "WiFi-5.0-FC57".pskRaw = "ext:fc57_psk";
    };

    # This option defines the first version of NixOS you have installed on this particular machine
    # and is used to maintain compatibility with application data (e.g. databases) created on older
    # NixOS version.
    system.stateVersion = "25.11"; # NEVER change this value after the initial install.
}
