pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
	readonly property QtObject wifi: QtObject {
		property bool enabled: true
		property int strength: 85

		function toggle(): void {
			wifiToggle.running = true
		}
	}

	readonly property QtObject ethernet: QtObject {
		property bool connected: false
	}

	Process {
		id: wifiToggle

		command: ["sh", "-c", `nmcli radio wifi ${Network.wifi.enabled ? "off" : "on"}`]
	}

	Process {
		id: wifiEnabled

		command: [
			"sh", "-c",

			"DEVS=\"\";\n" +
			"for path in /sys/class/net/*; do\n" +
			"  dev=${path##*/};\n" +
			"  [ -d /sys/class/net/$dev/wireless ] || continue;\n" +
			"  DEVS=\"$DEVS $dev\";\n" +
			"done;\n" +
			"DEVS=\"$(echo $DEVS)\";\n" +
			"if [ -z \"$DEVS\" ]; then\n" +
			"  echo \"No WiFi device found\";\n" +
			"  exit 1;\n" +
			"fi;\n" +
			"INIT=0;\n" +
			"for dev in $DEVS; do\n" +
			"  [ \"$(cat /sys/class/net/$dev/operstate)\" = \"up\" ] && { INIT=1; break; };\n" +
			"done;\n" +
			"echo $INIT;\n" +
			"ip monitor link | while IFS=: read _ dev rest; do\n" +
			"  dev=$(echo $dev);\n" +
			"  case \" $DEVS \" in *\" $dev \"*)\n" +
			"    flags=$(echo \"$rest\" | sed -n 's/.*<\\([^>]*\\)>.*/\\1/p');\n" +
			"    case \"$flags\" in *UP*) echo 1;;\n" +
			"    *) echo 0;;\n" +
			"    esac;\n" +
			"  ;;\n" +
			"  esac;\n" +
			"done"
		]

		running: true
		stdout: SplitParser {
			onRead: data => {
				Network.wifi.enabled = parseInt(data) === 1;
			}
		}
	}

	Process {
		id: wifiStrength

		command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}'"]

		running: true
		stdout: SplitParser {
			onRead: data => {
				Network.wifi.strength = parseInt(data);
			}
		}
	}

	Process {
		id: ethernetConnected

		command: [
        "sh", "-c",

        "get_ethernet_devs() {\n" +
        "  DEVS=\"\"\n" +
        "  for path in /sys/class/net/*; do\n" +
        "    dev=${path##*/}\n" +
        "    [ -d \"/sys/class/net/$dev/wireless\" ] && continue\n" +
        "    [ \"$(cat /sys/class/net/$dev/type 2>/dev/null)\" = \"1\" ] || continue\n" +
        "    DEVS=\"$DEVS $dev\"\n" +
        "  done\n" +
        "  echo \"$DEVS\" | tr -s ' '\n" +
        "}\n" +
        "DEVS=$(get_ethernet_devs)\n" +
        "INIT=0\n" +
        "for dev in $DEVS; do\n" +
        "  [ \"$(cat /sys/class/net/$dev/operstate 2>/dev/null)\" = \"up\" ] && { INIT=1; break; }\n" +
        "done\n" +
        "echo \"$INIT\"\n" +
        "ip monitor link | while IFS=: read _ dev rest; do\n" +
        "  dev=$(echo \"$dev\" | tr -d ' ')\n" +
        "  DEVS=$(get_ethernet_devs)\n" +
        "  ANY_UP=0\n" +
        "  for d in $DEVS; do\n" +
        "    d_operstate=$(cat /sys/class/net/$d/operstate 2>/dev/null)\n" +
        "    if [ \"$d_operstate\" = \"up\" ]; then\n" +
        "      ANY_UP=1\n" +
        "      break\n" +
        "    fi\n" +
        "    if [ \"$d\" = \"$dev\" ]; then\n" +
        "      flags=$(echo \"$rest\" | sed -n 's/.*<\\([^>]*\\)>.*/\\1/p')\n" +
        "      if [[ \"$flags\" == *UP*LOWER_UP* || \"$flags\" == *LOWER_UP*UP* ]]; then\n" +
        "        ANY_UP=1\n" +
        "        break\n" +
        "      fi\n" +
        "    fi\n" +
        "  done\n" +
        "  echo \"$ANY_UP\"\n" +
        "done"
    ]

		running: true
		stdout: SplitParser {
			onRead: data => {
				Network.ethernet.connected = parseInt(data) === 1
			}
		}
	}


	Timer {
		interval: 5000

		running: true
		repeat: true

		onTriggered: wifiStrength.running = true
	}
}
