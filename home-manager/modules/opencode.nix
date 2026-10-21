{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      default_agent = "plan";

      agent = {
        plan.model = "opencode-go/deepseek-v4-pro";
        build.model = "opencode-go/deepseek-v4.1-flash";
      };

      plugin = [
        "superpowers@git+https://github.com/obra/superpowers.git"
      ];
    };

    tui.theme = "gruvbox";
  };
}
