{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "shakir-tools";
      paths = [
        fzf
        zoxide
        starship
        ripgrep
        lazygit
        eza
        bat
        tmux
      ];
    };
  };
}
