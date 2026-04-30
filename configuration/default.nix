{ config, hostname, lib, pkgs, userFonts, username, ... }:

{
  imports = [
    ../modules/alacritty.nix
    ../modules/audio.nix
    ../modules/bash.nix
    ../modules/firefox.nix
    ../modules/dev/git.nix
    ../modules/home-manager.nix
    ../modules/spotify.nix
    ../modules/neovim
  ];

  boot ={
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "${hostname}";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      telegram-desktop
      flameshot
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
