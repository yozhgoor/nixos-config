{ system, nixpkgs, ... }:

let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  inherit pkgs;

  userFonts = {
    main = {
      package = pkgs.liberation_ttf;
      serif = "Liberation Serif";
      sans = "Liberation Sans";
    };
    nerd = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack Nerd Font";
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
    black = "1d2021";
    red = "cc241d";
    green = "98971a";
    yellow = "d79921";
    blue = "458588";
    magenta = "b16286";
    cyan = "689d6a";
    white = "a89984";

    lightBlack = "928374";
    lightRed = "fb4934";
    lightGreen = "b8bb26";
    lightYellow = "fabd2f";
    lightBlue = "83a598";
    lightMagenta = "d3869b";
    lightCyan = "8ec07c";
    lightWhite = "ebdbb2";

    background = "282828";
    lightBackground = "32302f";

    foreground = "ebdbb2";
    lightForeground = "fbf1c7";

    orange = "d65d0e";
    lightOrange = "fe8019";
  };
}
