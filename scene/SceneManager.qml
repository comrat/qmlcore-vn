ActivityManager {
	property int fadeDuration: 500;
	property bool showFade: true;
	property Color fadeColor: "#000";
	anchors.fill: context;
	clip: true;

	Audio {
		id: bgMusic;
		loop: true;
	}

	Audio { id: sound; }

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

	playSound(url): {
		if (sound.ready) {
			return;
		} else if (sound.source === url) {
			sound.play();
		} else {
			sound.source = url;
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
