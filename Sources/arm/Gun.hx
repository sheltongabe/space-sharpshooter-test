package arm;

import iron.math.Mat4;
import iron.math.Vec4;
import iron.Scene;
import iron.object.Object;
import arm.InputDriver;

/**
 * @class 	Gun
 * @brief	Handle spawning Laser's and propeling them forward
 */
class Gun extends iron.Trait {
	/// Constructor
	public function new() {
		super();

		notifyOnInit(init);
	}

	/// Init
	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);
	}

	/// Update each frame
	public function update() {
		var mouse = InputDriver.mouse;

		// If the left mouse button is clicked and the cursor is hidden
		if(mouse.hidden() && mouse.isPressed("left"))
			this.shoot();
	}

	/// Spawn and propel a laser
	private function shoot() {
		var direction:Vec4 = object.transform.look().normalize();
		direction.mult(0.5);
		var respawnLoc:Vec4 = Scene.active.getChild("Laser Spawn").transform.loc;
		trace("Gun: " + respawnLoc);

		Scene.active.spawnObject("Laser", null, function(o:Object) {
			
			o.transform.rotate(Vec4.yAxis(), Math.PI / 2);
			o.transform.loc.add(respawnLoc);
			o.transform.buildMatrix();
			o.visible = true;
			trace("Laser" + o.transform.loc);
		});
	}

	/// When the object is removed
	public function kill() {

	}
}
