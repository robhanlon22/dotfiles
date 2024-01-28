{ pkgs, ... }:

with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "fennel-language-server";
  version = "59005549ca1191bf2aa364391e6bf2371889b4f8";

  src = fetchFromGitHub {
    owner = "rydesun";
    repo = pname;
    rev = version;
    sha256 = "pp1+lquYRFZLHvU9ArkdLY/kBsfaHoZ9x8wAbWpApck=";
  };

  cargoSha256 = "B4JV1rgW59FYUuqjPzkFF+/T+4Gpr7o4z7Cmpcszcb8=";
  cargoDepsName = pname;

  doCheck = false;
}
