{
  inputs,
  config,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  fontsize = "12";
  primary_accent = "cba6f7";
  secondary_accent = "89b4fa";
  tertiary_accent = "f5f5f5";
  tokyonight_blue = "8aadf4";
  oxocarbon_pink = "ff7eb6";
  oxocarbon_border = "393939";
  oxocarbon_background = "161616";
  background = "11111B";
  opacity = ".85";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    enableNvidiaPatches = true;
    settings = {
      # "$mainMod" = "SUPER";
      monitor = [
        # "DP-3,1920x1080@165,0x0,auto"
        ",preferred,auto,auto"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "LAYOUT";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        repeat_delay = 160;
        repeat_rate = 25;
        numlock_by_default = 1;
        accel_profile = "flat";
        sensitivity = 0;
        force_no_accel = 1;
        touchpad = {
          natural_scroll = 1;
        };
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 3;
        # "col.active_border" = "rgb(${oxocarbon_border})";
        # "col.inactive_border" = "rgba(${background}00)";
        layout = "dwindle";
        apply_sens_to_raw = 1; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      };

      decoration = {
        rounding = 5;
        shadow_ignore_window = true;
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgb(${oxocarbon_background})";
        "col.shadow_inactive" = "rgb(${background})";
        blur = {
          enabled = false;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = 0.0117;
          contrast = 1.5;
          brightness = 1;
        };
      };

      animations = {
        enabled = false;
        bezier = [
          "pace,0.46, 1, 0.29, 0.99"
          "overshot,0.13,0.99,0.29,1.1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
        ];
        animation = [
          "windowsIn,1,6,md3_decel,slide"
          "windowsOut,1,6,md3_decel,slide"
          "windowsMove,1,6,md3_decel,slide"
          "fade,1,10,md3_decel"
          "workspaces,1,9,md3_decel,slide"
          "workspaces, 1, 6, default"
          "specialWorkspace,1,8,md3_decel,slide"
          "border,1,10,md3_decel"
        ];
      };

      misc = {
        vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
        vrr = false; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
      };

      dwindle = {
        pseudotile = true; # enable pseudotiling on dwindle
        force_split = 0;
        preserve_split = true;
        default_split_ratio = 1.0;
        no_gaps_when_only = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
      };

      master = {
        mfact = 0.5;
        orientation = "right";
        special_scale_factor = 0.8;
        new_status = master;
        no_gaps_when_only = false;
      };

      gestures = {
        workspace_swipe = false;
      };

      debug = {
        damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
      };

      exec-once = [
        # "easyeffects --gapplication-service" # Starts easyeffects in the background
        "$HOME/.config/hypr/autostart"
        # "hyprpaper"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GTK_THEME,Adwaita:dark"
        "QT_STYLE_OVERRIDE,adwaita-dark"
];

      bind = [
        "SUPER,Q,exec,alacritty"
        "SUPER,M,exit,"
        "SUPER,T,togglefloating,"
        "SUPER,G,togglegroup"
        "SUPER,B,exec,rofi -show run -theme $HOME/.themes/tokyonight/tokyonight.rasi"
        "SUPER,C,killactive"
        "SUPER,S,exec,grim -g \"$(slurp)\""

        "SUPER,h,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,k,movefocus,u"
        "SUPER,j,movefocus,d"

        "SUPER,left,movefocus,l"
        "SUPER,down,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,right,movefocus,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"

        "CTRL,1,workspace,1"
        "CTRL,2,workspace,2"
        "CTRL,3,workspace,3"
        "CTRL,4,workspace,4"
        "CTRL,5,workspace,5"
        "CTRL,6,workspace,6"

        ################################## Move ###########################################
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        #---------------------------------------------------------------#
        # Move active window to a workspace with mainMod + ctrl + [0-9] #
        #---------------------------------------------------------------#
        "SUPER $mainMod CTRL, 1, movetoworkspace, 1"
        "SUPER $mainMod CTRL, 2, movetoworkspace, 2"
        "SUPER $mainMod CTRL, 3, movetoworkspace, 3"
        "SUPER $mainMod CTRL, 4, movetoworkspace, 4"
        "SUPER $mainMod CTRL, 5, movetoworkspace, 5"
        "SUPER $mainMod CTRL, 6, movetoworkspace, 6"
        "SUPER $mainMod CTRL, 7, movetoworkspace, 7"
        "SUPER $mainMod CTRL, 8, movetoworkspace, 8"
        "SUPER $mainMod CTRL, 9, movetoworkspace, 9"
        "SUPER $mainMod CTRL, 0, movetoworkspace, 10"
        # "SUPER $mainMod CTRL, left, movetoworkspace, -1"
        # "SUPER $mainMod CTRL, right, movetoworkspace, +1"
        # same as above, but doesnt switch to the workspace
        #"SUPER $mainMod SHIFT, 1, movetoworkspacesilent, 1"
        #"SUPER $mainMod SHIFT, 2, movetoworkspacesilent, 2"
        #"SUPER $mainMod SHIFT, 3, movetoworkspacesilent, 3"
        #"SUPER $mainMod SHIFT, 4, movetoworkspacesilent, 4"
        #"SUPER $mainMod SHIFT, 5, movetoworkspacesilent, 5"
        #"SUPER $mainMod SHIFT, 6, movetoworkspacesilent, 6"
        #"SUPER $mainMod SHIFT, 7, movetoworkspacesilent, 7"
        #"SUPER $mainMod SHIFT, 8, movetoworkspacesilent, 8"
        # "SUPER $mainMod SHIFT, 9, movetoworkspacesilent, 9"
        # "SUPER $mainMod SHIFT, 0, movetoworkspacesilent, 10"

      ];

      bindm = [
        # Mouse binds
        # "SUPER,mouse_down,workspace,e+1"
        # "SUPER,mouse_up,workspace,e-1"
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];


      windowrule = [
        # Window rules
        "tile,title:^(kitty)$"
        "float,title:^(fly_is_kitty)$"
        "opacity 1.0 override 1.0 override,^(foot)$" # Active/inactive opacity
        "opacity 1.0 override 1.0 override,^(kitty)$" # Active/inactive opacity
        "tile,^(Spotify)$"
        "tile,^(neovide)$"
        "tile,^(wps)$"
        "opacity 1.0 override 1.0 override,^(neovide)$" # Active/inactive opacity
      ];

      windowrulev2 = [
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        # "opacity ${custom.opacity} ${custom.opacity},class:^(WebCord)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(mpv)$"
        "opacity 1.0 1.0,class:^(wofi)$"
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];
    };
  };
}
