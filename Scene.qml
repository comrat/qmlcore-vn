Activity {
	signal finished;
	signal triggered;
	signal nextScene;
	property int currentLine;
	property bool keepPlayingMusicAfter: true;
	property string backgroundImage;
	property string backgroundMusic;
	property string currentSequence;
	property Object scenario;
	anchors.fill: parent;

	Background { image: parent.backgroundImage; }

	moveNextImpl: {
		const scenario = this.scenario.getJson();

		if (!scenario) {
			log("Scenario not found");
			return;
		}

		const chapter = scenario[this.currentSequence];
		const steps = chapter.steps;
		const currIdx = this.currentLine;

		if (currIdx >= 0 && currIdx < steps.length) {
			if (steps[currIdx].nextScene && this.manager.showScene) {
				this.manager.showScene(steps[currIdx].nextScene)
			} else {
				this.triggered(steps[currIdx]);
			}
			++this.currentLine;
		}
	}

	handleChoice(option): {
		const jumpTo = option.jumpTo;
		const scenario = this.scenario.getJson();

		if (!scenario) {
			log("Scenario not found");
			return;
		}

		if (!scenario[jumpTo]) {
			log("can't jump to", jumpTo);
			return;
		}

		this.currentSequence = jumpTo;
		this.currentLine = 0;
		this.moveNextImpl();

		const callback = option.callback;
		if (callback) {
			callback();
		}
	}

	moveNext: {
		this.moveNextImpl();
	}

	setChapter(chapter): {
		const scenario = this.scenario.getJson();
		if (!scenario) {
			log("Scenario not found");
			return;
		}

		if (!scenario[chapter]) {
			log(chapter, "doesn't exist in the scenario");
			return;
		}

		this.currentLine = 0;
		this.currentSequence = chapter;
		this.moveNextImpl();
	}

	setupScene: {
		this.currentLine = 0;
		this.currentSequence = "";
		if (!this.scenario) {
			return;
		}

		this.scenario.build();
		const scenario = this.scenario.getJson();
		if (!this.scenario) {
			return;
		}
		this.currentSequence = this.scenario.firstChapter;
		this.setChapter(this.scenario.firstChapter);
	}

	onStopped: {
		if (this.backgroundMusic && !this.keepPlayingMusicAfter) {
			this.manager.pauseMusic();
		}
	}

	onStarted: {
		if (this.backgroundMusic) {
			this.manager.playMusic(this.backgroundMusic);
		}
	}

	onCompleted: { this.setupScene(); }
}
