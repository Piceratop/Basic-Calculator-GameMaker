#region This code creates the numpad.
full_button_width = 60 + global.numpad_gap;
center_pos = [room_width / 2, room_height - global.numpad_button_full_height * 3];

button_layout = [
	["⌫", "(", ")", "÷", "▲"],
	["7", "8", "9", "×", "▼"],
	["4", "5", "6", "−", "▶"],
	["1", "2", "3", "+", "◀"],
	["0", ".", "-", "=", "Ans"]
];

if (is_undefined(global.modes.Standard.flex_numpad)) {
   global.modes.Standard.flex_numpad = create_flex_numpad(button_layout);
}
create_numpad_from_flex(global.modes.Standard.flex_numpad, room_width, room_height);

#endregion

// Text Display

display_padding = (room_width - 5 * full_button_width) / 2;
equations_pos = [room_width - full_button_width, center_pos[1] - 3.5 * global.numpad_button_full_height];
alarm[0] = game_get_speed(gamespeed_fps);

// Util function

function get_before_cursor_char_count(_eq_list, _pos) {
	var _str_pos = 0;
	for (var _i = 0; _i < _pos; _i++)
		_str_pos += string_length(global.math_decodings[? _eq_list[| _i]]);
	return _str_pos;
}