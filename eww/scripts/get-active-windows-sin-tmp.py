#!/usr/bin/env python3

import i3ipc
import os
import time
import subprocess

i3 = i3ipc.Connection()

colors =  [ "#6C9EEF",  # Color 0
            "#B688EA",  # Color 1
            "#E8A3D4",  # Color 2
            "#EB6C8F",  # Color 3
            "#F19D69",  # Color 4
            "#EDD090",  # Color 5
            "#89DB80",  # Color 6
            "#53C9B4",  # Color 7
            "#6BD2E3",  # Color 8
            "#56BAE6"]  # Color 9

ex_xborders_cmd  = "xborders --border-mode outside --border-radius 17 --border-width 3 --border-rgba "
xborders_cmd     = "xborders --border-mode outside --border-radius 5  --border-width 3 --border-rgba "

def process_up(process):
    try:
        call = subprocess.check_output("pidof '{}'".format(process), shell=True)
        return True
    except subprocess.CalledProcessError:
        return False

def workspace_focus(self, ws):

    # update ws
    with open('/tmp/ws', 'a') as file:
        file.write(str(ws.current.name) + "\n")

    current_color = colors[int(ws.current.name)]

    # change rofi theme
    with open('/home/rosu/.config/rofi/accent.rasi', 'w') as file:
        file.write("*{ urgent: " + current_color + " ;}")

    # Cambio el color de xborders
    # Mato el proceso anterior
    os.system("killall xborders")
   
    # Chequeo si Picom está activo
    pidOfPicom = process_up("picom")
    if not pidOfPicom:
        # Inicio picom
        subprocess.Popen("picom")


    # Y luego lo vuelvo a empezar
    subprocess.Popen("sleep 0.3; " + xborders_cmd + "\'" + current_color + "\'", shell=True)

# update active-windows and vivaldi-theme
def window_focus(self, w):
    
    if w.container.name:

        # update vivaldi theme        
        if "Vivaldi" in w.container.name:
    
            # Hay que esperar un poquito porque sino lo siguiente se ejecuta antes de lograr enfocar la ventana
            time.sleep(0.3)
    
            # Get the current workspace
            current_ws = 1
            for ws in i3.get_workspaces():
                if ws.focused:
                    current_ws = ws.name
    
            os.system('xdotool key alt+ctrl+shift+' + str(current_ws))

    update_active_windows(self, w)

# update active-windows
def window_move(self, w):
    update_active_windows(self, w)

# wait 1 and update active-windows
def window_close(self, _):
    # Hay que esperar un poco antes de actualizar las ventanas porque sino las ventanas se actualizan
    # antes de que se sepa que la ventana se cerró.
    time.sleep(1)
    update_active_windows(self, _)

def update_active_windows(self, _):

    workspaces = i3.get_tree().workspaces()

    for workspace in workspaces: # Por si acaso habria que chequear si esto es iterable

        container = workspace

        while container:
            if not hasattr(container, 'focus') or not container.focus:
                break

            container_id = container.focus[0]
            container = container.find_by_id(container_id)

        if container:

            coname = container.name
            wsname = workspace.name

            if coname:

                if "Discord" in coname:
                	shortconame = "d"
                elif "Vivaldi" in coname:
                	shortconame = "v"
                elif "Sublime" in coname:
                	shortconame = "s"
                elif "Telegram" in coname:
                	shortconame = "t"
                elif ".pdf" in coname:
                	shortconame = "z"
                else:
                	shortconame = "*"

                os.system(f"eww update ws_{int(wsname)}={shortconame}")

# Subscribe to events
i3.on("workspace::focus", workspace_focus) # update active-ws
i3.on("window::move",     window_move)     # update active-windows
i3.on("window::close",    window_close)    # wait 1 and update active-windows
i3.on("window::new",      window_focus)    # update active-windows and vivaldi-theme 
i3.on("window::focus",    window_focus)    # update active-windows and vivaldi-theme  

# Start the main loop and wait for events to come in.
i3.main()