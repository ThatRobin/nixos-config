{ config, pkgs, ... }:

{
  programs.konsole.enable = true;

  home.file.".local/share/konsole/BurgundyVelvet.colorscheme".text = ''
    [General]
    Description=Burgundy Velvet
    Opacity=0.92
    Wallpaper=

    [Background]
    Color=26,26,28

    [Foreground]
    Color=233,227,235

    [Color0]
    Color=26,26,28
    [Color1]
    Color=74,14,46
    [Color2]
    Color=108,16,62
    [Color3]
    Color=199,58,99
    [Color4]
    Color=157,122,165
    [Color5]
    Color=199,58,99
    [Color6]
    Color=142,36,76
    [Color7]
    Color=233,227,235

    [Color8]
    Color=74,14,46
    [Color9]
    Color=108,16,62
    [Color10]
    Color=142,36,76
    [Color11]
    Color=199,58,99
    [Color12]
    Color=255,255,255
    [Color13]
    Color=199,58,99
    [Color14]
    Color=142,36,76
    [Color15]
    Color=255,255,255

    [Cursor]
    Color=199,58,99

    [SelectionBackground]
    Color=76,14,46

    [SelectionForeground]
    Color=255,255,255
  '';

  home.file.".local/share/konsole/Burgundy.profile".text = ''
    [General]
    Name=Burgundy
    TerminalColumns=100
    TerminalRows=28

    [Appearance]
    ColorScheme=BurgundyVelvet
    Font=JetBrains Mono,12,-1,5,50,0,0,0,0,0

    [Scrolling]
    ScrollBarPosition=Right
  '';

  programs.konsole.defaultProfile = "Burgundy.profile";
}
