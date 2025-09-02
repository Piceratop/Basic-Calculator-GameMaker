
#region This code creates a numpad to input answer.
button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["0"],
];

if (is_undefined(global.modes.Practice_Play.flex_numpad)) {
	global.modes.Practice_Play.flex_numpad = create_flex_numpad(button_layout);
}
create_numpad_from_flex(global.modes.Practice_Play.flex_numpad, room_width, room_height);
#endregion