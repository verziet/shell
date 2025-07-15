import "root:/types"
import "root:/services"

import QtQuick

MaterialSymbol {
	symbol: !Audio.source.muted ? "mic" : "mic_off"

	MouseArea {
		anchors.fill: parent
		onClicked: {
			Audio.source.toggle()
		}
	}
}
