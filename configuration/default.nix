{ config, hostname, lib, pkgs, term, userFonts, username, ... }:

{
  imports = [
    ../modules/bash.nix
    ../modules/home-manager.nix
    ../modules/neovim
    ../modules/audio.nix

    ../modules/wayland
    ../modules/${term.name}.nix
    ../modules/firefox.nix

    ../modules/development
  ];

  boot ={
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = hostname;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      telegram-desktop
      spotify
    ];

    xdg.userDirs = let
      base = "/home/${username}";
    in {
      enable = true;
      createDirectories = true;
      download = "${base}/downloads";
      documents = "${base}/documents";
      desktop = base;
      music = base;
      pictures = base;
      publicShare = base;
      templates = base;
      videos = base;
    };
  };

  time.timeZone = "Europe/Brussels";

  fonts.packages = [
    userFonts.main.package
    userFonts.nerd.package
    userFonts.symbols.package
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  system.autoUpgrade.enable = true;
}
