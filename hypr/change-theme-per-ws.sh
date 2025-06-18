#!/usr/bin/env bash

colors=("cba6f7" "f5c2e7" "f38ba8" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa")

# Va leyendo el nombre de las ventanas, y si la ventana se llama vivaldi le cambia el tema
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
    stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' |
  while IFS= read -r current_workspace; do
    
    current_color=${colors[(($current_workspace-1))]}

    # Change rofi theme
    echo "* { selected: #${current_color}; }" > /home/rosu/.config/rofi/accent.rasi
    
    # Change gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark-${current_workspace}

    # Change hyprland window borders
    # hyprctl keyword general:col.active_border 0xff${current_color} >> /dev/null

  done