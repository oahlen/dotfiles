{ mkTheme }:
let
  dark-palette = builtins.fromJSON (builtins.readFile ./dark-palette.json);
  light-palette = builtins.fromJSON (builtins.readFile ./light-palette.json);
in
{
  dark = mkTheme dark-palette;
  light = mkTheme light-palette;
}
