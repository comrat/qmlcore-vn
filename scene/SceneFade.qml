Rectangle {
	property int duration: 500;
	property bool display;
	anchors.fill: parent;
	color: parent.fadeColor;
	opacity: display ? 1 : 0;
	visible: false;

	Timer {
		id: sceneFadeTimer;
		interval: parent.duration;

		onTriggered: {
			const parent = this.parent;
			if (parent.display && parent.callback) {
				parent.callback()
			} else if (!parent.display) {
				parent.visible = false;
			}
		}
	}

	show(callback): {
		this.visible = true;
		this.display = true;
		this.callback = callback;
		sceneFadeTimer.restart();
	}

	hide: {
		this.display = false;
		sceneFadeTimer.restart();
	}

	Behavior on opacity { Animation { duration: parent.duration; } }
}
