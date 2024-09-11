{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
with lib; let
  sys = osConfig.modules.system;
in {
  mainBar = {
    layer = "top"; 
    height = 28;  # Angepasst für die niedrigere Auflösung
    spacing = 6;  # Angepasste Abstände
    margin-top = 5;
    margin-bottom = 2;
    margin-right = 6;
    margin-left = 6;
    fixed-center = false;
    modules-left = [
      "hyprland/workspaces"
    ];
    modules-center = [
      "hyprland/window"
    ];
    modules-right = [
      "custom/notification"
      "memory"
      "pulseaudio"
      "clock"
      "tray"
      "custom/power-menu"
    ];

    "wlr/workspaces" = {
      active-only = false;
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace m+1";
      on-scroll-down = "hyprctl dispatch workspace m-1";
      format = "{name}";
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
        # "urgent" = "";
        # "active" = "";
        # "default" = "";
      };
    };

    "hyprland/window" = {
      format = "{}";
    };
    "tray" = {
      icon-size = 18;  # Etwas kleinere Symbole für die geringere Auflösung
      spacing = 4;
    };
    "clock" = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = " FORMAT";
      timezone = "TIMEZONE";
      today-format = "<span color = '#ff6699'><b><u>{}</u></b></span>";
      format-calendar = "<span color='#ecc6d9'><b>{}</b></span>";
      format-calendar-weeks = "<span color='#99ffdd'><b>W{:%U}</b></span>";
      format-calendar-weekdays = "<span color='#ffcc66'><b>{}</b></span>";
      on-scroll = {
        calendar = 1;
      };
    };
    memory = {
      interval = 30;
      format = " {used:0.1f}G / {total:0.1f}G";
      on-click = "wezterm -e btop";
      tooltip = false;
    };
    pulseaudio = {
      # scroll-step = 1; # %, can be a float
      format = "{icon} {volume}%";
      format-bluetooth = "{volume}%  {format_source}";
      format-bluetooth-muted = "󰖁 ";
      format-muted = "󰖁";
      # format-source = "{volume}% ";
      # format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "󰂑";
        headset = "󰂑";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "pavucontrol";
    };
    "custom/power-menu" = {
      format = "⏻";
      on-click = "~/.config/waybar/scripts/power-menu/powermenu.sh";
    };
    "custom/notification" = {
      exec = "~/.config/waybar/scripts/notification.sh";
      on-click = "dunstctl set-paused toggle";
      return-type = "json";
      max-length = 50;
      format = "{}";
    };
  };
}