{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = let
      chat = "opencode/mimo-v2.6-flash-free";
      plan = "opencode/nemotron-3-ultra-free";
      build = "opencode/big-pickle";
    in {
      model = plan;
      small_model = chat;
      default_agent = "plan";

      agent = {
        plan.model = plan;
        build.model = build;

        chat = {
          model = chat;
          mode = "primary";
          description = "General knowledge chatbot. Web-only, no file access.";
          prompt = ''
            You are a general-purpose web chatbot. Answer questions directly and concisely. You
            cannot read or edit files, run commands, or browse the project. Use websearch/webfetch
            for current info.
          '';
          permission = {
            read = "deny";
            edit = "deny";
            bash = "deny";
            glob = "deny";
            grep = "deny";
            list = "deny";
            websearch = "allow";
            webfetch = "allow";
          };
        };
      };
    };

    tui.theme = "gruvbox";
  };
}
