Image {
	id: characterImage;
	property int animationDuration;
	property string name;
	property string tag;
	property string charactersAssetDir: "assets/characters/";
	width: parent.width / 3;
	height: parent.height / 2;
	fillMode: Image.PreserveAspectFit;
	anchors.bottom: parent.bottom;

	updateImage: {
		if (this.tag) {
			this.source = this.charactersAssetDir + this.name + "_" + this.tag + ".png";
		} else {
			this.source = this.charactersAssetDir + this.name + ".png";
		}
	}

	onTagChanged,
	onNameChanged: {
		this.updateImage();
	}
}
