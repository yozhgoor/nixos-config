{ config, lib, pkgs, username, ... }:

{
    home-manager.users.${username} = {
        home.packages = with pkgs; [
            steam
            mangohud
        ];

        home.file.".local/bin/120hz" = {
            executable = true;
            text = ''
                #!/bin/sh

                ${pkgs.xrandr}/bin/xrandr --output DP-2 --mode 1920x1080 --refresh 120.0

                "$@"

                ${pkgs.xrandr}/bin/xrandr --output DP-2 --mode 1920x1080 --refresh 60.0
            '';
        };

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

        home.file.".config/MangoHud/presets.conf".text = ''
            [preset 1]
            fps_only
            font_size=16
        '';
    };
}
