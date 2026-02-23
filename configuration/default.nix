{ config, lib, pkgs, username, hostname, ... }:

{
    imports = [
        ../modules/home-manager.nix

        ../modules/neovim
        ../modules/bash.nix
        ../modules/firefox.nix
        ../modules/git.nix
        ../modules/i3.nix
        ../modules/rust.nix
    ];

    boot.loader = {
        systemd-boot.enable = true;
        grub.enable = false;
        efi.canTouchEfiVariables = true;
    };
    boot.kernelPackages = pkgs.linuxPackages_zen;

    users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "networkmanager" ];
    };

    networking.networkmanager.enable = true;
    networking.hostName = "${hostname}";
    networking.firewall.enable = true;
    networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Brussels";

    fonts.packages = with pkgs; [
        liberation_ttf
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];

    services.openssh.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;

    system.autoUpgrade = {
        enable = true;
        allowReboot = false;
    };
}
