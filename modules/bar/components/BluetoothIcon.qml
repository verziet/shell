import "root:/types"
import "root:/services"

import QtQuick

MaterialSymbol {
	symbol: Bluetooth.enabled ? "bluetooth" : "bluetooth_disabled"

	MouseArea {
		anchors.fill: parent
		onClicked: {
			Bluetooth.toggle()
		}
	}
}
