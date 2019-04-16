package arm;

import iron.Scene;
import armory.trait.physics.RigidBody;
import armory.trait.physics.PhysicsWorld;

class LaserCollision extends iron.Trait {
	/// This bullets rigid body
	var body:RigidBody;

	public function new() {
		super();
		notifyOnInit(init);
	}

	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);

		this.body = object.getTrait(RigidBody);
	}

	public function update() {
		// Get collisions
		var contacts:Array<RigidBody> = PhysicsWorld.active.getContacts(this.body);
		

		if(contacts == null)
			return;

		// Check if a target was hit
		for(contact in contacts) {
			if(contact.transform.object.name == "Target") {
				//object.properties["NUM_COL"] += 1;
				object.remove();
			}
		}
	}

	public function kill() {

	}
}
