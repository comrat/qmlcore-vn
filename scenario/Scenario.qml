Object {
	property string firstChapter;

	build: {
		const chapterType = _globals.qmlcore_vn.scenario.Chapter;
		const textLineType = _globals.qmlcore_vn.scenario.TextLine;
		const jumpToType = _globals.qmlcore_vn.scenario.JumpTo;
		const choiceType = _globals.qmlcore_vn.scenario.Choice;
		const choiceOptionType = _globals.qmlcore_vn.scenario.ChoiceOption;

		const chapters = this.children.filter((child) => child instanceof chapterType);

		let scenario = {};
		this.firstChapter = "";

		for (const i in chapters) {
			const chapter = chapters[i];
			if (!this.firstChapter) {
				this.firstChapter = chapter.title;
			}

			scenario[chapter.title] = { steps: [] };
			for (const j in chapter.children) {
				const token = chapter.children[j];
				if (token instanceof textLineType) {
					scenario[chapter.title].steps.push({
						text: token.text,
						character: token.character
					});
				} else if (token instanceof jumpToType) {
					scenario[chapter.title].steps.push({
						nextScene: token.nextScene
					});
				} else if (token instanceof choiceType) {
					scenario[chapter.title].steps.push({
						choice: { options: [] }
					});
					for (const k in token.children) {
						const option = token.children[k];
						const steps = scenario[chapter.title].steps;
						if (option instanceof choiceOptionType) {
							steps[steps.length - 1].choice.options.push({
								text: option.text,
								jumpTo: option.jumpTo,
								callback: $core.createSignalForwarder(option, 'choosed').bind(option)
							});
						}
					}
				}
			}
		}
		this.scenario = scenario;
	}

	getJson: {
		return this.scenario;
	}
}
