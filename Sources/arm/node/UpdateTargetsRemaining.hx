package arm.node;

@:keep class UpdateTargetsRemaining extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _CanvasSetText = new armory.logicnode.CanvasSetTextNode(this);
		var _OnUpdate = new armory.logicnode.OnUpdateNode(this);
		_OnUpdate.property0 = "Update";
		_OnUpdate.addOutputs([_CanvasSetText]);
		_CanvasSetText.addInput(_OnUpdate, 0);
		_CanvasSetText.addInput(new armory.logicnode.StringNode(this, "txtRemainingTargets"), 0);
		var _GetProperty = new armory.logicnode.GetPropertyNode(this);
		_GetProperty.addInput(new armory.logicnode.ObjectNode(this, "Camera"), 0);
		_GetProperty.addInput(new armory.logicnode.StringNode(this, "targets_remaining"), 0);
		_GetProperty.addOutputs([_CanvasSetText]);
		_CanvasSetText.addInput(_GetProperty, 0);
		_CanvasSetText.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}