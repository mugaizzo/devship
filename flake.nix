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
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        zellij
        yazi
        lazygit
        alejandra
        statix
        myNeovim.neovim
      ];
    };
  };
}
