{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnumake
    gcc

    rustup

    cargo-release
  ];

  home.sessionVariables = {
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
  };
}
