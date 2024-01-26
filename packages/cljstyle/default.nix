{ pkgs, ... }:

pkgs.buildGraalvmNativeImage {
  pname = "cljstyle";
  version = "0.16.626";

  extraNativeImageBuildArgs = [
    "-H:+UnlockExperimentalVMOptions"
    "-H:IncludeResources=^META-INF/MANIFEST.MF$"
    "-H:+ReportExceptionStackTraces"
    "--features=clj_easy.graal_build_time.InitClojureClasses"
    "--report-unsupported-elements-at-runtime"
    "--enable-preview"
    "--no-fallback"
  ] ++ (if pkgs.stdenv.isLinux then [ "--static" ] else [ ]);

  nativeBuildInputs = [ pkgs.clojure ];

  src = pkgs.fetchFromGitHub {
    owner = "greglook";
    repo = "cljstyle";
    rev = "refs/tags/0.16.626";
    sha256 = "9Iee9FZq/+ig2cVW+flf9tnXE8LEAbEv9fmQ3P9qf+Y=";
  };

  patches = [ ./cljstyle.patch ];

  configurePhase = ''
    runHook preConfigure
    substituteInPlace deps.edn --subst-var version
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    export DEPS_CLJ_TOOLS_DIR=${pkgs.clojure}
    export DEPS_CLJ_TOOLS_VERSION=${pkgs.clojure.version}
    export HOME=.

    clojure -T:build uberjar
    native-image -cp "$(clojure -A:native-image -Spath)" -jar "$jar" ''${nativeImageBuildArgs[@]}

    runHook postBuild
  '';

  jar = "target/cljstyle.jar";
}
