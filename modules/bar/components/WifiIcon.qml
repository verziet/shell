import "root:/types"
import "root:/services"

import QtQuick

MaterialSymbol {
	symbol: !Network.wifi.enabled ? "signal_wifi_off" : Network.wifi.strength >= 85 ? "signal_wifi_4_bar" : Network.wifi.strength >= 70 ? "network_wifi" : Network.wifi.strength >= 55 ? "network_wifi_3_bar" : Network.wifi.strength >= 40 ? "network_wifi_2_bar" : Network.wifi.strength >= 25 ? "network_wifi_1_bar" : Network.wifi.strength >= 10 ? "network_wifi_0_bar" : "signal_wifi_bad"

	MouseArea {
		anchors.fill: parent
		onClicked: {
			Network.wifi.toggle()
		}
	}
}
