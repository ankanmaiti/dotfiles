{ config, lib, pkgs, pkgs-unstable, ... }:
let
  modifier = config.xsession.windowManager.i3.config.modifier;
  colors = {
    base 				= "#1e1e2e";
    mantle 				= "#181825";
    crust 				= "#11111b";
    text 				= "#cdd6f4";
    subtext0 				= "#a6adc8";
    subtext1 				= "#bac2de";
    surface0 				= "#313244";
    surface1 				= "#45475a";
    surface2 				= "#585b70";
    overlay0 				= "#6c7086";
    overlay1 				= "#7f849c";
    overlay2 				= "#9399b2";
    blue 				= "#89b4fa";
    lavender 				= "#b4befe";
    sapphire 				= "#74c7ec";
    sky 				= "#89dceb";
    teal 				= "#94e2d5";
    green 				= "#a6e3a1";
    yellow 				= "#f9e2af";
    peach 				= "#fab387";
    maroon 				= "#eba0ac";
    red 				= "#f38ba8";
    mauve 				= "#cba6f7";
    pink 				= "#f5c2e7";
    flamingo 				= "#f2cdcd";
    rosewater 				= "#f5e0dc";
    transparent 			= "#FF00000";
    background 				= colors.base;
    background-alt 			= colors.blue;
    foreground 				= colors.text;
    primary 				= colors.mauve;
    secondary 				= colors.mantle;
    alert 				= colors.red;
    disabled 				= colors.subtext1;
  };
in
{
  services.polybar = {
    enable = true;
    package = pkgs-unstable.polybar;
    script = "polybar bar &amp;";
    settings = {
      "colors" = {
        background 			= colors.base;
        background-alt 			= colors.blue;
        foreground 			= colors.text;
        primary 			= colors.mauve;
        secondary 			= colors.mantle;
        alert 				= colors.red;
        disabled 			= colors.subtext1;
      };
      "bar/toph" = {
        monitor 			= "";
        width 				= "100%";
        height 				= "28pt";
        radius 				= "0";
        background 			= colors.base;
        foreground 			= colors.text;
        bottom 				= true;
        line-size 			= "6pt";
        border-size 			= "4pt";
        border-color 			= "#00000000";
        padding-left 			= "0";
        padding-right 			= "1";
        module-margin 			= "1";
        separator 			= "|";
        separator-foreground 		= colors.flamingo;
        # font-0 			= "MesloLGS Nerd Font Mono:size=14;6";
        modules-left 			= "xworkspaces xwindow";
        modules-right 			= "pulseaudio battery memory cpu wlan date";
        cursor-click 			= "pointer";
        cursor-scroll 			= "ns-resize";
        enable-ipc 			= true;
      };

      "module/systray" = {
        type 				= "internal/tray";
        format-margin 			= "8pt";
        tray-spacing 			= "16pt";
      };

      "module/xworkspaces" = {
        type 				= "internal/xworkspaces";
        label-active 			= "%name%";
        label-active-background 	= colors.mauve;
        label-active-foreground 	= colors.crust;
        label-active-underline 		= colors.lavender;
        label-active-padding 		= "1";
        label-occupied 			= "%name%";
        label-occupied-padding 		= "1";
        label-urgent 			= "%name%";
        label-urgent-background 	= colors.red;
        label-urgent-padding 		= "1";
        label-empty 			= "%name%";
        label-empty-foreground 		= colors.disabled;
        label-empty-padding 		= "1";
      };

      "module/xwindow" = {
        type 				= "internal/xwindow";
        label 				= "%title:0:60:...%";
      };

      "module/filesystem" = {
        type 				= "internal/fs";
        interval 			= "25";
        mount-0 			= "/";
        label-mounted 			= "%{F#F0C674}%mountpoint%%{F-} %percentage_used%%";
        label-unmounted 		= "%mountpoint% not mounted";
        label-unmounted-foreground 	= colors.disabled;
      };

      "module/pulseaudio" = {
        type 				= "internal/pulseaudio";
        format-volume-prefix 		= "VOL ";
        format-volume-prefix-foreground = colors.primary;
        format-volume 			= "<label-volume>";
        label-volume 			= "%percentage%";
        label-muted 			= "muted";
        label-muted-foreground 		= colors.disabled;
      };

      "module/xkeyboard" = {
        type 				= "internal/xkeyboard";
        blacklist-0 			= "num lock";
        label-layout 			= "%layout%";
        label-layout-foreground 	= colors.primary;
        label-indicator-padding 	= "2";
        label-indicator-margin 		= "1";
        label-indicator-foreground 	= colors.background;
        label-indicator-background 	= colors.secondary;
      };

      "module/memory" = {
        type 				= "internal/memory";
        interval 			= "2";
        format-prefix 			= "RAM ";
        format-prefix-foreground 	= colors.primary;
        label 				= "%percentage_used:2%%";
      };

      "module/cpu" = {
        type 				= "internal/cpu";
        interval 			= "2";
        format-prefix 			= "CPU ";
        format-prefix-foreground 	= colors.primary;
        label 				= "%percentage:2%%";
      };

      "module/battery" = {
        type 				= "internal/battery";
        format-prefix 			= "BAT ";
        format-prefix-foreground 	= colors.primary;
        full-at 			= "99";
        format-charging 		= "<animation-charging> <label-charging>";
        animation-charging-0 		= " ";
        animation-charging-1 		= " ";
        animation-charging-2 		= " ";
        animation-charging-3 		= " ";
        animation-charging-4 		= " ";
        animation-charging-framerate 	= "750";
        animation-charging-foreground 	= colors.peach;
        format-discharging 		= "<ramp-capacity> <label-discharging>";
        ramp-capacity-0 		= " ";
        ramp-capacity-1 		= " ";
        ramp-capacity-2 		= " ";
        ramp-capacity-3 		= " ";
        ramp-capacity-4 		= " ";
        low-at 				= "5";
        battery 			= "BAT1";
        adapter 			= "ACAD";
        poll-interval 			= "5";
      };

      "network-base" = {
	type 				= "internal/network";
	interval 			= "5";
	format-connected 		= "<label-connected>";
	format-disconnected 		= "<label-disconnected>";
	label-disconnected 		= "%{F#F0C674}%ifname%%{F#707880} disconnected";
      };

      "module/wlan" = {
        "inherit" 			= "network-base";
        interface-type 			= "wireless";
        label-connected 		= "%{F#F0C674}%ifname%%{F-} %essid%";
      };

      "module/eth" = {
        "inherit" 			= "network-base";
        interface-type 			= "wired";
        label-connected 		= "%{F#F0C674}%ifname%%{F-} %local_ip%";
      };

      "module/date" = {
        type 				= "internal/date";
        interval 			= "1";
        date 				= "%H:%M";
        date-alt 			= "%Y-%m-%d %H:%M:%S";
        label 				= "%date%";
        label-foreground 		= colors.primary;
      };

      "settings" = {
	screenchange-reload		= true;
	pseudo-transparency 		= true;      
      };
    };
  };
}
