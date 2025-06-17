/**
 * @function			create_numpad
 * @description		This function will create the layout of a numpad.
 * @param {Real}		_x - The orthogonal position of the numpad's center
 * @param {Real}		_y - The vertical position of the numpad's center
 * @param {Array}		_layout - The array layout of the numpad
 * @param {Real}		_w - The width of the numpad
 * @param {Real}		_h - The height of a button
 * @param {Real}		_gap - The gap size between buttons
 * @param {String}	_layer - The layer to create the numpad
 * @param {Bool}		_has_divider - Create an upper divider
 */

function create_numpad(_x, _y, _layout, _w, _h = 40, _gap = 4, _layer = "Button", _has_divider = false) {
	var _full_button_height = _h + _gap;
	var _no_col = array_length(_layout);
	for (var _col = 0; _col < _no_col; _col++) {
		var _no_row = array_length(_layout[_col]);
		var _width_single_button = (_w - (_no_row - 1) * _gap) / _no_row;
		var _full_button_width = _width_single_button + _gap;
		for (var _row = 0; _row < _no_row; _row++) {
			var _button = instance_create_layer(
				_x + ((1 - _no_row) / 2 + _row) * _full_button_width,
				_y + ((1 - _no_col) / 2 + _col) * _full_button_height,
				_layer,
				obj_button,
				{
					sprite_index: spr_box_center,
					image_xscale: _width_single_button / sprite_get_width(spr_box_center),
					image_yscale: _h / sprite_get_height(spr_box_center),
					pos_x: _row,
					pos_y: _col,
					label: _layout[_col][_row] 
				}
			);
		}
	}
	if (_has_divider) {
		instance_create_layer(_x, _y - 3 * _full_button_height, _layer, obj_display_border);
	}
}

/**
 * @function           create_flex_numpad
 * @description        This function will generate a flex layout for a numpad.
 * @param {Array}      _button_layout - The layout of the button
 * @param {Real}       _padding - The padding from the edge of the room
 * @return {Pointer.FlexpanelNode}
 */

function create_flex_numpad(_button_layout, _padding=16) {
   var _gap = 4;
   var _flx_numpad_with_border = flexpanel_create_node({ width: "100%", justifyContent: "flex-end" });
   var _flx_border = flexpanel_create_node({ width: "100%", height: sprite_get_height(spr_border) })
	var _flx_numpad = flexpanel_create_node({ justifyContent: "flex-end", gap: _gap, padding: _padding, width: "100%" });
   for (var _i = 0; _i < array_length(_button_layout); _i++) {
      var _row = flexpanel_create_node({
         flexDirection: "row", width: "100%", gap: _gap
      });
      
      for (_j = 0; _j < array_length(_button_layout[_i]); _j++) {
         var _btn = flexpanel_create_node({ height: 40, flexGrow: 1, data: {
               label: _button_layout[_i][_j]
            } 
         });
         flexpanel_node_insert_child(_row, _btn, _j);
      }
   
      flexpanel_node_insert_child(_flx_numpad, _row, _i);
   }
   flexpanel_node_insert_child(_flx_numpad_with_border, _flx_border, 0);
   flexpanel_node_insert_child(_flx_numpad_with_border, _flx_numpad, 1);
   
   return _flx_numpad_with_border;
}

/**
 * @function           create_numpad_from_flex
 * @description        This function will generate a numpad from a flex layout.
 * @param {Pointer.FlexpanelNodel}    _flex_node - The width of the room
 * @param {Real}       _rm_width - The width of the room
 * @param {Real}       _rm_height - The height of the room
 * @return {Undefined}
 */

function create_numpad_from_flex(_flex_node, _rm_width, _rm_height) {
   flexpanel_calculate_layout(_flex_node, _rm_width, _rm_height, flexpanel_direction.LTR);
   
   var _border = flexpanel_node_get_child(_flex_node, 0);
   var _pos_border = flexpanel_node_layout_get_position(_border, false);
   instance_create_layer(
      _pos_border.left, _pos_border.top, "Border", obj_display_border, {
         image_xscale: _pos_border.width / sprite_get_width(spr_border),
      }
   )
   
   var _flx_numpad = flexpanel_node_get_child(_flex_node, 1);
   for (var _i = 0; _i < flexpanel_node_get_num_children(_flx_numpad); _i++) {
      var _row = flexpanel_node_get_child(_flx_numpad, _i);
      for (var _j = 0; _j < flexpanel_node_get_num_children(_row); _j++) {
         var _btn = flexpanel_node_get_child(_row, _j);
         var _btn_pos = flexpanel_node_layout_get_position(_btn, false);
         var _btn_data = flexpanel_node_get_data(_btn);
         var _inst = instance_create_layer(
            _btn_pos.left, _btn_pos.top, "Button", obj_button, {
               image_xscale: _btn_pos.width / sprite_get_width(spr_box_center),
               image_yscale: _btn_pos.height / sprite_get_height(spr_box_center),
               label: _btn_data.label
         });
      }
   }
}

