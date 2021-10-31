{ pkgs, ... }:

let
  my-kakrc = pkgs.kakouneUtils.buildKakounePlugin {
    name = "tom-kakrc";
    src = ./.;
  };
in

{
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;

  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [ kak-lsp kak-fzf my-kakrc kakboard ];
  };
}
