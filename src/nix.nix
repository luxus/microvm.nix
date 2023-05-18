{
  settings = {
    auto-optimise-store = true;
    experimental-features = [ "flakes" "nix-command" "repl-flake" ];
        keep-outputs = true;
    log-lines = 50;
    substituters = [
      "https://figsoda.cachix.org"
      "https://nix-community.cachix.org"
      "https://microvm.cachix.org"
    ];
    trusted-public-keys = [
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
      "figsoda.cachix.org-1:mJfTEL4qLCqymqynJlaTxxi5APlaM0DfWg+h+CRGa20="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
