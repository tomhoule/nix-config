{pkgs, ...}: {
  home.packages = with pkgs; [
    bun
    nodejs_18 # current LTS
    nodePackages.pnpm
    nodePackages.typescript-language-server
    nodePackages.prettier
    typescript
  ];
}
