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
 * @param {String}	_align - The alignment of the text, default is right alignment
 * @return {Undefined} 
 */

function draw_enclosed_text(
	_left_pos, _right_pos, _y, _padding,
	_str, _cursor_pos, _cursor_alpha, _align="right"
) {
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
		switch(_align) {
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
}

/**
 * @function			create_numpad(_x, _y, _layout, _sprite)
 * @description		This function will create the layout of a numpad.
 * @param {Real}		_x - The orthorgonal position of the numpad's center
 * @param {Real}		_y - The vertical position of the numpad's center
 * @param {Array}		_layout - The array layout of the numpad
 * @param {Real}		_w - The width of the button
 * @param {Real}		_h - The height of the button
 * @param {Real}		_gap - The gap size between buttons
 */

function create_numpad(_x, _y, _layout, _w, _h = 40, _gap = 4) {
	var _full_button_width = _w + _gap;
	var _full_button_height = _h + _gap;
	var _no_col = array_length(_layout);
	var _no_row = array_length(_layout[0]);
	for (var _row = 0; _row < _no_row; _row++) {
	for (var _col = 0; _col < _no_col; _col++) {
		var _button = instance_create_layer(
			_x + ((1 - _no_row) / 2 + _row) * _full_button_width,
			_y + ((1 - _no_col) / 2 + _col) * _full_button_height,
			"Button",
			obj_button,
			{
				sprite_index: spr_box,
				image_xscale: _w / sprite_get_width(spr_box),
				image_yscale: _h / sprite_get_height(spr_box),
				pos_x: _row,
				pos_y: _col,
				label: _layout[_col][_row] 
			}
		);
	}
}
}