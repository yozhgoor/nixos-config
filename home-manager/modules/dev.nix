{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
        name = "yozhgoor";
        email = "yozhgoor@outlook.com";
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
}
