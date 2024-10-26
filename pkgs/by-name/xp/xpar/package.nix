{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, nasm
}:

let
  version = "0.5";
in
  stdenv.mkDerivation {
    pname = "xpar";
    inherit version;

    src = fetchFromGitHub {
      owner = "kspalaiologos";
      repo = "xpar";
      rev = version;
      hash = "sha256-DMUDWQqYSQjGxYOpcfwNaaM21avcZ1w3IqEhuOaabrw=";
    };

    nativeBuildInputs = [
      autoreconfHook
    ] ++ lib.optionals stdenv.hostPlatform.isx86_64 [ nasm ];

    configureFlags = [
      "--disable-arch-native"
      "--enable-lto"
    ] ++ lib.optional stdenv.hostPlatform.isx86_64 "--enable-x86-64"
      ++ lib.optional stdenv.hostPlatform.isAarch64 "--enable-aarch64";

    meta = {
      description = "Error/erasure code system guarding data integrity";
      homepage = "https://github.com/kspalaiologos/xpar";
      changelog = "https://github.com/kspalaiologos/xpar/blob/${version}/NEWS";
      license = lib.licenses.gpl3Plus;
      maintainers = with lib.maintainers; [ mrbenjadmin ];
      platforms = lib.platforms.all;
      mainProgram = "xpar";
    };
  }
