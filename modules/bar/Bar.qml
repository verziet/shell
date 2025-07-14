import "root:/config"
import "root:/services"

import Quickshell
import QtQuick

PanelWindow {
	anchors {
		top: Appearance.bar.position === Appearance.BarPosition.Top ? true : false
		left: true
		right: true
		bottom: Appearance.bar.position === Appearance.BarPosition.Bottom ? true : false
	}

	implicitHeight: Appearance.bar.height

	color: Appearance.colors.back

	Text {
		anchors.centerIn: parent

		text: Datetime.format("hh:mm")
		color: Appearance.colors.front
	}
}
