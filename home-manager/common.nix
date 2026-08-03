{ lib, pkgs, term, username, ... }:

{
  imports = let
    localPath = /home/${username}/.config/local.nix;
  in [
    ./modules/bash.nix
    ./modules/dev.nix
    ./modules/firefox.nix
    ./modules/fonts.nix
    ./modules/neovim
    ./modules/${term.name}.nix
    ./modules/xdg.nix
  ] ++ lib.optional (builtins.pathExists localPath) (import localPath {
    inherit pkgs;
  });

  home.sessionPath = [
    "$HOME/.local/bin/"
  ];

  home.packages = with pkgs; [
    telegram-desktop
    spotify
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11"; # Never change this value after first installation.
}
