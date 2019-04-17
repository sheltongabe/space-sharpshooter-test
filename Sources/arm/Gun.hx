package arm;

import iron.object.Transform;
import iron.math.Quat;
import iron.math.Vec4;
import iron.Scene;
import iron.object.Object;
import arm.InputDriver;
import armory.trait.physics.bullet.RigidBody;
import iron.system.Time;

/**
 * @class 	Gun
 * @brief	Handle spawning Laser's and propeling them forward
 */
class Gun extends iron.Trait {
	/// The time of the last shot
	var time:Float;

	/// Interval for shot
	var SHOT_INTERVAL:Float = 0.5;

	/// Constructor
	public function new() {
		super();

		notifyOnInit(init);
	}

	/// Init
	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);
		this.time = Time.realTime();
	}

	/// Update each frame
	public function update() {
		var mouse = InputDriver.mouse;

		// If the left mouse button is clicked and the cursor is hidden
		if(mouse.hidden() && mouse.isPressed("left")) {
			if(Time.realTime() - this.time > this.SHOT_INTERVAL) {
				this.time = Time.realTime();
				this.shoot();
			}
		}
	}

	/// Spawn and propel a laser
	private function shoot() {
		var direction:Quat = object.transform.rot;
		var gunLoc:Vec4 = object.transform.loc;
		var spawnLoc:Transform = Scene.active.getChild("Laser Spawn").transform;

		Scene.active.spawnObject("Laser", null, function(o:Object) {
			var body = o.getTrait(RigidBody);
			var rot:Quat = object.parent.transform.rot;
			trace(rot);

			o.transform.loc.x = spawnLoc.worldx();
			o.transform.loc.y = spawnLoc.worldy();
			o.transform.loc.z = spawnLoc.worldz();
			o.transform.rotate(Vec4.xAxis(), rot.x);
			o.transform.rotate(Vec4.yAxis(), rot.y);
			o.transform.rotate(Vec4.zAxis(), rot.z);

			o.transform.buildMatrix();
			body.syncTransform();
			o.visible = true;
			body.disableGravity();

			var look:Vec4 = object.parent.transform.up().mult(-1);
			var firingStrength:Float = object.properties["SHOOT_VEL"];
			body.setLinearVelocity(look.x * firingStrength, look.y * firingStrength, look.z * firingStrength);
		});
	}

	/// When the object is removed
	public function kill() {

	}
}
