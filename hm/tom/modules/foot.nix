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
        alpha = "0.9";
      };
    };
  };
}
