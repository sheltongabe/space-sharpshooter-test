package arm;

import iron.math.Vec4;
import iron.system.Input;
import armory.trait.physics.bullet.RigidBody;
import iron.object.Object;
import iron.object.CameraObject;
import armory.trait.physics.PhysicsWorld;

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
	}

	/**
 	 * @brief	Apply the forces to the object in the direction requested
	 */
	public function update() {
		// Make sure the body is ready
		if(!body.ready)
			return;
		
		// Update properties
		this.appliedForce = object.properties["APPLY_FORCE"];

		// Apply Movement Forces
		var actions:Array<Action> = this.getKeyActions();
		for(action in actions) {
			switch(action) {
				case FORWARD:
					body.applyForce(new Vec4(0.0, this.appliedForce));
					break;

				case BACKWARD:
					body.applyForce(new Vec4(0.0, -this.appliedForce));
					break;

				case STRAFE_LEFT:
					body.applyForce(new Vec4(-this.appliedForce));
					break;

				case STRAFE_RIGHT:
					body.applyForce(new Vec4(this.appliedForce));
					break;
			}
		}

		// Sync the transformations made between the physics and transformation matrix
		body.syncTransform();
	}

	/// Change Direction with mouse input
	private function Aim() {
		var mouse:iron.system.Input.Mouse = Input.getMouse();
		var dx = mouse.movementX;
		var dy = mouse.movementY;

	}

	/**
	 * @brief	Get any key presses and return them as Key Actions
	 * @return	An array of actions that are to be done
	 */
	private function getKeyActions():Array<Action> {
		var actions:Array<Action> = new Array<Action>();
		var keyboard:Keyboard = Input.getKeyboard();

		if(keyboard.down("w"))
			actions.push(FORWARD);
		if(keyboard.down("s"))
			actions.push(BACKWARD);
		if(keyboard.down("a"))
			actions.push(STRAFE_LEFT);
		if(keyboard.down("d"))
			actions.push(STRAFE_RIGHT);

		return actions;
	}

	/**
	 * @brief	Any Removal code
	 */
	public function kill() {

	}
}

