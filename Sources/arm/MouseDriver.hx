package arm;

/**
 * @file	MouseDriver.hx
 * @brief	Define a mouse input device
 */

import iron.system.Input;
import iron.system.Input.Mouse;

/**
 * @class 	MouseDriver
 * @brief	Handle an index set for buttons, track movement, and handle hiding
 */
class MouseDriver {
	/// Mouse
	var mouse:Mouse;

	/// Is the mouse hidden
	var isHidden:Bool = false;

	/// Index of the mouse buttons pressed
	var mouseIndex:Map<String, Bool>;

	/// Constructor
	public function new() {
		this.mouse = Input.getMouse();
		this.isHidden = this.mouse.hidden;

		this.mouseIndex = [
			"left" => false,
			"middle" => false,
			"right" => false
		];
	}

	/// Update mouseIndex and mouseMovement
	public function update() {
		for(button in mouseIndex.keys()) {
			this.mouseIndex[button] = this.mouse.down(button);
		}

		// If the mouse is shown and left button is pressed,
		// hide the mouse
		if(!this.isHidden && this.mouse.down("left")) {
			this.hideCursor();
		}
	}

	/// Called when escape is pressed, and shows mouse if needed
	public function escapePressed() {
		if(this.isHidden) {
			this.showCursor();
		}
	}

	/**
	 * @brief	Return if the passed button is pressed
	 * @param	button		Button to check [left, right, middle]
	 * @return	Is the button pressed
	 */
	public function isPressed(button:String):Bool {
		return this.mouseIndex[button];
	}

	/// Hide the mouse
	public function hideCursor() {
		this.mouse.hide();
		this.mouse.lock();
		this.isHidden = mouse.hidden;
	}
	
	/// Show the mouse
	public function showCursor() {
		this.mouse.show();
		this.mouse.unlock();
		this.isHidden = mouse.hidden;
	}
}
