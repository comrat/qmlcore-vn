Activity {
	signal next;
	signal finished;
	signal triggered;
	property int currentLine;
	property string backgroundImage;
	property string backgroundMusic;
	property string currentSequence;
	anchors.fill: parent;

	Background { image: parent.backgroundImage; }

	moveNextImpl: {
		const scenario = this.scenario;
		if (!scenario) {
			log("Scenario not found");
			return;
		}

		const subScene = scenario[this.currentSequence];
		const lines = scenario[this.currentSequence].lines;
		const currIdx = this.currentLine;

		if (currIdx >= 0 && currIdx < lines.length) {
			this.triggered(lines[currIdx]);
			++this.currentLine;
		}
	}

	handleChoice(option): {
		const jumpTo = option.jumpTo;
		const scenario = this.scenario;

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
		if (this[callback]) {
			this[callback]();
		}
	}

	moveNext: {
		this.moveNextImpl();
	}

	setSequence(entrypoint): {
		const scenario = this.scenario;
		if (!scenario) {
			log("Scenario not found");
			return;
		}

		if (!scenario[entrypoint]) {
			log(entrypoint, "doesn't exist in the scenario");
			return;
		}

		this.currentLine = 0;
		this.currentSequence = entrypoint;
		this.moveNextImpl();
	}

	setupScene(scenario): {
		this.currentLine = 0;
		this.currentSequence = "";
		this.scenario = scenario;
	}
}
