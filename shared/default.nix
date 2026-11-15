{ system, nixpkgs, ... }:

rec {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  userFonts = {
    size = "12";
    main = {
      package = pkgs.liberation_ttf;
      serif = "Liberation Serif";
      sans = "Liberation Sans";
    };
    nerd = {
      package = pkgs.nerd-fonts.terminess-ttf;
      name = "Terminess Nerd Font";
    };
    symbols = {
      package = pkgs.openmoji-color;
      name = "OpenMoji Color";
    };
  };

  term = {
    package = pkgs.wezterm;
    name = "wezterm";
    bin = "${pkgs.wezterm}/bin/wezterm";
  };


  colors = {
    black = "000000";
    red = "ff0000";
    green = "00ff00";
    yellow = "ffb000";
    blue = "0000ff";
    magenta = "a000ff";
    cyan = "00ffff";
    white = "ffffff";

    lightBlack = "808080";
    lightRed = "ff6666";
    lightGreen = "ffcc33";
    lightYellow = "ffcc33";
    lightBlue = "6666ff";
    lightMagenta = "c266ff";
    lightCyan = "66ffff";
    lightWhite = "f2f2f2";

    background = "000000";
    lightBackground = "1a1a1a";

    foreground = "ffffff";
    lightForeground = "f2f2f2";

    orange = "ff8000";
    lightOrange = "ffad66";
  };
}
