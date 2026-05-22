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
    package = pkgs.wezterm;
    name = "wezterm";
  };
in {
  inherit system pkgs;

  username = "yozhgoor";

  userFonts = mkFonts pkgs;
  term = mkTerm pkgs;

  colors = {
    background = "282828";
    foreground = "ebdbb2";

    black = "1d2021";
    red = "cc241d";
    green = "98971a";
    yellow = "d79921";
    blue = "458588";
    magenta = "b16286";
    cyan = "689d6a";
    white = "a89984";

    lightBackground = "32302f";
    lightForeground = "fbf1c7";

    lightBlack = "928374";
    lightRed = "fb4934";
    lightGreen = "b8bb26";
    lightYellow = "fabd2f";
    lightBlue = "83a598";
    lightMagenta = "d3869b";
    lightCyan = "8ec07c";
    lightWhite = "ebdbb2";

    orange = "d65d0e";
  };
}
