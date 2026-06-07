{ colors, lib, pkgs, term, userFonts, username, ... }:

{
  imports = [
    ./i3.nix
    ./i3status.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      xsel
    ];

    programs.bash = {
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          startx
        fi
      '';
    };
  };
}
