{
  description = "Soundboard for the Mumble voice chat";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage = pkgs.buildGoModule {
        pname = "gomumblesoundboard";
        version = "dev";
        src = ./.;
        vendorSha256 = "sha256-i859sY9eYYjDMB/NYMvSbSXgV7Z/fbup8rhNiXAVQ3E=";
        buildInputs = with pkgs; [ libopus ];
        nativeBuildInputs = with pkgs; [ pkg-config ];
      };

      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          libopus
          pkg-config
        ];
      };
    });
}
