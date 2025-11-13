{
  pkgs,
  ...
}:

{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      obs-vkcapture
      obs-vaapi
      obs-composite-blur
      #        obs-webkitgtk
    ];
  };

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    libva-vdpau-driver
    #libvdpau-va-gl
  ];
}
