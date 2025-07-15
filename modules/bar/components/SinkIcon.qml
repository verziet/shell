import "root:/types"
import "root:/services"

import QtQuick

MaterialSymbol {
	symbol: Audio.sink.muted ? "volume_off" : Audio.sink.volume >= 50 ? "volume_up" : Audio.sink.volume > 0 ? "volume_down" : "volume_mute"

	MouseArea {
		anchors.fill: parent
		onClicked: {
			Audio.sink.toggle()
		}
	}
}
