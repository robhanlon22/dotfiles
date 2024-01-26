{ pkgs, ... }:

let rev = "59005549ca1191bf2aa364391e6bf2371889b4f8";
in pkgs.rustPlatform.buildRustPackage {
  name = "fennel-language-server";
  version = rev;

  src = pkgs.fetchFromGitHub {
    owner = "rydesun";
    repo = "fennel-language-server";
    inherit rev;
    sha256 = "pp1+lquYRFZLHvU9ArkdLY/kBsfaHoZ9x8wAbWpApck=";
  };

  cargoSha256 = "B4JV1rgW59FYUuqjPzkFF+/T+4Gpr7o4z7Cmpcszcb8=";
}
