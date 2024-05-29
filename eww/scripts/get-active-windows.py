#!/usr/bin/env python3

import i3ipc
import os
import time
import subprocess

i3 = i3ipc.Connection()

colors =  [ "#6c9eef",  # Color 0
            "#b688ea",  # Color 1
            "#e8a3d4",  # Color 2
            "#eb6c8f",  # Color 3
            "#f19d69",  # Color 4
            "#edd090",  # Color 5
            "#89db80",  # Color 6
            "#53c9b4",  # Color 7
            "#6bd2e3",  # Color 8
            "#56bae6"]  # Color 9

colors_rgb = ["--border-red 108 --border-green 158 --border-blue 239", # Color 0 in RGB
              "--border-red 182 --border-green 136 --border-blue 234", # Color 1 in RGB
              "--border-red 232 --border-green 163 --border-blue 212", # Color 2 in RGB
              "--border-red 235 --border-green 108 --border-blue 143", # Color 3 in RGB
              "--border-red 241 --border-green 157 --border-blue 105", # Color 4 in RGB
              "--border-red 237 --border-green 208 --border-blue 144", # Color 5 in RGB
              "--border-red 137 --border-green 219 --border-blue 128", # Color 6 in RGB
              "--border-red 83  --border-green 201 --border-blue 180", # Color 7 in RGB
              "--border-red 107 --border-green 210 --border-blue 227", # Color 8 in RGB
              "--border-red 86  --border-green 186 --border-blue 230"] # Color 9 in RGB

def workspace_focus(self, ws):

    # update ws
    with open('/tmp/ws', 'a') as file:
        file.write(str(ws.current.name) + "\n")

    # change rofi theme
    with open('/home/rosu/.config/rofi/accent.rasi', 'w') as file:
        file.write("*{ urgent: " + colors[int(ws.current.name)] + " ;}")

    # change xborders theme
    # ¿Tengo que matar al proceso?
    # subprocess.run("sleep 0.3; \
    #                 xborders --border-mode outside --border-radius 17 --border-width 3 " + str(colors_rgb[ws_int]),
    #                 shell=True)

# update active-windows and vivaldi-theme
def window_focus(self, w):
    
    # update vivaldi theme        
    if "Vivaldi" in w.container.name:

        # Hay que esperar un poquito porque sino lo siguiente se ejecuta antes de lograr enfocar la ventana
        time.sleep(0.3)

        # Get the current workspace
        current_ws = -1
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

    info = ["" for i in range(10)]

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

            if "Discord" in coname:
            	coname = "d"
            elif "Vivaldi" in coname:
            	coname = "v"
            elif "Sublime" in coname:
            	coname = "s"
            elif "Telegram" in coname:
            	coname = "t"
            elif ".pdf" in coname:
            	coname = "z"
            else:
            	coname = "*"

            info[int(wsname)] = coname

    
    # Save as an array recognizable by eww

    f = open("/tmp/ws-info", "a")
    f.write("[ ")

    for i in range(0,10):
        f.write(' "' + info[i] + '"')
        if i != 9:
            f.write(', ')     
    f.write(" ] \n")
    f.close()

# Subscribe to events
#i3.on("workspace::focus", on_event)
i3.on("workspace::focus", workspace_focus) # update active-ws
i3.on("window::move",     window_move)     # update active-windows
i3.on("window::close",    window_close)    # wait 1 and update active-windows
i3.on("window::new",      window_focus)    # update active-windows and vivaldi-theme 
i3.on("window::focus",    window_focus)    # update active-windows and vivaldi-theme  

# Start the main loop and wait for events to come in.
i3.main()
