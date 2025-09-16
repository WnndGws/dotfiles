from easyland import logger, command

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


# def idle_config():
# return [
# [150, ["brightnessctl -s set 0"], ["brightnessctl -r"]],
# [600, ["pidof hyprlock || hyprlock"]],
# [720, ["hyprctl dispatch dpms off"], ["hyprctl dispatch dpms on"]],
# ]
#
#
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


def set_monitors():
    logger.info("Setting monitors")
    if hostname == "arch-beast":
        # command.exec('hyprctl keyword monitor "eDP-1,preferred,auto,2"')
        command.exec('hyprctl keyword monitor "DP-2,1920x1080@60, 0x0, 1"')
        command.exec(
            # Uses the scaled resolution!
            'hyprctl keyword monitor "DP-3,1920x1080@60, -720x0, 1.5, transform, 3"'
        )
        command.exec('hyprctl keyword monitor "HDMI-A-1,1920x1080@60, 0x-1080, 1"')
    else:
        command.exec('hyprctl keyword monitor "eDP-1,preferred,auto,1"')
        # command.exec("brightnessctl -s set 0")


def set_workspaces():
    logger.info("Setting monitors")
    if hostname == "arch-beast":
        command.exec('hyprctl keyword workspace "1, monitor:DP-2"')
        command.exec('hyprctl keyword workspace "2, monitor:DP-2"')
        command.exec('hyprctl keyword workspace "3, monitor:DP-2"')
        command.exec('hyprctl keyword workspace "4, monitor:DP-2"')
        command.exec('hyprctl keyword workspace "5, monitor:DP-3"')
        command.exec('hyprctl keyword workspace "6, monitor:DP-3"')
        command.exec('hyprctl keyword workspace "7, monitor:HDMI-A-1"')
        command.exec('hyprctl keyword workspace "8, monitor:HDMI-A-1"')
        command.exec('hyprctl keyword workspace "9, monitor:HDMI-A-1"')
        command.exec('hyprctl keyword workspace "10, monitor:HDMI-A-1"')


def run_waybar():
    logger.info("Setting monitors")
    if hostname == "arch-beast":
        command.exec(
            "pkill waybar || true && waybar --config ~/.config/waybar/beast_config.jsonc"
        )
    else:
        command.exec(
            "pkill waybar || true && waybar --config ~/.config/waybar/laptop_config.jsonc"
        )
