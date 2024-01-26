# hm

Base flake for my home-manager setups.

#### `setup.sh` does the following:

1. installs Nix
1. initializes home-manager
1. replaces `flake.nix` with one that consumes _this_ flake, set up for your user/home
1. replaces `home.nix` with an empty one for any per-machine extensions
1. runs `flake lock update`
1. runs `home-manager switch`

Now you've got a nice home-manager setup, hooray!
