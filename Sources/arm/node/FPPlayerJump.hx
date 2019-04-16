package arm.node;

@:keep class FPPlayerJump extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _SetProperty_001 = new armory.logicnode.SetPropertyNode(this);
		var _SetProperty = new armory.logicnode.SetPropertyNode(this);
		var _Gate = new armory.logicnode.GateNode(this);
		_Gate.property0 = "And";
		_Gate.property1 = 9.999999747378752e-05;
		var _OnKeyboard = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard.property0 = "Down";
		_OnKeyboard.property1 = "space";
		_OnKeyboard.addOutputs([_Gate]);
		_Gate.addInput(_OnKeyboard, 0);
		var _GetProperty = new armory.logicnode.GetPropertyNode(this);
		_GetProperty.addInput(new armory.logicnode.ObjectNode(this, "Player"), 0);
		_GetProperty.addInput(new armory.logicnode.StringNode(this, "can_jump"), 0);
		_GetProperty.addOutputs([_Gate]);
		_Gate.addInput(_GetProperty, 0);
		var _Boolean = new armory.logicnode.BooleanNode(this);
		_Boolean.addInput(new armory.logicnode.BooleanNode(this, true), 0);
		_Boolean.addOutputs([_Gate]);
		_Gate.addInput(_Boolean, 0);
		_Gate.addOutputs([_SetProperty]);
		_Gate.addOutputs([new armory.logicnode.NullNode(this)]);
		_SetProperty.addInput(_Gate, 0);
		_SetProperty.addInput(new armory.logicnode.ObjectNode(this, "Player"), 0);
		_SetProperty.addInput(new armory.logicnode.StringNode(this, "jump"), 0);
		var _Boolean_001 = new armory.logicnode.BooleanNode(this);
		_Boolean_001.addInput(new armory.logicnode.BooleanNode(this, true), 0);
		var _SetProperty_002 = new armory.logicnode.SetPropertyNode(this);
		var _OnContact = new armory.logicnode.OnContactNode(this);
		_OnContact.property0 = "Begin";
		_OnContact.addInput(new armory.logicnode.ObjectNode(this, "Player"), 0);
		_OnContact.addInput(new armory.logicnode.ObjectNode(this, "floor"), 0);
		_OnContact.addOutputs([_SetProperty_002]);
		_SetProperty_002.addInput(_OnContact, 0);
		_SetProperty_002.addInput(new armory.logicnode.ObjectNode(this, "Player"), 0);
		_SetProperty_002.addInput(new armory.logicnode.StringNode(this, "can_jump"), 0);
		_SetProperty_002.addInput(_Boolean_001, 0);
		_SetProperty_002.addOutputs([new armory.logicnode.NullNode(this)]);
		_Boolean_001.addOutputs([_SetProperty, _SetProperty_002]);
		_SetProperty.addInput(_Boolean_001, 0);
		_SetProperty.addOutputs([_SetProperty_001]);
		_SetProperty_001.addInput(_SetProperty, 0);
		_SetProperty_001.addInput(new armory.logicnode.ObjectNode(this, "Player"), 0);
		_SetProperty_001.addInput(new armory.logicnode.StringNode(this, "can_jump"), 0);
		var _Boolean_002 = new armory.logicnode.BooleanNode(this);
		_Boolean_002.addInput(new armory.logicnode.BooleanNode(this, false), 0);
		_Boolean_002.addOutputs([_SetProperty_001]);
		_SetProperty_001.addInput(_Boolean_002, 0);
		_SetProperty_001.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}