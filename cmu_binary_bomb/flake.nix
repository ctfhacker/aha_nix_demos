{
  description = "ctf dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      python = pkgs.python311.withPackages (p: with p; [ 
        angr
        ipython 
        ipdb
        python-lsp-server
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ 
          python 
          pkgs.radare2 
        ];
      };

      packages.${system}.docker = pkgs.dockerTools.buildLayeredImage {
        name = "cmu_binary_bomb";
        tag = "latest";
        created = "now";
        config = {
          Cmd = [ "${python}/bin/python" "${./flag2.py}" "${./bomb}"];
        };
      };
    };
}

