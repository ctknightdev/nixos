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
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer

      # Must start games with `obs-gamecapture %command%`
      # See https://github.com/nowrep/obs-vkcapture
      obs-vkcapture
    ];
  };

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    libva-vdpau-driver
    #libvdpau-va-gl
  ];
}
