{ config, ... }:

let fontSize = builtins.toString config.localHome.termFontSize; in
{
  programs.foot = {
    enable = true;
    server = { enable = true; };
    settings = {
      main = {
        font = "IBM Plex Mono:size=${fontSize}";
        letter-spacing = "-0.3";
      };
      colors = {
        alpha = "0.9";
      };
    };
  };
}
