{ pkgs, nixgl, username, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.wezterm.package =
    let
      nixGLWrap = pkgs.symlinkJoin {
        name = "wezterm-nixgl";
        paths = [ pkgs.wezterm ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          for bin in wezterm wezterm-gui; do
            mv "$out/bin/$bin" "$out/bin/.$bin-wrapped"
            makeWrapper ${nixgl.packages.${pkgs.system}.nixGLIntel}/bin/nixGLIntel "$out/bin/$bin" \
              --add-flags "$out/bin/.$bin-wrapped"
          done
        '';
      };
    in
    nixGLWrap;

  programs.bash.initExtra = ''
    unset PROMPT_COMMAND
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';

  home.file.".local/bin/deck-clean" = {
    executable = true;
    text = ''
      #!/bin/sh
      set -eu

      config_dir="$HOME/.config/nixos-config"
      do_update=0

      usage() {
        echo "Usage: deck-clean [--update]"
        echo
        echo "  1. Garbage-collect the store"
        echo "  2. (--update) Update flake inputs"
        echo "  3. Rebuild home-manager from the local flake"
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

      echo "==> Garbage collecting before rebuild"
      nix-collect-garbage -d

      if [ "$do_update" -eq 1 ]; then
        echo "==> Updating flake inputs"
        nix flake update "$config_dir"
      fi

      echo "==> Rebuilding home-manager (deck)"
      home-manager switch --flake "$config_dir#deck"

      echo "==> Garbage collecting after rebuild"
      nix-collect-garbage -d

      echo "==> Optimising the store"
      nix store optimise
    '';
  };
}
