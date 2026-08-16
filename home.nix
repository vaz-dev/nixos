{ config, pkgs, ... }:
{
  home = {
    username = "vaz";
    homeDirectory = "/home/vaz";
    stateVersion = "26.05";
    packages = [];

    sessionVariables.NIXOS_OZONE_WL = "1";

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "~/Pictures/wallpapers/current.jpg" ];
      wallpaper = [ ",~/Pictures/wallpapers/current.jpg" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";

      monitor = [
        "eDP-1,preferred,0x0,1"
        "HDMI-A-2,preferred,auto,1"
      ];

      exec-once = [
        "$terminal"
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
      };

      bind = [
        "$mod, T, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, R, exec, wofi --show drun"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod CTRL, H, resizeactive, -40 0"
        "$mod CTRL, L, resizeactive, 40 0"
        "$mod CTRL, K, resizeactive, 0 -40"
        "$mod CTRL, J, resizeactive, 0 40"

        "$mod, O, movecurrentworkspacetomonitor, +1"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = toString (i + 1);
          in [
            "$mod, ${ws}, workspace, ${ws}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
          ]
        ) 9)
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}
