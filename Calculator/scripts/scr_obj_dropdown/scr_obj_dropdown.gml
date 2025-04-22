function dropdown_options_add(_dropdown, _label, _value=undefined) {
	if (is_undefined(_value)) {
		_value = _label;
	}
	var _option = ds_map_create();
	ds_map_add(_option, "label", _label);
	ds_map_add(_option, "value", _value);
	ds_list_add(_dropdown, _option);
}

/**
 * @function						dropdown_create
 * @description					This function will create a dropdown using the predefined arguments.
 * @param {Real}					_x - The x position of the center of the dropdown
 * @param {Real}					_y - The y position of the center of the dropdown
 * @param {String | Id.Layer} _layer - The layer where the dropdown is created
 * @param {String}				_name - The name of the dropdown (used for getting the dropdown's value)
 * @param {Real}					_width - The width of the dropdown
 * @param {Real}					_height - The height of the dropdown
 * @param {Id.DsList}			_options - List the possible options for the dropdown
 * @param {Bool}					_has_display - Whether to display the box or not
 * @return {Asset.GMObject}
 */

function dropdown_create(
	_x, _y, _layer, _name, _width, _height,
	_options=undefined, _has_display=false, 
	_display_margin_top=32
) {
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
	if (_has_display) {
		var _display = instance_create_layer(
			_x, _y + _display_margin_top, _layer, obj_dropdown_display,
			{
				width: _width,
				height: _height,
				name: _name
			}	
		)
	}
	return _dropdown_id;
}

/**
 * @function					dropdown_destroy
 * @description				The function destroys the given dropdown.
 * @param {Asset.GMObject}	_dropdown - The id of the dropdown
 * @return {Undefined}
 */

function dropdown_destroy(_dropdown) {
	with (_dropdown) {
		if (typeof(options) == "ref" and ds_exists(options, ds_type_list)) {
			ds_list_destroy_all(options);
		}
		instance_destroy(self);
	}
}

/**
 * @function					dropdown_get_value
 * @description				This function gets the current value of the given dropdown.
 * @param {Asset.GMObject}	_dropdown - The id of the dropdown
 */

function dropdown_get_value(_dropdown) {
	with (_dropdown) {
		return options[| current_option_id][? "value"];
	}
}
