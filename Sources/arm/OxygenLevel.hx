package arm;

import iron.system.Time;

import arm.ScreenTransition;

class OxygenLevel extends iron.Trait {
	/// Level of oxygen in the room out of 100
	static var oxygenLevel:Float = 100;

	/// The time the oxygen level was last decremented
	var previousTime:Float;

	/// INTERVAL
	var INTERVAL:Float = 1.0 / 16.0;

	public function new() {
		super();

		notifyOnInit(init);
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(remove);

		this.previousTime = Time.realTime();
	}

	public function update() {
		// Make sure we are in the game state
		if(ScreenTransition.getState() != GAME)
			return;

		// If the interval has passed since the last time remove from the level
		var currentTime:Float = Time.realTime();
		if(currentTime - this.previousTime >= this.INTERVAL) {
			OxygenLevel.oxygenLevel -= this.INTERVAL * object.properties["EMPTY_RATE"];
			this.previousTime = currentTime;
			trace("Oxygen Level: " + OxygenLevel.oxygenLevel);
			

			// If it has become less than 0, go to game over
			if(OxygenLevel.oxygenLevel <= 0) {
				ScreenTransition.gameOver();
			}
		}
	}

	public function kill() {

	}

	public static function getOxygenLevel() {
		return OxygenLevel.oxygenLevel;
	}
}
