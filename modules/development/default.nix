{ username, ... }:

{
  imports = [
    ./git.nix
  ];

  home-manager.users.${username} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
