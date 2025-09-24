{
  description = "NixVim configuration using nixos-unstable and nvf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    myNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        {_module.args = {inherit inputs nvf;};}
        ./nvim/default.nix
      ];
    };
  in {
    # Development shell for nix develop
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        zellij
        yazi
        lazygit
        alejandra
        statix
        ripgrep
        fd
        clang-tools
        myNeovim.neovim
      ];
    };

    # Bundle all tools for nix profile add
    packages.${system}.default = pkgs.buildEnv {
      name = "nvf-tools";
      paths = with pkgs; [
        zellij
        yazi
        lazygit
        alejandra
        statix
        ripgrep
        fd
        clang-tools
        myNeovim.neovim
      ];
    };

    # muga, for individual packages Expose Neovim as a standalone package
    # packages.x86_64-linux.zellij = pkgs.zellij;
    # packages.x86_64-linux.yazi = pkgs.yazi;
    # packages.x86_64-linux.lazygit = pkgs.lazygit;
    # packages.x86_64-linux.alejandra = pkgs.alejandra;
    # packages.x86_64-linux.statis = pkgs.statix;
    # packages.x86_64-linux.neovim = myNeovim.neovim;
  };
}
