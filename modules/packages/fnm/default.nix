{ pkgs, ... }:

with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "fnm";
  version = "1.35.1";

  nativeBuildInputs = [ installShellFiles ];

  buildInputs =
    lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  src = fetchCrate {
    inherit pname version;
    sha256 = "cQ9it+opPBuerRP+axF1yuZZdjwl1bqUG1Jv6ouHAGg=";
  };

  cargoSha256 = "NEkjuV3bGKmkD1gFEZvJI1yWZ8iq7MFNMumGxhXaQyQ=";
  cargoDepsName = pname;

  doCheck = false;

  postInstall = ''
    installShellCompletion --cmd fnm \
      --bash <($out/bin/fnm completions --shell bash) \
      --fish <($out/bin/fnm completions --shell fish) \
      --zsh <($out/bin/fnm completions --shell zsh)
  '';
}
