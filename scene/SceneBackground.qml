Rectangle {
	id: sceneBackgroundProto;
	signal loaded;
	property int animationDuration;
	property bool musicLooped: true;
	property string image;
	property string music;
	anchors.fill: parent;

	Image {
		id: bgImage;
		anchors.fill: parent;

		onStatusChanged: {
			if (value === Image.Ready || value === Image.Error) {
				sceneBackgroundProto.loaded();
			}
		}
	}

	updateBackground: {
		bgImage.source = this.image;
	}

	onImageChanged: {
		this.updateBackground();
	}
}
