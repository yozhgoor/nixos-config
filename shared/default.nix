{ nixpkgs }:

let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};

  mkFonts = pkgs: {
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

  mkTerm = pkgs: {
    package = pkgs.kitty;
    name = "kitty";
  };
in {
  inherit system pkgs;

  username = "yozhgoor";

  userFonts = mkFonts pkgs;
  term = mkTerm pkgs;

  colors = {
    background = "282828";
    lightBackground = "32302f";
    dimBackground = "1d2021";

    foreground = "ebdbb2";
    lightForeground = "fbf1c7";
    dimForeground = "a89984";

    black = "1d2021";
    red = "cc241d";
    green = "98971a";
    yellow = "d79921";
    blue = "458588";
    magenta = "b16286";
    cyan = "689d6a";
    white = "a89984";
    orange = "d65d0e";

    lightBlack = "928374";
    lightRed = "fb4934";
    lightGreen = "b8bb26";
    lightYellow = "fabd2f";
    lightBlue = "83a598";
    lightMagenta = "d3869b";
    lightCyan = "8ec07c";
    lightWhite = "ebdbb2";
    lightOrange = "fe8019";

    dimBlack = "1d2021";
    dimRed = "9d0006";
    dimGreen = "79740e";
    dimYellow = "b57614";
    dimBlue = "076678";
    dimMagenta = "8f3f71";
    dimCyan = "427b58";
    dimWhite = "928374";
    dimOrange = "af3a03";
  };
}
