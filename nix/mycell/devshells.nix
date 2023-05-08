{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;

  test = {...}: {
    name = nixpkgs.lib.mkForce "Test";
    packages = with nixpkgs; [
      nodejs
    ];
  };
in
  l.mapAttrs (_: std.lib.dev.mkShell) rec {
    devops = {...}: {
      imports = [
        test
      ];
    };
    devs = {...}: {
      imports = [
        test
      ];
    };
    default = devops;
  }
