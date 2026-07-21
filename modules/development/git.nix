{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      tig
    ];

    programs.git = {
      enable = true;
      ignores = [
        "debug/"
        "target/"
        "**/*.rs.bk"

        ".envrc"
        ".direnv"
      ];
      settings = {
        user = {
          name = "${username}";
          email = "${username}@outlook.com";
        };
        core.editor = "nvim";
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

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
