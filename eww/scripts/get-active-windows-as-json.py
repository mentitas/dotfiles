#!/usr/bin/env python3

import json
import i3ipc

i3 = i3ipc.Connection()

def on_move(self, _):
    print("una ventana se movió!")

def on_new(self, _):
    print("una ventana se creó!")

def on_close(self, _):
    print("una ventana se cerró!")

info = {
    "1": {
        "window": "",
        "focus":  "false"
    },
    "2": {
        "window": "",
        "focus":  "false"
    },
    "3": {
        "window": "",
        "focus":  "false"
    },
    "4": {
        "window": "",
        "focus":  "false"
    },
    "5": {
        "window": "",
        "focus":  "false"
    },
    "6": {
        "window": "",
        "focus":  "false"
    },
    "7": {
        "window": "",
        "focus":  "false"
    },
    "8": {
        "window": "",
        "focus":  "false"
    },
    "9": {
        "window": "",
        "focus":  "false"
    },
    "0": {
        "window": "",
        "focus":  "false"
    }
}


def on_ws(self, _):
    print("cambiamos de ws!")

    tree = i3.get_tree()

    workspaces = tree.workspaces()

    for workspace in workspaces:
        
        wsname = workspace.name

        info[wsname]["window"] = ""
        info[wsname]["focus"]  = workspace.focused

        container = workspace

        while container:
            if not hasattr(container, 'focus') or not container.focus:
                break

            container_id = container.focus[0]
            container = container.find_by_id(container_id)

        if container:
            coname = container.name

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

            info[wsname]["window"] = coname
    
    f = open("/tmp/ws-info", "w")
    f.write(str(info) + "\n")
    f.close()

# Subscribe to events
#i3.on("workspace::focus", on_event)
i3.on("window::move",   on_move)
i3.on("window::new",     on_new)
i3.on("window::close", on_close)
i3.on("workspace::focus", on_ws)

# Start the main loop and wait for events to come in.
i3.main()