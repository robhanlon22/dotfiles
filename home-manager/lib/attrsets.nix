_: {
  fromList = f: list: builtins.listToAttrs (map f list);
  merge = a: b: a // b;
}
