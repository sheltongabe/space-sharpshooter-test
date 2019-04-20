package arm;

import arm.ScreenTransition;

class OxygenLevel extends iron.Trait {
	public function new() {
		super();

		notifyOnInit(init);
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(remove);
	}

	public function update() {

	}

	public function kill() {

	}
}
