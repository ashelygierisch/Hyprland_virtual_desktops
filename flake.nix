{
  description = "Hyprland Virtual Desktops";

  inputs.hyprland.url = "github:hyprwm/Hyprland";

  outputs = {
    self,
    hyprland,
  }: let
    inherit (hyprland.inputs) nixpkgs;
    withPkgsFor = fn: nixpkgs.lib.genAttrs (builtins.attrNames hyprland.packages) (system: fn system nixpkgs.legacyPackages.${system});
  in {
    packages = withPkgsFor (system: pkgs: {
      virtual-desktops = pkgs.callPackage ./ {
        inherit (hyprland.packages.${system}) hyprland;
        stdenv = pkgs.gcc13Stdenv;
      };
    });

    devShells = withPkgsFor (system: pkgs: {
      default = pkgs.mkShell.override {stdenv = pkgs.gcc13Stdenv;}{
        name = "virtual-desktops";
	      buildInputs = [hyprland.packages.${system}.hyprland];
	      inputsFrom = [hyprland.packages.${system}.hyprland];
      };
    });
  };
}
