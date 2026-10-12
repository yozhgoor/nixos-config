{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      default_agent = "plan";

      agent = {
        plan.model = "deepseek/deepseek-v4-pro";
        build.model = "deepseek/deepseek-v4.1-flash";
      };
    };

    tui.theme = "gruvbox";
  };
}
