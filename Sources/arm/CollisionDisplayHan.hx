package arm;

class CollisionDisplayHan extends iron.Trait {
	public function new() {
		super();

		notifyOnInit(init);
	
	public function init() {
		notifyOnUpdate(update);
		notifyOnRemove(kill);
	}
	
	public function update() {
	
	}
	
	public function kill() {
	
	}
}
