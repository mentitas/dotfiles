#!/usr/bin/env python3

import json
import i3ipc

i3 = i3ipc.Connection()

def workspace_focus(self, e):
    f = open("/tmp/ws", "a")
    f.write(str(e.current.name) + "\n")
    f.close()

def window_change(self, _):

    workspaces = i3.get_tree().workspaces()

    info = ["" for i in range(10)]

    for workspace in workspaces:
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
i3.on("window::move",  window_change)
i3.on("window::new",   window_change)
i3.on("window::close", window_change)
i3.on("workspace::focus", workspace_focus)

# Start the main loop and wait for events to come in.
i3.main()