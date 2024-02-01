{pkgs, ...}:
with pkgs;
  stdenv.mkDerivation rec {
    pname = "ruby-build";
    version = "20240119";

    buildInputs = [openssl libyaml gmp];

    src = pkgs.fetchFromGitHub {
      owner = "rbenv";
      repo = pname;
      rev = "v${version}";
      sha256 = "oJdMAURkjeKUXFRqPf39I1ipcELw5BYQqAZPR9/vTq8=";
    };

    dontBuild = true;

    PREFIX = placeholder "out";
  }
