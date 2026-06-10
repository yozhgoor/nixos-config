{ colors, userFonts, username, ... }:

{
  home-manager.users.${username} = {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        default-bg = "#${colors.background}";
        default-fg = "#${colors.foreground}";
        font = "${userFonts.nerd.name} 9";
        recolor = "true";
        recolor-darkcolor = "#${colors.lightForeground}";
        recolor-lightcolor = "#${colors.lightBackground}";
      };
    };
  };
}
