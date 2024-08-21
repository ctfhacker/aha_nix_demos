{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rust-overlay, ...}: let
    system = "x86_64-linux";
    overlays = [ (import rust-overlay) ];
    pkgs = import nixpkgs {
      inherit system overlays;
    };

    rust = pkgs.rust-bin.nightly.latest.default.override {
      extensions = [ "rust-src" ];
      targets = [ "wasm32-unknown-unknown" ];
    };
  in {
    devShells.x86_64-linux.default = with pkgs; mkShell rec {
      nativeBuildInputs = [
        pkgs.pkg-config
      ];

      buildInputs = with pkgs; [ 
        rust
        rust-analyzer
        pkg-config

        # x11 game related pkgs
        libGL
        udev
        alsa-lib
        vulkan-loader
        libxkbcommon
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
      ];

      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
    };
  };
}
