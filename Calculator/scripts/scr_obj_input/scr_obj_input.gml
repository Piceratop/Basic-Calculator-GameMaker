function input_create(
	_x, _y, _layer, _name, _width, _height, _value,
	_is_active=false,
) {
	var _input_instance = instance_create_layer(_x, _y, _layer, obj_input, {
		is_active: _is_active,
		height: _height,
		value: _value,
		width: _width
	});
	return _input_instance;
}