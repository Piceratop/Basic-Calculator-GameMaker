/**
 * @function					draw_background_rectangle_over
 * @description				This function draws a rectangle that is the size of the given object with the background color.
 * @param {Asset.GMObject}	_object - The object to get parameters
 * @return {Undefined}
 */

function draw_background_rectangle_over(_object) {
	var _curr_color = draw_get_color();
	draw_set_color(global.back_color);
	with (_object) {
		draw_rectangle(
			x - sprite_width / 2, y - sprite_height / 2,
			x + sprite_width / 2 - 1, y + sprite_height / 2 - 1, false
		);
	}
	draw_set_color(_curr_color);
}

/**
 * @function			draw_enclosed_text()
 * @description		This function will draw a text enclosed between two positions (with padding),
 *							the excess character will be hidden and replaced by the navigation arrows.
 * @param {Real}		_left_pos - The leftmost position of the text
 * @param {Real}		_right_pos - The rightmost position of the text
 * @param {Real}		_y - The vertical position of the text
 * @param {Real}		_padding - The padding from the left and right position
 * @param {String}	_str - The text to be drawn
 * @param {Real}		_cursor_pos - The position of the cursor relative to the start of the text (in character)
 * @param {Real}		_cursor_alpha - The alpha of the cursor
 * @param {Real}		_color - The color of the text
 * @param {String}	_halign - The horizontal alignment of the text, default is right alignment
 * @param {String}	_valign - The vertical alignment of the text, default is bottom alignment
 * @return {Undefined} 
 */

function draw_enclosed_text(
	_left_pos, _right_pos, _y, _padding,
	_str, _cursor_pos, _cursor_alpha, _color, _halign="right", _valign="bottom"
) {
	var _curr_fnt_color = draw_get_color();
   var _curr_valign = draw_get_valign();
   draw_set_valign(_valign == "bottom" ? fa_bottom : (_valign ==  "top" ? fa_top : fa_middle));
	draw_set_color(_color);
	/**
	 * Set the cursor position. Its default position is the center.
	 * Align left if the left part of the string is too short. Align right similarly.
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
	
   var _y_down_shift = (_valign == "bottom" ? 0 : global.text_height / 2);
   
   /**
	 * Draw the cursor.
	 */
 	draw_set_alpha(_cursor_alpha);
   draw_rectangle(_cursor_pixel_position - 1, _y + _y_down_shift - 4, _cursor_pixel_position, _y + _y_down_shift - 28, false);
	draw_set_alpha(1);
	
   // Cover the right part
	draw_set_halign(fa_left);
	draw_text(_cursor_pixel_position + 2, _y, _after_cursor);
	draw_set_halign(fa_right);
	if (_cursor_pixel_position + string_width(_after_cursor) >= _right_pos - _padding) {
		draw_rectangle_color(
			_right_pos - _padding - string_width("▶") - 2, _y + _y_down_shift,
			room_width,	_y + _y_down_shift - string_height("▶"),
			global.back_color, global.back_color, global.back_color, global.back_color, false
		);
		draw_text(_right_pos - _padding, _y, "▶");
	}
	draw_text(_cursor_pixel_position + 2, _y, _before_cursor);
	draw_set_halign(fa_left);
	if (_cursor_pixel_position - string_width(_before_cursor) <= _left_pos + _padding) {
		draw_rectangle_color(
			_left_pos + _padding + string_width("◀"), _y + _y_down_shift,
			-2, _y + _y_down_shift - string_height("◀"),
			global.back_color, global.back_color, global.back_color, global.back_color, false
		);
		draw_text(_left_pos + _padding, _y, "◀");
	}
	
	// Reset the settings for drawing 
	draw_set_color(_curr_fnt_color);
   draw_set_valign(_curr_valign);
}

/**
 * @function						display_create_with_label
 * @description					This function will create a display using the predefined arguments.
 * @param {Real}					_x - The x position of the center of the display
 * @param {Real}					_y - The y position of the center of the display
 * @param {String | Id.Layer} _layer - The layer where the dropdown is created
 * @param {String}				_name - The name of the dropdown (used for getting the dropdown's value)
 * @param {Real}					_width - The width of the dropdown
 * @param {Real}					_height - The height of the dropdown
 * @param {Real}					_scroll - The maximum scroll height
 * @param {String}				_text - The text to be displayed
 * @param {String}				_label - The label of the display
 * @param {Real}					_margin - The gap between the label and the display
 * @return {Asset.GMObject}
 */

function display_create_with_label(_x, _y, _layer, _name, _width, _height, _scroll, _text, _label="", _margin=4) {
	var _display = instance_create_layer(_x, _y, _layer, obj_display_box, {
		width: _width,
		height: _height,
		name: _name,
		value: _text,
		label: _label,
		margin: _margin,
		y_max_scroll: _scroll
	});
	return _display;
}