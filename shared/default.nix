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
    package = pkgs.alacritty;
    name = "alacritty";
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
    brightBlack = "928374";
    brightRed = "fb4934";
    brightGreen = "b8bb26";
    brightYellow = "fabd2f";
    brightBlue = "83a598";
    brightMagenta = "d3869b";
    brightCyan = "8ec07c";
    brightWhite = "ebdbb2";
    orange = "d65d0e";
    brightOrange = "fe8019";
  };
}
