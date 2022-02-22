{ pkgs, config, ... }:

let
  nvimConfig = ''
    lua <<EOF
      require('lean').setup{
        abbreviations = { builtin = true },
        lsp = { on_attach = on_attach },
        lsp3 = { on_attach = on_attach },
        mappings = true,
      }
    EOF
  ''; in
{
  home.packages = [ pkgs.elan ];
  home.sessionVariables = {
    ELAN_HOME = "${config.xdg.cacheHome}/elan";
  };

  programs.neovim.plugins = [
    pkgs.vimPlugins.plenary-nvim

    {
      plugin = pkgs.vimPlugins.lean-nvim;
      config = nvimConfig;
    }
  ];
}
