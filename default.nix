{
  lib,
  stdenv,
  hyprland,
}:
stdenv.mkDerivation {
  pname = "virtual-desktops";
  version = "2.0.1";
  src = ./.;

  inherit (hyprland) nativeBuildInputs;

  buildInputs = [hyprland] ++ hyprland.buildInputs;

  meta = with lib; {
    homepage = "https://github.com/milesje/hyprland-virtual-desktops";
    description = "Virtual Desktops";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}