pragma Singleton

import Quickshell
import QtQuick

Singleton {
	enum BarPosition { Top, Bottom }

	readonly property QtObject colors: QtObject {
		readonly property string back: "black"
		readonly property string front: "white"
	}

	readonly property QtObject fonts: QtObject {
		readonly property QtObject symbols: QtObject {
			readonly property string family: "Material Symbols Rounded"
			readonly property int size: 20
		}
	}

	readonly property QtObject bar: QtObject {
		readonly property var position: Appearance.BarPosition.Top
		readonly property int height: 25
	}
}
