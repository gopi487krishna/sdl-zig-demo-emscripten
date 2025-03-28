{
  description = "SDL zig demo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, zig }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          zig.overlays.default
        ];
      };
    in
    {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [nixpkgs-fmt zigpkgs."0.13.0" SDL2 python3 emscripten];
        
        # Expose Emscripten path as an environment variable
        shellHook = ''
          export EMSCRIPTEN_PATH="${pkgs.emscripten}"
          echo "EMSCRIPTEN_PATH is set to: $EMSCRIPTEN_PATH"
        '';
      };
  };
}
