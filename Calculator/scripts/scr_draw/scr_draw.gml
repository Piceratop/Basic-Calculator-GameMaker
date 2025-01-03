/**
 * @function			draw_enclosed_text()
 * @descrition			This function will draw a text enclosed between two positions (with padding),
 *							the excessed character will be hidden and replaced by the navigation arrows.
 * @param {Real}		_left_pos - The leftmost position of the text
 * @param {Real}		_right_pos - The rightmost position of the text
 * @param {Real}		_y - The vertical position of the text
 * @param {Real}		_padding - The padding from the left and right possition
 * @param {String}	_str - The text to be drawn
 * @param {Real}		_cursor_pos - The position of the cursor relative to the start of the text (in character)
 * @param {Real}		_cursor_alpha - The alpha of the cursor
 * @return {Undefined} 
 */

function draw_enclosed_text(_left_pos, _right_pos, _y, _padding, _str, _cursor_pos, _cursor_alpha) {
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
	} else _cursor_pixel_position = _right_pos - (_padding + string_width(_after_cursor) + 2);
	
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