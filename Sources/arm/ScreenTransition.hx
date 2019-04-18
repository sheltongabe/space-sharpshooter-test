package arm;

import iron.Scene;
import armory.trait.internal.CanvasScript;
import arm.InputDriver;

enum ScreenState {
	START;
	GAME;
	END;
}

class ScreenTransition extends iron.Trait {
	/// The current ScreenState
	var state:ScreenState = START;

	/// The Canvas
	var canvas:CanvasScript;

	public function new() {
		super();
		notifyOnInit(init);
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);

		// Register Canvas
		this.canvas = Scene.active.camera.getTrait(CanvasScript);
		this.canvas.getElement("lblRemainingTargets").visible = false;
		this.canvas.getElement("txtRemainingTargets").visible = false;
	}

	public function update() {
		
	}

	public function kill() {

	}

	private function goToGameState() {
		this.canvas.getElement("lblStart").visible = false;
		this.canvas.getElement("lblRemainingTargets").visible = true;
		this.canvas.getElement("txtRemainingTargets").visible = true;
		this.state = Game;
	}

	public function getState() {

	}
}
