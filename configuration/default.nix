{ config, lib, pkgs, hostname, userFonts, username, ... }:

{
  imports = [
    ../modules/bash.nix
    ../modules/firefox.nix
    ../modules/git.nix
    ../modules/home-manager.nix
    ../modules/spotify.nix
    ../modules/neovim
    ../modules/xorg/i3.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "${hostname}";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      telegram-desktop
    ];

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

  time.timeZone = "Europe/Brussels";

  security.rtkit.enable = true;
  services.pipewire.enable = true;

  fonts.packages = [
    userFonts.main.package
    userFonts.nerd.package
    userFonts.symbols.package
  ];

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
