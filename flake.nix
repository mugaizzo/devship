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
    mugaSystemTools = pkgs.symlinkJoin {
      name = "mugaSystemTools";
      paths = with pkgs; [
        zellij
        yazi
        lazygit
        alejandra
        statix
        myNeovim.neovim
      ];
    };
  in {
    # package output
    packages.${system}.default = mugaSystemTools;

    #  app for Neovim
    apps.${system} = {
      nvim = {
        type = "app";
        program = "${mugaSystemTools}/bin/nvim";
      };
      zellij = {
        type = "app";
        program = "${mugaSystemTools}/bin/zellij";
      };
    };
    # This is the new part for nix develop
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        mugaSystemTools
      ];
    };
  };
}
