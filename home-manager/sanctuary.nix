{ colors, term, userFonts, username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit colors term userFonts username; };

  home-manager.users.${username}.imports = [ ./common.nix ];
}
