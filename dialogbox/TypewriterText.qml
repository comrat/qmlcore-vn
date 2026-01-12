Text {
	id: typewriterProto;
	signal triggered;
	property int delay;
	property string typedText;
	width: 200s;
	wrapMode: Text.WordWrap;

	Timer {
		id: typewriterTimer;
		interval: parent.delay;

		onTriggered: {
			if (typewriterProto._currentIndex < typewriterProto.typedText.length) {
				typewriterProto.addNextLetter();
				typewriterProto.triggered();
			}
		}
	}

	addNextLetter: {
		this.text += this.typedText[this._currentIndex++];
		typewriterTimer.restart();
	}

	onTypedTextChanged: {
		if (this.delay) {
			this.text = "";
			this._currentIndex = 0;
			this.addNextLetter();
		} else {
			this.text = this.typedText;
		}
	}
}
