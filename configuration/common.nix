{ hostname, lib, pkgs, userFonts, username, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap.enable = true;

  fileSystems."/boot".options = lib.mkForce [ "umask=0077" ];

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  services.resolved.enable = true;

  programs.fuse.enable = true;

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

  home-manager.users.${username}.home.file.".local/bin/nixos-clean" = {
    executable = true;
    text = ''
      #!/bin/sh
      set -eu

      config_dir="$HOME/.config/nixos-config"
      do_update=0

      usage() {
        echo "Usage: nixos-clean [--update]"
        echo
        echo "  1. Garbage-collect the store"
        echo "  2. (--update) Update flake inputs"
        echo "  3. Rebuild the system from the local flake"
        echo "  4. Garbage-collect again to remove old generations"
        echo "  5. Optimise the store"
        exit 1
      }

      for arg in "$@"; do
        case "$arg" in
          --update) do_update=1 ;;
          -h|--help) usage ;;
          *) echo "Unknown argument: $arg" >&2; usage ;;
        esac
      done

      sudo -v

      echo "==> Garbage collecting before rebuild"
      sudo nix-collect-garbage -d

      if [ "$do_update" -eq 1 ]; then
        echo "==> Updating flake inputs"
        nix flake update "$config_dir"
      fi

      echo "==> Rebuilding system (${hostname})"
      sudo nixos-rebuild switch --flake "$config_dir#${hostname}"

      echo "==> Garbage collecting after rebuild"
      sudo nix-collect-garbage -d

      echo "==> Optimising the store"
      nix store optimise
    '';
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
