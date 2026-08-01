{ colors, lib, pkgs, term, userFonts, username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit colors term userFonts username; };

  home-manager.users.${username} = {
    imports = let
      localPath = /home/${username}/.config/local.nix;
    in [
      ./bash.nix
      ./dev.nix
      ./firefox.nix
      ./${term.name}.nix
    ] ++ lib.optional (builtins.pathExists localPath) (import localPath {
      inherit pkgs;
    });

    home.sessionPath = [
      "$HOME/.local/bin/"
    ];

    home.packages = with pkgs; [
      telegram-desktop
      spotify

      xdg-utils
    ];

    xdg.userDirs = let
      homeDir = "/home/${username}";
    in {
      enable = true;

      createDirectories = true;
      setSessionVariables = false;

      download = "${homeDir}/downloads";
      documents = "${homeDir}/documents";
      pictures = "${homeDir}/pictures";
      desktop = "${homeDir}/desktop";
      projects = "${homeDir}/projects";
      music = homeDir;
      publicShare = homeDir;
      templates = homeDir;
      videos = homeDir;
    };

    services.keybase.enable = true;
    services.kbfs.enable = true;

    programs.home-manager.enable = true;

    home.stateVersion = "25.11"; # Never change this value after first installation.
  };
}
