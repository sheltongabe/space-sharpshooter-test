package arm.node;

@:keep class Lasercollision extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _Print = new armory.logicnode.PrintNode(this);
		var _OnContact = new armory.logicnode.OnContactNode(this);
		_OnContact.property0 = "Begin";
		_OnContact.addInput(new armory.logicnode.ObjectNode(this, "Laser"), 0);
		_OnContact.addInput(new armory.logicnode.ObjectNode(this, "Target"), 0);
		_OnContact.addOutputs([_Print]);
		_Print.addInput(_OnContact, 0);
		var _String = new armory.logicnode.StringNode(this);
		_String.addInput(new armory.logicnode.StringNode(this, "Contact made"), 0);
		_String.addOutputs([_Print]);
		_Print.addInput(_String, 0);
		_Print.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}