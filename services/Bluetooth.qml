pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
	property bool enabled: false

	function toggle(): void {
		bluetoothToggle.running = true
	}

	Process {
		id: bluetoothToggle

		command: ["sh", "-c", `bluetoothctl power ${Bluetooth.enabled ? "off" : "on"}`]
	}

	Process {
		id: bluetoothEnabled

		command: [
			"sh", "-c",

			"if bluetoothctl show | grep -q \"Powered: yes\"; then echo \"1\"; else echo \"0\"; fi;\n" +
			"bluetoothctl --monitor | while read -r line; do\n" +
			"  if echo \"$line\" | grep -q \"Powered: \\(yes\\|no\\)\"; then\n" +
			"    if echo \"$line\" | grep -q \"Powered: yes\"; then echo \"1\"; else echo \"0\"; fi;\n" +
			"  fi;\n" +
			"done"
		]

		running: true
		stdout: SplitParser {
			onRead: data => {
				Bluetooth.enabled = (parseInt(data) === 1)
			}
		}
	}
}
