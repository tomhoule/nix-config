{ localHome }:

{
  enable = true;
  server = { enable = true; };
  settings = {
    main = {
      font = "IBM Plex Mono:size=${localHome.termFontSize or "7"}";
      letter-spacing = "-0.3";
    };
    colors = {
      alpha = "0.9";
    };
  };
}
