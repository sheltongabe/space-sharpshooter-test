package arm;

/**
 * @file	Input.hx
 * @brief	Hold links to the Input Devices
 */

import arm.KeyboardDriver;

/**
 * @class	InputDriver
 * @brief	Act as an index for the input devices
 */
class InputDriver {
	/// KeyboardDriver
	public static var keyboard:KeyboardDriver;

	public function new() { }

	/// Initialize devices in they have not been
	public static function init() {
		if(InputDriver.keyboard == null) 
			InputDriver.keyboard = new KeyboardDriver();
	}
}
