{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs_1803 = {
      url = "github:NixOS/nixpkgs/release-18.03";
      flake = false;
    };
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs_1803,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        pkgs_1803 = import nixpkgs_1803 { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            prettier
            pkgs_1803.nodejs-8_x
          ];
        };
      }
    );
}
