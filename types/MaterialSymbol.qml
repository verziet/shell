import "root:/config"

import QtQuick

Text {
	required property string symbol

	text: symbol

	color: Appearance.colors.front

	font {
		family: Appearance.fonts.symbols.family
		pixelSize: Appearance.fonts.symbols.size
	}
}
