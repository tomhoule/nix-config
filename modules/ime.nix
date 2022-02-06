{ pkgs, ... }:

{
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy libpinyin ];
}
