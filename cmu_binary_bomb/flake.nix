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

        shellHook = ''
          echo "Welcome to the pwn.college dev shell!"
          export PYTHONPATH=$PWD
        '';
      };
    };
}

