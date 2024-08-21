{
  description = "pwn.college dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [ 
          figlet
          nyancat
          sl
          asciiquarium
          ponysay
          fortune
          pipes
          aalib # aafire
        ];
      };
    };
}

