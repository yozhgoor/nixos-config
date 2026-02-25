{ inputs, config, pkgs, username, ... }:

{
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            rustup
            gcc

            cargo-release
        ];

        home.file.".cargo/config.toml".text = ''
            [net]
            git-fetch-with-cli = true
        '';
    };
}
