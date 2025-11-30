Rectangle {
	property int animationDuration;
	property bool musicLooped: true;
	property string image;
	property string music;
	anchors.fill: parent;

	Audio { id: bgMusic; }

	Image {
		id: bgImage;
		anchors.fill: parent;
	}

	updateBackground: {
		bgImage.source = this.image
	}

	onImageChanged: { this.updateBackground() }
}
