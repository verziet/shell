pragma Singleton

import Quickshell
import QtQuick

Singleton {
	enum BarPosition { Top, Bottom }

	readonly property QtObject colors: QtObject {
		readonly property string back: "black"
		readonly property string front: "white"
	}

	readonly property QtObject bar: QtObject {
		readonly property var position: Appearance.BarPosition.Top
		readonly property int height: 25
	}
}
