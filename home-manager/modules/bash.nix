{ colors, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    ripgrep
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      cat = "${pkgs.bat}/bin/bat --decorations never --theme gruvbox-dark";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        format = "[](bold #${colors.green}) ";
        success_symbol = "[](bold #${colors.green}) ";
        error_symbol = "[](bold #${colors.red}) ";
      };
      directory.style = "bold #${colors.green}";
      git_branch.style = "bold #${colors.orange}";
      package.disabled = true;
    };
  };
}
