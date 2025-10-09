# Configuration related to Git
{ config, lib, pkgs, shared, ... }:

{
  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      tig
    ];

    programs.git = {
      enable = true;
      userName = "${shared.username}";
      userEmail = "<email>";
      extraConfig = {
        core = {
          editor = "nvim";
          excludesFiles = ".gitignore_global";
        };
        push.autoSetupRemote = true;
        pull = {
          ff = "only";
          rebase = false;
        };
        init.defaultBranch = "main";
      };
    };

    home.file.".gitignore_global".text = ''
      debug/
      target/
      **/*.rs.bk
    '';
  };
}
