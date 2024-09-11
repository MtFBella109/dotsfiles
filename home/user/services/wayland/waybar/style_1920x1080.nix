{colorscheme}:
with colorscheme.colors; let
  OSLogo = builtins.fetchurl rec {
    name = "OSLogo-${sha256}.png";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
  };
in ''
    * {
      font-family: JetBrainsMono Nerd Font;
      font-size: 11px;  # Angepasst von 13px auf 11px für die kleinere Auflösung
      border-radius: 14px;  # Angepasst von 17px auf 14px
    }

    #clock,
    #custom-notification,
    #custom-launcher,
    #custom-power-menu,
    #memory,
    #disk,
    #network,
    #custom-spotify,
    #pulseaudio,
    #window,
    #tray {
      padding: 4 12px;  # Angepasst von 5 15px auf 4 12px
      border-radius: 10px;  # Angepasst von 12px auf 10px
      background: rgba(22, 22, 22, 0.6);
      color: rgb(180, 190, 254);
      box-shadow: rgba(17, 17, 27, 0.2) 0 0 3 2px;
      margin-top: 6px;  # Reduziert von 8px auf 6px
      margin-bottom: 6px;
      margin-right: 2px;
      margin-left: 2px;
      transition: all 0.3s ease;
    }

    #window {
      background-color: transparent;
      box-shadow: none;
    }

    window#waybar {
      background-color: rgba(0, 0, 0, 0.096);
      border-radius: 14px;
    }

    window * {
      background-color: transparent;
      border-radius: 14px;
    }

    #workspaces button label {
      color: rgb(180, 190, 254);
    }

    #workspaces button.active label {
      color: rgba(16, 16, 16, 0.6);
      font-weight: bolder;
    }

    #workspaces button:hover {
      box-shadow: rgb(180, 190, 254) 0 0 0 1.5px;
      min-width: 45px;  # Reduziert von 50px auf 45px
    }

    #workspaces {
      background-color: transparent;
      border-radius: 14px;
      padding: 4 0px;
      margin-top: 2px;  # Angepasst für geringere Auflösung
      margin-bottom: 2px;
    }

    #workspaces button {
      box-shadow: rgba(17, 17, 27, 0.2) 0 0 3 2px;
      background-color: rgba(16, 16, 16, 0.6);
      border-radius: 10px;
      margin-left: 8px;  # Reduziert von 10px auf 8px
      transition: all 0.3s ease;
    }

    #workspaces button.active {
      min-width: 45px;
      box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
      background-color: rgb(245, 194, 231);
      background-size: 400% 400%;
      transition: all 0.3s ease;
      background: linear-gradient(
        58deg,
        #ff7eb6,
        #ff7eb6,
        #ff7eb6,
        #ee5396,
        #ee5396,
        #ee5396,
        #ff7eb6
      );
      background-size: 300% 300%;
      animation: colored-gradient 20s ease infinite;
    }

    @keyframes colored-gradient {
      0% {
        background-position: 71% 0%;
      }
      50% {
        background-position: 30% 100%;
      }
      100% {
        background-position: 71% 0%;
      }
    }

    #custom-power-menu {
      margin-right: 8px;  # Reduziert von 10px auf 8px
      padding-left: 10px;  # Angepasst
      padding-right: 12px;
      padding-top: 3px;
    }

    #custom-spotify {
      margin-left: 4px;
      padding-left: 12px;
      padding-right: 12px;
      padding-top: 3px;
      color: rgba(180, 190, 254, 0.329);
      background-color: rgba(16, 16, 16, 0.6);
      box-shadow: rgba(17, 17, 27, 0.2) 0 0 3 2px;
      transition: all 0.3s ease;
    }

    #custom-spotify.playing {
      color: rgb(180, 190, 254);
      background: rgba(30, 30, 46, 0.6);
      background: linear-gradient(
        90deg,
        rgb(49, 50, 68),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgb(49, 50, 68)
      );
      background-size: 400% 100%;
      animation: grey-gradient 3s linear infinite;
      transition: all 0.3s ease;
    }

    @keyframes grey-gradient {
      0% {
        background-position: 100% 50%;
      }
      100% {
        background-position: -33% 50%;
      }
    }

    #tray menu {
      background-color: rgba(30, 30, 46, 0.6);
      opacity: 0.8;
    }

    #pulseaudio.muted {
      color: rgb(243, 139, 168);
      padding-right: 14px;  # Angepasst von 16px auf 14px
    }

    #custom-notification.collapsed,
    #custom-notification.waiting_done {
      min-width: 12px;
      padding-right: 14px;  # Angepasst von 17px auf 14px
    }

    #custom-notification.waiting_start,
    #custom-notification.expanded {
      background-color: transparent;
      background: linear-gradient(
        90deg,
        rgb(49, 50, 68),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgba(30, 30, 46, 0.6),
        rgb(49, 50, 68)
      );
      background-size: 400% 100%;
      animation: grey-gradient 3s linear infinite;
      min-width: 450px;  # Angepasst von 500px auf 450px
      border-radius: 14px;  # Angepasst von 17px auf 14px
    }

    #custom-notification.collapsed_muted {
      min-width: 12px;
      color: rgb(243, 139, 168);
      padding-right: 14px;  # Angepasst von 17px auf 14px
    }

    #custom-notification.wallpaper {
      min-width: 12px;
      padding-right: 14px;  # Angepasst von 17px auf 14px
      color: transparent;
      background: linear-gradient(
        58deg,
        #ff7eb6,
        #ff7eb6,
        #ff7eb6,
        #ee5396,
        #ee5396,
        #ee5396,
        #ff7eb6
      );
      background-size: 300% 300%;
      animation: colored-gradient 3s ease infinite;
    }
''