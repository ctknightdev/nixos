{
  inputs,
  ...
}:
{
  imports = [
    inputs.helium.nixosModules.default
  ];

  programs.helium = {
      enable = true;

      # Optional: override the package
      # package = pkgs.helium;

      # 🚩 Flags - Command-line arguments always passed to Helium
      flags = [
        "--disable-gpu"
        "--ozone-platform-hint=auto"
      ];

      # 🎯 Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
      # Also written to /etc/helium/policies/managed/ for future compatibility
      policies = {
        "ExtensionInstallForcelist"= [
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          # "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
        ];

        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [ "en-US" ];
      };
    };
}
