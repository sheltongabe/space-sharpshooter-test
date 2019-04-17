package arm;

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
	}

	public function update() {

	}

	/// Handle a hit and remove if nessassary
	public function hit(damage:Int = 1) {
		this.health -= damage;
		if(this.health < 0.0) {
			object.remove();
		}
	}

	/// Return the health of the target
	public function getHealth():Float {
		return this.health;
	}

	public function kill() {

	}
}
