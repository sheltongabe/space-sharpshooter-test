package arm;

import iron.Scene;

import arm.ScreenTransition;

class TargetHealth extends iron.Trait {
	/// Health
	var health:Float;

	public function new() {
		super();
		notifyOnInit(init);
		
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);

		this.health = Math.random() % object.properties["MAX_HEALTH"] + 1;
		
		// Add a target to targets remaining
		Scene.active.camera.properties["targets_remaining"] = Scene.active.camera.properties["targets_remaining"] + 1;
	}

	public function update() {

	}

	/// Handle a hit and remove if nessassary
	public function hit(damage:Int = 1) {
		this.health -= damage;
		if(this.health < 0.0) {
			// Destroy target
			object.remove();
			Scene.active.camera.properties["targets_remaining"] = Scene.active.camera.properties["targets_remaining"] - 1;
			
			// If number of targets is 0, move to win state
			if(Scene.active.camera.properties["targets_remaining"] == 0) {
				ScreenTransition.gameWon();
			}
		}
	}

	/// Return the health of the target
	public function getHealth():Float {
		return this.health;
	}

	public function kill() {

	}
}
