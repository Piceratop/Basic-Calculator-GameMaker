function dropdown_add_options(_dropdown, _label, _value) {
	if (is_undefined(_value)) {
		_value = _label;
	}
	var _option = ds_map_create();
	ds_map_add(_option, "label", _label);
	ds_map_add(_option, "value", _value);
	ds_list_add(_dropdown, _option);
}