package arm;

import iron.math.Vec4;
import iron.system.Input;
import armory.trait.physics.bullet.RigidBody;
import iron.object.Object;
import iron.object.CameraObject;

import arm.InputDriver;

enum Action {
	FORWARD;
	BACKWARD;
	STRAFE_LEFT;
	STRAFE_RIGHT;
}

class FPPlayerMovement extends iron.Trait {
	/// Force to apply
	var appliedForce:Float;

	/// Camera
	var camera:Object;

	/// Rigid body for the player object
	var body:RigidBody;

	/// Constructor
	public function new() {
		super();

		// Register Init hook
		notifyOnInit(init);
	}

	/**
	 * @brief	Initialize the first-person controls
	 */
	public function init() {
		// Register Update and Kill
		notifyOnUpdate(update);
		notifyOnRemove(kill);

		this.camera = object.getChildOfType(CameraObject);
		this.body = object.getTrait(RigidBody);
		body.notifyOnInit(function() {
			body.setGravity(new Vec4(0, 0, -4.9));
		});

		// If the Input devices have not been initialized yet, initialize them
		InputDriver.init();
	}

	/**
 	 * @brief	Apply the forces to the object in the direction requested
	 */
	public function update() {
		// Update the input devices
		InputDriver.keyboard.update();
		InputDriver.mouse.update();

		// Make sure the body is ready
		if(!body.ready)
			return;
		
		// Jump if needed
		if(object.properties["jump"]) {
			this.body.applyImpulse(new Vec4(0, 0, 8));
			object.properties["jump"] = false;
			trace("Jumping");
		}

		// Update properties
		this.appliedForce = object.properties["APPLY_FORCE"];
		
		//body.activate();
		// Apply Movement Forces
		var dir:Vec4 = new Vec4();
		var actions:Array<Action> = this.getKeyActions();
		for(action in actions) {
			switch(action) {
				case FORWARD:
					dir.add(object.transform.look());
					break;

				case BACKWARD:
					dir.add(object.transform.look().mult(-1));
					break;

				case STRAFE_LEFT:
					dir.add(object.transform.right().mult(-1));
					break;

				case STRAFE_RIGHT:
					dir.add(object.transform.right());
					break;
			}
		}
		// Make sure the max speed is not exceeded
		if(body.getLinearVelocity().length() < object.properties["MAX_VEL"]) {
			dir.mult(this.appliedForce);
			body.applyForce(dir);
		}

		// Sync the transformations made between the physics and transformation matrix
		body.setAngularFactor(0, 0, 0);
		body.syncTransform();

		this.Aim();
		object.transform.buildMatrix();
		camera.transform.buildMatrix();
	}

	/// Change Direction with mouse input
	private function Aim() {
		// If the mouse is not hidden return
		if(!InputDriver.mouse.hidden())
			return;

		var mouse:iron.system.Input.Mouse = Input.getMouse();
		var dx = mouse.movementX;
		var dy = mouse.movementY;

		// Compute local x axis, by reflecting the x-coordinate
		//var localX:Vec4 = object.transform.look().applyAxisAngle(Vec4.zAxis(), 3.14 / 2.0);

		camera.transform.rotate(Vec4.zAxis(), -dx * object.properties["MOUSE_SCALE"]);
		object.transform.rotate(Vec4.zAxis(), -dx * object.properties["MOUSE_SCALE"]);
		camera.transform.rotate(object.transform.right().mult(-1),
			dy * object.properties["MOUSE_SCALE"]);
		
		body.syncTransform();
	}

	/**
	 * @brief	Get any key presses and return them as Key Actions
	 * @return	An array of actions that are to be done
	 */
	private function getKeyActions():Array<Action> {
		var actions:Array<Action> = new Array<Action>();
		var keyboard = InputDriver.keyboard;

		if(keyboard.isPressed("w"))
			actions.push(FORWARD);
		if(keyboard.isPressed("s"))
			actions.push(BACKWARD);
		if(keyboard.isPressed("a"))
			actions.push(STRAFE_LEFT);
		if(keyboard.isPressed("d"))
			actions.push(STRAFE_RIGHT);

		return actions;
	}

	/**
	 * @brief	Any Removal code
	 */
	public function kill() {

	}
}

