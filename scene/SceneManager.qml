ActivityManager {
	property int fadeDuration: 500;
	property bool showFade: true;
	property Color fadeColor: "#000";
	anchors.fill: context;
	clip: true;

	Audio {
		id: bgMusic;
		autoPlay: true;
		loop: true;
	}

	SceneFade {
		id: sceneFade;
		duration: parent.fadeDuration;
		anchors.fill: parent;
		color: parent.fadeColor;
		z: 100500;
	}

	showScene(scene, data): {
		if (this.showFade) {
			sceneFade.show(function() {
				this.replaceTopActivity(scene, data);
			}.bind(this))
		} else {
			this.replaceTopActivity(scene, data);
		}
	}

	playMusic(url): {
		bgMusic.source = ""
		bgMusic.source = url
	}

	pauseMusic: {
		bgMusic.pause();
	}

	hideFade: {
		if (this.showFade) {
			sceneFade.hide();
		}
	}
}
