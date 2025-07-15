pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

import QtQuick

Singleton {
	readonly property PwNode _sink: Pipewire.defaultAudioSink
	readonly property PwNode _source: Pipewire.defaultAudioSource

	readonly property QtObject sink: QtObject {
		property bool muted: _sink?.audio.muted ?? false
		property int volume: Math.round(_sink?.audio.volume * 100)

		function toggle() {
			if (_sink?.ready) {
				_sink.audio.muted = !muted
			}
		}
	}

	readonly property QtObject source: QtObject {
		property bool muted: _source?.audio.muted ?? true

		function toggle() {
			if (_source?.ready) {
				_source.audio.muted = !muted
			}
		}
	}

	PwObjectTracker {
		objects: [_sink, _source]
	}
}
