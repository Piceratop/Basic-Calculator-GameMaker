function dropdown_create(_x, _y, _layer, _name, _width, _height, _options=undefined) {
	if (is_undefined(_options)) {
		_options = ds_list_create();
	}
	var _dropdown_id = instance_create_layer(
		_x, _y,	_layer, obj_dropdown,
		{
			dropdown_height: _height,
			dropdown_width: _width,
			name: _name,
			options: _options,
		}
	);
	return _dropdown_id;
}

function dropdown_add_options(_dropdown, _label, _value=undefined) {
	if (is_undefined(_value)) {
		_value = _label;
	}
	var _option = ds_map_create();
	ds_map_add(_option, "label", _label);
	ds_map_add(_option, "value", _value);
	ds_list_add(_dropdown, _option);
}