{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages.x86_64-linux.gleam =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.stdenv.mkDerivation rec {
          pname = "gleam";
          version = "1.8.1";

          src = pkgs.fetchzip {
            url = "https://github.com/gleam-lang/gleam/releases/download/v${version}/gleam-v${version}-x86_64-unknown-linux-musl.tar.gz";
            sha256 = "sha256-pVpjB7GOQSgxJLH3Y+NteHM2a3lXi8tX3DyrLJ1bXv8=";
          };

          installPhase = ''
            mkdir -p $out/bin
            install -m 755 $src/gleam $out/bin
          '';

          meta = with nixpkgs.lib; {
            description = "Gleam!";
            license = licenses.asl20;
            platforms = platforms.linux;
          };
        };
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.git
              self.packages.${system}.gleam
              pkgs.erlang_27
            ];

            shellHook = ''
              export SHELL="${pkgs.bashInteractive}/bin/bash"
            '';
          };
        }
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
