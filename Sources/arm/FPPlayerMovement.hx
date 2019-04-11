package arm;

import armory.trait.physics.bullet.RigidBody;
import iron.object.Object;
import iron.object.CameraObject;
import armory.trait.physics.PhysicsWorld;

class FPPlayerMovement extends iron.Trait {
	/// Camera
	var camera:Object;
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
	}

	/**
	 * @brief	Any Removal code
	 */
	public function kill() {

	}
}
