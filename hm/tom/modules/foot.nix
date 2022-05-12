{ config, ... }:

let fontSize = builtins.toString config.localHome.termFontSize; in
{
  programs.foot = {
    enable = true;
    server = { enable = true; };
    settings = {
      main = {
        font = "Hack:size=${fontSize},Fira Code:size=${fontSize}";
      };
      colors = {
        # papercolor-light theme
        # https://codeberg.org/dnkl/foot/src/branch/master/themes/paper-color-light
        alpha = "0.95";
        background = "eeeeee";
        foreground = "444444";
        regular0 = "eeeeee"; # black
        regular1 = "af0000"; # red
        regular2 = "008700"; # green
        regular3 = "5f8700"; # yellow
        regular4 = "0087af"; # blue
        regular5 = "878787"; # magenta
        regular6 = "005f87"; # cyan
        regular7 = "764e37"; # white
        bright0 = "bcbcbc"; # bright black
        bright1 = "d70000"; # bright red
        bright2 = "d70087"; # bright green
        bright3 = "8700af"; # bright yellow
        bright4 = "d75f00"; # bright blue
        bright5 = "d75f00"; # bright magenta
        bright6 = "4c7a5d"; # bright cyan
        bright7 = "005faf"; # bright white
        #selection-foreground=eeeeee
        #selection-background=0087af
      };
      cursor = {
        color = "eeeeee 444444";
      };
    };
  };
}
