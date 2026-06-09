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
    ../modules/pdf.nix

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
  networking.networkmanager.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
  };

  time.timeZone = "Europe/Brussels";

  fonts.packages = [
    userFonts.main.package
    userFonts.nerd.package
    userFonts.symbols.package
  ];

  home-manager.users.${username} = {
    home.sessionPath = [
      "$HOME/.local/bin/"
    ];

    home.packages = with pkgs; [
      telegram-desktop
      spotify

      xdg-utils
    ];

    xdg.userDirs = let
      base = "/home/${username}";
    in {
      enable = true;
      createDirectories = true;
      download = "${base}/downloads";
      documents = "${base}/documents";
      pictures = "${base}/pictures";
      desktop = base;
      music = base;
      publicShare = base;
      templates = base;
      videos = base;
    };

    services.keybase.enable = true;
    services.kbfs.enable = true;

    imports = let
      path = /etc/nixos/secrets.nix;
    in lib.optional (builtins.pathExists path) path;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      alsa-plugins
      pipewire
      libx11
      libxcursor
      libxrandr
      libxi
      libxkbcommon
      wayland
      vulkan-loader
      mesa
      libGL
      openssl
    ];
  };

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
