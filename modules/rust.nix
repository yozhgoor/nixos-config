{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      gnumake
      rustup
      gcc

      cargo-release
      cargo-readme
      cargo-msrv
      cargo-audit
    ];

    home.file.".cargo/config.toml".text = ''
      [net]
      git-fetch-with-cli = true
    '';

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
