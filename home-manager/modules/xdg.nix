{ pkgs, username, ... }:

{
  home.packages = with pkgs; [
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
    projects = homeDir;
    music = homeDir;
    publicShare = homeDir;
    templates = homeDir;
    videos = homeDir;
  };
}
