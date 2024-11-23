# treefmt.nix
{ ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";
  # Enable the terraform formatter
  programs.rustfmt.enable = true;
  # Override the default package
  programs.nixfmt.enable = true;
}
