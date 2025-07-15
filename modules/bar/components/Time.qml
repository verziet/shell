import "root:/config"
import "root:/services"

import QtQuick

Text {
	anchors.centerIn: parent

	text: Datetime.format("hh:mm")
	color: Appearance.colors.front
}
