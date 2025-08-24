/**
 * @function				scroll_obj
 * @description			This function scrolls a scrollable object.
 * @param {Asset.GMObject}			_object - The object to be scrolled
 * @return {Undefined}
 */

function scroll_obj(_object, _single_scroll){
	if (mouse_wheel_up() and _object.y_scroll > 0) {
		_object.y_scroll -= max(0, _single_scroll);
	}
	if (mouse_wheel_down() and _object.y_scroll < _object.y_max_scroll) {
		_object.y_scroll += min(_object.y_max_scroll, _single_scroll);
	}

	_object.y = _object.y_original - _object.y_scroll;
}

function is_allowed_mode(_banned_modes, _mode=global.current_mode) {
	return not array_contains(_banned_modes, _mode);
}