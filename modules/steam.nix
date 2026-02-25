{ config, lib, pkgs, username, ... }:

{
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            steam
            mangohud
        ];

        home.file.".config/MangoHud/MangoHud.conf".text = ''
            legacy_layout=0
            horizontal
            hud_compact
            font_size=16
            background_alpha=0.0

            fps
            cpu_stats
            gpu_stats
            ram
            vram

            frametime=0
        '';

        home.file."config/MangoHud/presets.conf".text = ''
            [preset 1]
            fps_only
            font_size=16
        '';
    };
}
