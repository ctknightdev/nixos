{
  ...
}:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "sudo"
      ];
    };

    initContent = ''
      # Sets `nix develop` to use zsh
      eval "$(nix-your-shell zsh)"

      if [[ $- == *i* ]] && [[ -z $IN_NIX_SHELL ]]; then
        fastfetch
      fi
    '';
  };
}
