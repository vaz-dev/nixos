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
      preload = [ "./bg.png" ];
      wallpaper = [
        "eDP-1,${./bg.png}"
        "HDMI-A-2,${./bg.png}"
      ];
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
        "waybar"
        "mako"
        "nm-applet --indicator"
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
        "$mod, R, exec, rofi -show drun -run-command \"nvidia-offload {cmd}\""

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

	programs.waybar = {
    enable = true;
    systemd.enable = false; # matches your hyprland systemd.enable = false pattern — launched via exec-once instead

    settings.mainBar = {
      layer = "top";
      position = "bottom";

      modules-left = [ "hyprland/workspaces" "custom/right-arrow-dark" ];
      modules-center = [
        "custom/left-arrow-dark" "clock#1" "custom/left-arrow-light"
        "custom/left-arrow-dark" "clock#2" "custom/right-arrow-dark"
        "custom/right-arrow-light" "clock#3" "custom/right-arrow-dark"
      ];
      modules-right = [
        "custom/left-arrow-dark" "pulseaudio" "custom/left-arrow-light"
        "custom/left-arrow-dark" "memory" "custom/left-arrow-light"
        "custom/left-arrow-dark" "cpu" "custom/left-arrow-light"
        "custom/left-arrow-dark" "battery" "custom/left-arrow-light"
        "custom/left-arrow-dark" "disk" "custom/left-arrow-light"
        "custom/left-arrow-dark" "tray"
      ];

      "custom/left-arrow-dark" = { format = ""; tooltip = false; };
      "custom/left-arrow-light" = { format = ""; tooltip = false; };
      "custom/right-arrow-dark" = { format = ""; tooltip = false; };
      "custom/right-arrow-light" = { format = ""; tooltip = false; };

      "hyprland/workspaces" = {
        disable-scroll = true;
        format = "{name}";
      };

      "clock#1" = { format = "{:%a}"; tooltip = false; };
      "clock#2" = { format = "{:%H:%M}"; tooltip = false; };
      "clock#3" = { format = "{:%m-%d}"; tooltip = false; };

      pulseaudio = {
        format = "{icon} {volume:2}%";
        format-bluetooth = "{icon}  {volume}%";
        format-muted = "MUTE";
        format-icons = { headphones = ""; default = [ "" "" ]; };
        scroll-step = 5;
        on-click = "pamixer -t";
        on-click-right = "pavucontrol";
      };
      memory = { interval = 5; format = "Mem {}%"; };
      cpu = { interval = 5; format = "CPU {usage:2}%"; };
      battery = {
        states = { good = 95; warning = 30; critical = 15; };
        format = "{icon} {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };
      disk = { interval = 5; format = "Disk {percentage_used:2}%"; path = "/"; };
      tray = { icon-size = 20; };
    };

    style = builtins.readFile ./waybar.style.css;
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = { x = 2; y = 2; };
      font = {
        size = 13.0;
        offset = { y = 1; x = 1; };
      };
      terminal.shell = {
        program = "${pkgs.zellij}/bin/zellij";
        args = [ "--layout" "default" "attach" "-c" "main" ];
      };
    };
  };

  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      pane command="bash" {
        args "-c" "fastfetch; exec bash"
      }
    }
  '';

  programs.helix = {
    enable = true;
    settings = {
      theme = "ashen";
      editor = {
        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };
        end-of-line-diagnostics = "warning";
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "disable";
        };
      };
      keys.normal = {
        space.l = ":toggle lsp.display-inlay-hints";
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      PS1='\[\e[34m\]\u@\h \[\e[90m\]\w \[\e[34m\]>\[\e[0m\] '
    '';
  };
}
