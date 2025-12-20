ActivityManager {
	anchors.fill: context;
	clip: true;

	Audio {
		id: bgMusic;
		autoPlay: true;
		loop: true;
	}

	startGame(firstScene, data): {
		this.push(firstScene, data);
	}

	showScene(scene, data): {
		this.replaceTopActivity(scene, data);
	}

	playMusic(url): {
		bgMusic.source = ""
		bgMusic.source = url
	}

	pauseMusic: {
		bgMusic.pause()
	}
}
