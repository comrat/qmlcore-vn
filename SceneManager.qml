ActivityManager {
	anchors.fill: context;
	clip: true;

	startGame(firstScene, data): {
		this.push(firstScene, data);
	}

	showScene(scene, data): {
		this.replaceTopActivity(scene, data);
	}
}
