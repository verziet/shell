import "root:/types"
import "root:/services"

import QtQuick

MaterialSymbol {
	symbol: "lan"
	visible: Network.ethernet.connected
}
