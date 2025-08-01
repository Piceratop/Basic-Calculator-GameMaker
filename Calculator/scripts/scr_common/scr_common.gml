/**
 * @function				scroll_obj
 * @description			This function scrolls a scrollable object.
 * @param {Asset.GMObject}			_object - The object to be scrolled
 * @return {Undefined}
 */

function scroll_obj(_object){
	if (mouse_wheel_up() and _object.y_scroll > 0) {
		_object.y_scroll -= max(0, global.y_single_scroll);
	}
	if (mouse_wheel_down() and _object.y_scroll < _object.y_max_scroll) {
		_object.y_scroll += min(_object.y_max_scroll, global.y_single_scroll);
	}

	_object.y = _object.y_original - _object.y_scroll;
}

function is_allowed_mode(_allowed_mode, _mode=global.current_mode) {
	return array_contains(_allowed_mode, _mode);
}