{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "antifennel";
  version = "0.3.0-dev";

  nativeBuildInputs = [ pkgs.luajit ];

  src = pkgs.fetchFromSourcehut {
    owner = "~technomancy";
    repo = "antifennel";
    rev = "0a411ae58f17a3e2792d1528105292cd76070c96";
    sha256 = "iuJVBRhhYl+THtDcQbv3SIe/0BWkwxkAYRO1xdIJIqg=";
  };

  LUA = "${pkgs.luajit}/bin/luajit";
  LUA_PATH = "lang/?.lua;;";
  PREFIX = placeholder "out";
}
