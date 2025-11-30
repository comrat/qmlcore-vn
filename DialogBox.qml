Rectangle {
	property string image;

	property string title;
	property int titleFontFamily: "Roboto Regular";
	property int titleFontSize: 36s;
	property color titleColor: "#81C784";

	property string text;
	property int textFontFamily: "Roboto Regular";
	property int textFontSize: 21s;
	property color textColor: "#ffffff";
	width: 100%;
	height: 30%;
	anchors.bottom: parent.bottom;
	color: "#000c";
	opacity: dialogTitle.text || dialogText.text ? 1 : 0;

	Image {
		id: dialogBgImage;
		anchors.fill: parent;
	}

	Text {
		id: dialogTitle;
		y: 10s;
		x: 10s;
		color: parent.titleColor;
		font.family: parent.titleFontFamily;
		font.pixelSize: parent.titleFontSize;
	}

	Text {
		id: dialogText;
		x: dialogTitle.x;
		anchors.top: dialogTitle.bottom;
		anchors.topMargin: 10s;
		color: parent.textColor;
		font.family: parent.textFontFamily;
		font.pixelSize: parent.textFontSize;
	}

	setText(title, text, textColor): {
		dialogTitle.text = title;
		dialogText.text = text;
		if (textColor) {
			this.titleColor = textColor;
		}
	}

	onImageChanged: { dialogBgImage.source = image; }
}
