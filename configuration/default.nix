{ colors, config, hostname, lib, pkgs, term, userFonts, username, ... }:

{
  imports = [
    ../modules/audio.nix
    ../modules/bash.nix
    ../modules/development
    ../modules/firefox.nix
    ../modules/home-manager.nix
    ../modules/neovim
    ../modules/${term.name}.nix
    ../modules/wayland
  ];

  boot = {
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
    extraGroups = [ "wheel" "video" "networkmanager" ];
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
      path = /etc/nixos/local.nix;
    in lib.optional (builtins.pathExists path) (import path {
      inherit colors username;
    });
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
