import "root:/config"
import "root:/services"
import "components"

import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
	anchors {
		top: Appearance.bar.position === Appearance.BarPosition.Top
		left: true
		right: true
		bottom: Appearance.bar.position === Appearance.BarPosition.Bottom
	}

	implicitHeight: Appearance.bar.height

	color: Appearance.colors.back

	Time {}

	RowLayout {
		spacing: 5

		SourceIcon {}
		SinkIcon {}
		BluetoothIcon {}
		WifiIcon {}
		EthernetIcon {}

		anchors {
			right: parent.right
			verticalCenter: parent.verticalCenter
		}
	}
}
