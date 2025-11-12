# { pkgs, ... }:
# {
#   xdg.portal = {
#     enable = true;
#     config = {
#       common = {
#         default = [
#           "wlr"
#           "gtk"
#         ]; # wlr first – owns Settings
#         "org.freedesktop.impl.portal.ScreenCast" = "wlr";
#         "org.freedesktop.impl.portal.Screenshot" = "wlr";
#         "org.freedesktop.impl.portal.RemoteDesktop" = "wlr";
#       };
#     };
#     extraPortals = with pkgs; [
#       xdg-desktop-portal-wlr # provides Settings
#       xdg-desktop-portal-gtk # provides the rest
#     ];
#     configPackages = with pkgs; [
#       xdg-desktop-portal-wlr
#       xdg-desktop-portal-gtk
#     ];
#   };
# }

{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config = {
      #common.default = "*";
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      #  xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk

      # Niri
      xdg-desktop-portal-gnome
    ];
  };
}
