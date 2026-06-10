{ pkgs, ... }:

{
  rust = pkgs.mkShell {
    packages = with pkgs; [
      gnumake
      gcc
      rustup

      cargo-release
      cargo-rdme
      cargo-msrv
      cargo-audit
      cargo-temp
    ];

    shellHook = ''
      export CARGO_NET_GIT_FETCH_WITH_CLI=true
    '';
  };

  python = pkgs.mkShell {
    packages = with pkgs; [
      python3
      uv
      ruff
      ty
    ];
  };
}
