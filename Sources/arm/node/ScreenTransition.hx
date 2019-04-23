package arm.node;

@:keep class ScreenTransition extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _AddTrait = new armory.logicnode.AddTraitNode(this);
		var _AddTrait_002 = new armory.logicnode.AddTraitNode(this);
		_AddTrait_002.addInput(new armory.logicnode.NullNode(this), 0);
		_AddTrait_002.addInput(new armory.logicnode.ObjectNode(this, "Camera"), 0);
		var _Trait_002 = new armory.logicnode.TraitNode(this);
		_Trait_002.property0 = "UpdateTargetsRemaining";
		_Trait_002.addOutputs([_AddTrait_002]);
		_AddTrait_002.addInput(_Trait_002, 0);
		_AddTrait_002.addOutputs([_AddTrait]);
		_AddTrait.addInput(_AddTrait_002, 0);
		_AddTrait.addInput(new armory.logicnode.ObjectNode(this, "Camera"), 0);
		var _Trait = new armory.logicnode.TraitNode(this);
		_Trait.property0 = "GameCanvas";
		_Trait.addOutputs([_AddTrait]);
		_AddTrait.addInput(_Trait, 0);
		_AddTrait.addOutputs([new armory.logicnode.NullNode(this)]);
		var _OnKeyboard = new armory.logicnode.OnKeyboardNode(this);
		_OnKeyboard.property0 = "Released";
		_OnKeyboard.property1 = "1";
		_OnKeyboard.addOutputs([new armory.logicnode.NullNode(this)]);
		var _RemoveTrait = new armory.logicnode.RemoveTraitNode(this);
		_RemoveTrait.addInput(new armory.logicnode.NullNode(this), 0);
		var _GetTrait = new armory.logicnode.GetTraitNode(this);
		_GetTrait.addInput(new armory.logicnode.ObjectNode(this, "Camera"), 0);
		_GetTrait.addInput(new armory.logicnode.StringNode(this, "Start"), 0);
		_GetTrait.addOutputs([_RemoveTrait]);
		_RemoveTrait.addInput(_GetTrait, 0);
		_RemoveTrait.addOutputs([new armory.logicnode.NullNode(this)]);
		var _AddTrait_001 = new armory.logicnode.AddTraitNode(this);
		var _OnInit = new armory.logicnode.OnInitNode(this);
		_OnInit.addOutputs([_AddTrait_001]);
		_AddTrait_001.addInput(_OnInit, 0);
		var _GetObject = new armory.logicnode.GetObjectNode(this);
		_GetObject.addInput(new armory.logicnode.StringNode(this, "Camera"), 0);
		_GetObject.addOutputs([_AddTrait_001]);
		_AddTrait_001.addInput(_GetObject, 0);
		var _Trait_001 = new armory.logicnode.TraitNode(this);
		_Trait_001.property0 = "Start";
		_Trait_001.addOutputs([_AddTrait_001]);
		_AddTrait_001.addInput(_Trait_001, 0);
		_AddTrait_001.addOutputs([new armory.logicnode.NullNode(this)]);
	}
}