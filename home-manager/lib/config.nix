{lib, ...}: rec {
  enabling = attr: lib.attrsets.recursiveUpdate {${attr} = true;};
  enabled = enabling "enable";
  enablingAll = attr: builtins.mapAttrs (lib.const (enabling attr));
  enabledAll = enablingAll "enable";
}
