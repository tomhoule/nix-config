{ config, ... }:

{
  programs.foot = {
    enable = true;
    server = { enable = true; };
    settings = {
      main = {
        font = "IBM Plex Mono:size=${config.localHome.termFontSize}";
        letter-spacing = "-0.3";
      };
      colors = {
        alpha = "0.9";
      };
    };
  };
}
