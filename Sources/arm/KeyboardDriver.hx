package arm;

/**
 * @file	KeyboardDriver.hx
 * @brief	Handle all keyboard input and provide an index
 */

import iron.system.Input;
import kha.input.KeyCode;
import iron.system.Input.Keyboard;

/**
 * @class 	KeyboardDriver
 * @brief	Provide an index for if keys are pressed
 */
class KeyboardDriver {
	/// String for Escape
	public static var ESCAPE:String = Keyboard.keyCode(KeyCode.Escape);

	/// Keyboard to use
	var keyboard:Keyboard;

	/// Map of keyboard controls to a boolean of them being pressed
	var keyIndex:Map<String, Bool>;

	/// Constructor
	public function new() {
		this.keyboard = Input.getKeyboard();

		// Key index
		this.keyIndex = [
			"w" => false,
			"a" => false,
			"s" => false,
			"d" => false,
			"space" => false,
			"p" => false,
			ESCAPE => false
		];
	}

	/// Update the keyIndex with the keyboard
	public function update() {
		for(key in this.keyIndex.keys()) {
			this.keyIndex[key] = this.keyboard.down(key);
		}

		// Check if escape is pressed, and if so show the mouse
		if(this.isPressed(KeyboardDriver.ESCAPE))
			InputDriver.mouse.escapePressed();
	}

	/**
	 * @brief	Return if the passed key was pressed
	 * @param	key		Key to test
	 * @return	Is the key pressed
	 */
	public function isPressed(key:String):Bool {
		return this.keyIndex[key];
	}
}
