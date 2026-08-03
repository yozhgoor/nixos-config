{ username, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
}
