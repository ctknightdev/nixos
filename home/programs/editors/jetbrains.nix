{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    jetbrains.idea
    jetbrains.rust-rover
    jetbrains-toolbox
  ];
}
