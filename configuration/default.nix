{ hostname, pkgs, userFonts, username, ... }:

{
  imports = [
    ../home-manager
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

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
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
}
