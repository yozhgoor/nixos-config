{ userFonts, ... }:

{
    fonts.packages = [
        userFonts.main.package
        userFonts.nerd.package
        userFonts.symbols.package
    ];
}
