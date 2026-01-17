# QMLCORE-VN (WIP)
QMLCORE-VN is a plugin for [PureQML](https://github.com/pureqml/qmlcore) to create visual novels or text quest projects declaratively

## Components
### Scenario
Describes scene scenario steps (aka `Chapters` in qmlcore-vn). Just place one of these elements inside:
 * TextLine — a line of dialogue spoken by a character
 * Choice — a choice step with different answer options (`ChoiceOption`)
 * JumpTo — this step jumps to another scene specified by the `nextScene` property

The scenario begins with the first declared chapter. Here's an example of a scenario with conditional branches:
<details>
<summary>ScenarioExample.qml</summary>

 ```
 Scenario {
		Chapter {
			title: "entrypoint";

			TextLine {
				character: "Charachter name";
				text: "Hello! Are you OK?";
			}

			Choice {
				ChoiceOption {
					text: "Yes";
					jumpTo: "yesChapter";
				}

				ChoiceOption {
					text: "No";
					jumpTo: "noChapter";
				}
			}
		}

		Chapter {
			title: "yesChapter";

			TextLine {
				character: Charachter name;
				text: "Glad to hear it";
			}

			GotoObject {
				nextScene: "goodEnding";
			}
		}

		Chapter {
			title: "noChapter";

			TextLine {
				character: Charachter name;
				text: "What's wrong?";
			}

			GotoObject {
				nextScene: "badEnding";
			}
		}
 }
 ```
</details>

### Character
Used to display a character on the scene. Character images must be stored in the directory specified by `charactersAssetDir`. All character states should be PNG images named according to the character's `name` and optional `tag`. Filenames for a character are prefixed with the character's `name`. To display a character image with a specific tag, include `_tag` at the end of the filename, e.g., `charactername_happy.png`

<details>
<summary>Examlpe</summary>

```
Charachter {
	name: "user";
	tag: "happy";
	charachtersAssetDir: "assets/charachters/";
}

```

This will load the image: `assets/characters/user_happy.png`
</details>

### DialogBox
*To be described*

### Scene
Each scene should inherit from Scene.qml. Set up it's `backgroundImage`, `backgroundMusic`, and `scenario` flow
*To be described*


<details>
<summary>Scene usage example</summary>

```
Scene {
	id: introScene;
	backgroundImage: "assets/background/kitchen.jpg";
	backgroundMusic: "assets/music/intro.m4a";
	scenario: ScenarioExample { }
    
    Character {
		id: charachter;
		name: "user";
		tag: "happy";
		anchors.right: parent.right;
		anchors.rightMargin: 300s;
		height: 600s;
	}

	DialogBox {
		id: dialog;
		textTypedDelay: 30;
		gradient: Gradient {
			GradientStop { color: "#0000"; position: 0.0; }
			GradientStop { color: "#0005"; position: 0.2; }
			GradientStop { color: "#000e"; position: 1.0; }
		}
	}

	ChoiceDialog {
		id: choice;
		delegate: ChoiceDelegate {
			onPressed: {
				introScene.handleChoice(model);
			}
		}
	}

	NextButton {
		anchors.right: parent.right;
		anchors.verticalCenter: dialog.verticalCenter;
		anchors.rightMargin: 20s;

		onPressed: { introScene.moveNext(); }
	}

	onTriggered(line): {
		if (line.text) {
			choice.reset();
			dialog.setText(line.character, line.text);
		} else if (line.choice) {
			choice.show(line.choice.options);
		}
	}

	approveMethod: {
		game.currentCatTag = "happy";
	}

	declineMethod: {
		game.currentCatTag = "angry";
	}
}
```

</details>

## Example

You can check a simple project example here: [PureNovel](https://github.com/comrat/purenovel)
