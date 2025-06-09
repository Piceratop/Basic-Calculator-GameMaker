/**
 * @function			create_numpad
 * @description		This function will create the layout of a numpad.
 * @param {Real}		_x - The orthorgonal position of the numpad's center
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
					depth: -1,
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
 * @function           create_numpad_flex
 * @description        This function will generate the numpad following a flex layout.
 * @param {Real}       _rm_width - The width of the room
 * @param {Real}       _rm_height - The height of the room
 * @param {Array}      _button_layout - The layout of the button
 * @param {Real}       _padding - The padding from the edge of the room
 * @return {Pointer.FlexpanelNode}
 */

function create_numpad_flex(_rm_width, _rm_height, _button_layout, _padding=16) {
   // This code creates the layout.
   var _gap = 4;
   var _flx_numpad_with_border = flexpanel_create_node({ width: "100%", justifyContent: "flex-end" });
   var _flx_border = flexpanel_create_node({ width: "100%", height: sprite_get_height(spr_border) })
	var _flx_numpad = flexpanel_create_node({ justifyContent: "flex-end", gap: _gap, padding: _padding, width: "100%" });
   for (var _i = 0; _i < array_length(_button_layout); _i++) {
      var _row = flexpanel_create_node({
         flexDirection: "row", width: "100%", gap: _gap
      });
      
      for (_j = 0; _j < array_length(_button_layout[_i]); _j++) {
         var _btn = flexpanel_create_node({ height: 40, flexGrow: 1 });
         flexpanel_node_insert_child(_row, _btn, _j);
      }
   
      flexpanel_node_insert_child(_flx_numpad, _row, _i);
   }
   flexpanel_node_insert_child(_flx_numpad_with_border, _flx_border, 0);
   flexpanel_node_insert_child(_flx_numpad_with_border, _flx_numpad, 1);
   
   // This code creates the numpad according to the layout.
   flexpanel_calculate_layout(_flx_numpad_with_border, _rm_width, _rm_height, flexpanel_direction.LTR);
   
   var _border = flexpanel_node_get_child(_flx_numpad_with_border, 0);
   var _pos_border = flexpanel_node_layout_get_position(_border, false);
   instance_create_layer(
      _pos_border.left, _pos_border.top, "Button", obj_display_border, {
         image_xscale: _pos_border.width / sprite_get_width(spr_border),
      }
   )
   
   _fix_numpad = flexpanel_node_get_child(_flx_numpad_with_border, 1);
   for (var _i = 0; _i < flexpanel_node_get_num_children(_flx_numpad); _i++) {
      var _row = flexpanel_node_get_child(_flx_numpad, _i);
      for (var _j = 0; _j < flexpanel_node_get_num_children(_row); _j++) {
         var _btn_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(_row, _j), false);
         var _inst = instance_create_layer(
            _btn_pos.left, _btn_pos.top, "Button", obj_button, {
               depth: -1, 
               image_xscale: _btn_pos.width / sprite_get_width(spr_box_center),
               image_yscale: _btn_pos.height / sprite_get_height(spr_box_center),
               label: _button_layout[_i][_j]
         });
      }
   }
   
   return _flx_numpad;
}

/**
 * @function			draw_enclosed_text()
 * @description		This function will draw a text enclosed between two positions (with padding),
 *							the excessed character will be hidden and replaced by the navigation arrows.
 * @param {Real}		_left_pos - The leftmost position of the text
 * @param {Real}		_right_pos - The rightmost position of the text
 * @param {Real}		_y - The vertical position of the text
 * @param {Real}		_padding - The padding from the left and right possition
 * @param {String}	_str - The text to be drawn
 * @param {Real}		_cursor_pos - The position of the cursor relative to the start of the text (in character)
 * @param {Real}		_cursor_alpha - The alpha of the cursor
 * @param {Real}		_color - The color of the text
 * @param {String}	_halign - The alignment of the text, default is right alignment
 * @return {Undefined} 
 */

function draw_enclosed_text(
	_left_pos, _right_pos, _y, _padding,
	_str, _cursor_pos, _cursor_alpha, _color, _halign="right"
) {
	var _curr_fnt_color = draw_get_color();
	draw_set_color(_color);
	/**
	 * Set the cursor position. Its default position is the center.
	 * Align left if the left part of the string is too short. Align right similiarly.
	 */
	var _cursor_pixel_position = (_left_pos + _right_pos) / 2;
	var _after_cursor = string_copy(_str, _cursor_pos + 1, string_length(_str) - _cursor_pos + 2);
	var _before_cursor = string_copy(_str, 1, _cursor_pos);
	if (string_width(_str) >= _right_pos - _left_pos - 2 * _padding) {
		if (string_width(_before_cursor) + 2 < (_right_pos - _left_pos) / 2 - _padding)
			_cursor_pixel_position = _left_pos + _padding + string_width(_before_cursor) + 2;
		if (string_width(_after_cursor) + 2 < (_right_pos - _left_pos) / 2 - _padding)
			_cursor_pixel_position = _right_pos - (_padding + string_width(_after_cursor) + 2);
	} else {
		switch(_halign) {
			case "left":
				_cursor_pixel_position = _left_pos + _padding + string_width(_before_cursor) + 2;
				break;
			default:
				_cursor_pixel_position = _right_pos - (_padding + string_width(_after_cursor) + 2);
		}
	}
	
	/**
	 * Draw the cursor.
	 */
	draw_set_alpha(_cursor_alpha);
	draw_rectangle(_cursor_pixel_position - 1, _y - 4,	_cursor_pixel_position, _y - 28, false);
	draw_set_alpha(1);
	
	draw_set_halign(fa_left);
	draw_text(_cursor_pixel_position + 2, _y, _after_cursor);
	draw_set_halign(fa_right);
	if (_cursor_pixel_position + string_width(_after_cursor) >= _right_pos - _padding) {
		draw_rectangle_color(
			_right_pos - _padding - string_width("▶") - 2, _y,
			room_width,	_y - string_height("▶"),
			global.back_color, global.back_color, global.back_color, global.back_color, false
		);
		draw_text(_right_pos - _padding, _y, "▶");
	}
	draw_text(_cursor_pixel_position + 2, _y, _before_cursor);
	draw_set_halign(fa_left);
	if (_cursor_pixel_position - string_width(_before_cursor) <= _left_pos + _padding) {
		draw_rectangle_color(
			_left_pos + _padding + string_width("◀"), _y,
			-2, _y - string_height("◀"),
			global.back_color, global.back_color, global.back_color, global.back_color, false
		);
		draw_text(_left_pos + _padding, _y, "◀");
	}
	
	// Reset the settings for drawing 
	draw_set_color(_curr_fnt_color);
}