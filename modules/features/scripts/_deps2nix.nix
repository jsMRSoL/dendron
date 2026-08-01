{ pkgs, ... }:
let
  deps2nix = pkgs.writeScriptBin "deps2nix" ''
    #!${pkgs.python3}/bin/python
    import re
    import tomllib


    def strip_version(dep):
        # Remove any version specifiers like >=, <=, ==, ~=, !=
        return re.split(r"[<>=!~]", dep, maxsplit=1)[0].strip()


    # Load pyproject.toml
    with open("pyproject.toml", "rb") as f:
        pyproject = tomllib.load(f)

    # Extract runtime dependencies
    dependencies = pyproject.get("project", {}).get("dependencies", [])

    # Strip versions
    dependencies = [strip_version(dep) for dep in dependencies]

    # Base build dependencies needed for PEP 517 builds
    build_deps = ["setuptools", "wheel"]
    # Merge runtime and build deps, avoiding duplicates
    all_deps = sorted(set(dependencies + build_deps))

    # Output Nix-style list
    nix_list = "\n".join(all_deps)
    print("Paste this list into propagatedBuildInputs:")
    print("===========================================")
    print(f"{nix_list}")
  '';
in
{
  home.packages = [
    deps2nix
  ];
}
