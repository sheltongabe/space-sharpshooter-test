package arm;

import iron.Scene;
import armory.trait.internal.CanvasScript;

import arm.InputDriver;
import arm.OxygenLevel;

enum ScreenState {
	START;
	GAME;
	END;
}

class ScreenTransition extends iron.Trait {
	/// The current ScreenState
	static var state:ScreenState = START;

	/// The Canvas
	static var canvas:CanvasScript;

	public function new() {
		super();
		notifyOnInit(init);
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);

		// Register Canvas
		ScreenTransition.canvas = Scene.active.camera.getTrait(CanvasScript);
		ScreenTransition.canvas.getElement("lblRemainingTargets").visible = false;
		ScreenTransition.canvas.getElement("txtRemainingTargets").visible = false;
	}

	public function update() {
		switch(ScreenTransition.state) {
			case START:
				if(InputDriver.keyboard.isPressed("space"))
					goToGameState();
			
			case GAME:
				ScreenTransition.canvas.getElement("txtOxygen").text = Std.string(OxygenLevel.getOxygenLevel() + "%");

			case END:
				if(InputDriver.keyboard.isPressed("p"))
					restart();
		}
	}

	/// Show Game Over Screen and move to END state
	public static function gameOver() {
		ScreenTransition.end();
		ScreenTransition.canvas.getElement("lblGameOver").visible = true;
	}
	
	/// Show Win Screen and move to END state
	public static function gameWon() {
		ScreenTransition.end();
		ScreenTransition.canvas.getElement("lblWon").visible = true;
	}

	public function kill() {

	}

	/// Go from start to playing game
	private function goToGameState() {
		// Hide Start State
		ScreenTransition.canvas.getElement("lblStart").visible = false;
		ScreenTransition.canvas.getElement("lblBegin").visible = false;

		// Show Game State
		ScreenTransition.canvas.getElement("lblRemainingTargets").visible = true;
		ScreenTransition.canvas.getElement("txtRemainingTargets").visible = true;
		ScreenTransition.canvas.getElement("lblOxygen").visible = true;
		ScreenTransition.canvas.getElement("txtOxygen").visible = true;
		ScreenTransition.state = GAME;
	}

	/// Display prompt to restart and move to end state
	private static function end() {
		ScreenTransition.state = END;
		
		// Hide Game State
		ScreenTransition.canvas.getElement("lblRemainingTargets").visible = false;
		ScreenTransition.canvas.getElement("txtRemainingTargets").visible = false;
		ScreenTransition.canvas.getElement("lblOxygen").visible = false;
		ScreenTransition.canvas.getElement("txtOxygen").visible = false;

		// Show End State
		ScreenTransition.canvas.getElement("lblRestart").visible = true;
	}

	/// Restart the game
	private static function restart() {
		// Hide END state
		ScreenTransition.canvas.getElement("lblRestart").visible = false;
		ScreenTransition.canvas.getElement("lblWon").visible = false;
		ScreenTransition.canvas.getElement("lblGameOver").visible = false;

		// Show Start State
		ScreenTransition.canvas.getElement("lblStart").visible = true;
		ScreenTransition.canvas.getElement("lblBegin").visible = true;

		// Reset the Scene
		iron.App.reset();
	}

	public static function getState() {
		return ScreenTransition.state;
	}
}
