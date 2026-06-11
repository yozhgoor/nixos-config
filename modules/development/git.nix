{ pkgs, username, ... }:

{
  services.openssh.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      tig
    ];

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "${username}";
          email = "${username}@outlook.com";
        };
        core = {
          editor = "nvim";
          excludesFile = "~/.gitignore_global";
        };
        push.autoSetupRemote = true;
        pull = {
          ff = "only";
          rebase = false;
        };
        fetch.prune = true;
        init.defaultBranch = "main";
        url = {
          "git@github.com:".insteadOf = "https://github.com/";
        };
      };
    };

    home.file.".gitignore_global".text = ''
      debug/
      target/
      **/*.rs.bk

      .envrc
      .direnv
    '';

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
