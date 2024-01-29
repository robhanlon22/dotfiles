{ pkgs, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "jenv";
  version = "0.5.6";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "refs/tags/${version}";
    sha256 = "2N8LONZvu7n6hRi6+Dt5V9F9CerphSFbMBG58WIBWDI=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ installShellFiles ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -R bin "$out/bin"
    cp -R libexec "$out/libexec"

    runHook postInstall
  '';

  postInstall = ''
    installShellCompletion --cmd jenv \
      --bash completions/jenv.bash \
      --fish completions/jenv.fish \
      --zsh completions/jenv.zsh
  '';
}
