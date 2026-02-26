{ config, lib, pkgs, username, userFonts, hostname, ... }:

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
        efi.canTouchEfiVariables = true;
    };
    boot.kernelPackages = pkgs.linuxPackages_zen;

    users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "networkmanager" ];
    };

    home-manager.users.${username} = {
        xdg.userDirs = let
            base = "/home/${username}";
        in {
            enable = true;
            createDirectories = true;
            download = "${base}/downloads";
            desktop = base;
            documents = base;
            music = base;
            pictures = base;
            publicShare = base;
            templates = base;
            videos = base;
        };
    };

    networking.hostName = "${hostname}";
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;
    networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Brussels";

    fonts.packages = [
        userFonts.main.package
        userFonts.nerd.package
        userFonts.symbols.package
    ];

    services.openssh.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
    };

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
