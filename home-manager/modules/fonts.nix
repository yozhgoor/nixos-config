{ pkgs, userFonts, ... }:

{
  home.packages = with pkgs; [
    userFonts.main.package
    userFonts.nerd.package
    userFonts.symbols.package
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ userFonts.nerd.name ];
      sansSerif = [ userFonts.main.sans ];
      serif = [ userFonts.main.serif ];
      emoji = [ userFonts.symbols.name ];
    };
  };
}
