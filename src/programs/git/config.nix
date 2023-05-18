{ pkgs }:

let
  inherit (pkgs) delta ;
in

{
  core = {
    fsmonitor = true;
    pager = "${delta}/bin/delta";
  };
  delta = {
    hunk-header-decoration-style = "blue";
    line-number = true;
    syntax-theme = "OneHalfDark";
  };
  features.manyFiles = true;
  init.defaultBranch = "main";
  interactive.diffFilter = "${delta}/bin/delta --color-only";
  url = {
    "https://gitlab.com/".insteadOf = [ "gl:" "gitlab:" ];
    "https://github.com/".insteadOf = [ "gh:" "github:" ];
    "https://github.com/luxus/".insteadOf = [ "me:" ];
    "https://github.com/nix-community/".insteadOf = [ "nc:" ];
  };
  user = {
    name = "luxus";
    email = "luxuspur@gmail.com";
  };
}
