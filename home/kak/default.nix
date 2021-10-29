{ pkgs }:

let
  my-kakrc = pkgs.kakouneUtils.buildKakounePlugin {
    name = "tom-kakrc";
    src = ./.;
  };
in
{
  enable = true;
  plugins = with pkgs.kakounePlugins; [ kak-lsp kak-fzf my-kakrc kakboard ];
}
