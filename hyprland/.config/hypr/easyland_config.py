from easyland import command, logger

###############################################################################
# Set active listeners
###############################################################################

listeners = {
    "hyprland": {},
    "systemd_logind": {},
    "idle": {},
}


def init():
    set_monitors()
    set_workspaces()
    run_waybar()


###############################################################################
# Idle configuration
# Format: [timeout in seconds, [commands to run], [commands to run on resume]]
###############################################################################


def idle_config():
    return [
        [600, ["brightnessctl -s set 10"], ["brightnessctl -r"]],
        [900, ["hyprctl dispatch dpms off"], ["hyprctl dispatch dpms on"]],
        [1200, ["pidof hyprlock || hyprlock"], ["hyprctl dispatch dpms on"]],
    ]


# ###############################################################################
# # Handler of Hyprland IPC events
# # List of events: https://wiki.hyprland.org/IPC/
# ###############################################################################
#
#
# def on_hyprland_event(event, argument):
# if event in ["monitoradded", "monitorremoved", "configreloaded"]:
# logger.info("Handling hyprland event: " + event)
# set_monitors()
#
# ## When disconnecting my laptop, a new workspace is created. We switch back to a default workspace
# if event == "monitorremoved":
# command.exec("hyprctl dispatch workspace 5", True)
#
# ## Sometimes, Waybar or wpaperd crashes
# if event in ["monitoradded", "monitorremoved"]:
# command.exec("pkill waybar || true && waybar", background=True)
# command.exec("pkill wpaperd || true && wpaperd -d", background=True)
#
def on_hyprland_event(event, argument):
    if event in ["monitoradded"]:
        logger.info("Monitor added")
        # Set laptop monitor at 0x0
        command.exec('hyprctl keyword monitor "eDP-1,preferred,0x0,1"')
        # Set TV to the right
        command.exec("pactl set-sink-volume @DEFAULT_SINK@ 100%")
        command.exec("pactl set-sink-mute @DEFAULT_SINK@ false")

    if event in ["monitorremoved"]:
        logger.info("Monitor removed")
        # Set laptop monitor at 0x0
        run_waybar()
        command.exec("pactl set-sink-volume @DEFAULT_SINK@ 50%")
        command.exec("pactl set-sink-mute @DEFAULT_SINK@ true")


#
# ###############################################################################
# # Handlers of Systemd logind events
# ###############################################################################
#
#
# def on_PrepareForSleep(payload):
# if "true" in payload:
# logger.info("Locking the screen before suspend")
# command.exec("pidof hyprlock || hyprlock", True)
#
#
# # To use this handler, you need to launch your locker (hyprlock or swaylock) like this: hyprlock && loginctl unlock-session
# # def on_Unlock():
# #     logger.info("Unlocking the screen")
#
# # To use this handler, you need to launch your locker like this: loginctl lock-session
# # def on_lock():
# #     logger.info("Locking the screen")
#
###############################################################################
# Various methods
###############################################################################

hostname = command.get_system_hostname()
logger.info("hostname is " + hostname)

monitors_attached = command.exec(
    "hyprctl monitors | awk -F'[ :]' '/^Monitor / {print $2}'"
)
monitors_attached = [monitor for monitor in monitors_attached]
logger.info(f"number of monitors: {len(monitors_attached)}")


def set_monitors():
    logger.info("Setting monitors")
    # just use 16 for now, need to fix to 3
    if len(monitors_attached) == 16:
        # command.exec('hyprctl keyword monitor "eDP-1,preferred,auto,2"')
        command.exec('hyprctl keyword monitor "DP-3,1920x1080@60, 0x0, 1"')
        command.exec('hyprctl keyword monitor "DP-4,1920x1080@60, 0x-1080, 1"')
        command.exec('hyprctl keyword monitor "eDP-1,1920x1080@60, -1920x0, 1"')
    elif hostname == "arch-beast":
        command.exec(
            'hyprctl --instance 0 keyword monitor "HDMI-A-1,1920x1080@60, 0x0, 1"'
        )
        command.exec(
            'hyprctl --instance 0 keyword monitor "DP-2,1920x1080@60, 0x-1080, 1"'
        )
    else:
        command.exec('hyprctl keyword monitor "eDP-1,preferred,auto,1"')
        # command.exec("brightnessctl -s set 0")


def set_workspaces():
    logger.info("Setting monitors")


def run_waybar():
    logger.info("Setting monitors")
    if hostname == "arch-beast":
        command.exec(
            'hyprctl --instance 0 dispatch exec "pkill waybar || true && waybar --config ~/.config/waybar/beast_config.jsonc"',
            background=True,
        )
    else:
        command.exec(
            "pkill waybar || true && waybar --config ~/.config/waybar/laptop_config.jsonc",
            background=True,
        )
