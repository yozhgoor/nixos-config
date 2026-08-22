{ pkgs, nixgl, username, ... }:

{
  imports = [
    ./common.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.wezterm.package =
    let
      nixGLWrap = pkgs.symlinkJoin {
        name = "wezterm-nixgl";
        paths = [ pkgs.wezterm ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          for bin in wezterm wezterm-gui; do
            mv "$out/bin/$bin" "$out/bin/.$bin-wrapped"
            makeWrapper ${nixgl.packages.${pkgs.system}.nixGLIntel}/bin/nixGLIntel "$out/bin/$bin" \
              --add-flags "$out/bin/.$bin-wrapped"
          done
        '';
      };
    in
    nixGLWrap;

  programs.bash.initExtra = ''
    unset PROMPT_COMMAND
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';
}
