alarm[0] = game_get_speed(gamespeed_fps);

#region This code creates the buttons
button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["=", "0", "."],
];

if (is_undefined(global.modes.Converter.flex_numpad)) {
	global.modes.Converter.flex_numpad = create_flex_numpad(button_layout);
}
create_numpad_from_flex(global.modes.Converter.flex_numpad, room_width, room_height);
#endregion

#region This code creates dropdowns and IO Displays

var _display_top_position = room_width / 4;
var _box_width = 288;
box_height = 48;

var _sb_width = sprite_get_width(spr_scroll_button) / 2;
var _margin = (room_width - _box_width) / 2;

/* This code adds the right type of units to both dropdowns.
 *	It adds a unit's fullname and this unit's shorthand as a label and its value respectively.
 */
var _co = global.modes.Converter.conversion_rate[? global.modes.Converter.convert_mode];
dropdown_options = ds_list_create();
for (
	var _k = ds_map_find_first(_co);
	not is_undefined(_k);
	_k = ds_map_find_next(_co, _k)
) {
	dropdown_options_add(dropdown_options, global.unit_name[? _k], _k);
}

#region The code will display the input
input_unit_dropdown = dropdown_create(
	room_width / 2, _display_top_position, "Button", "input",
	_box_width, box_height, false, dropdown_options, true,
	parse_equation_from_single_list_to_string(global.modes.Converter.current_equation)
);
with (input_unit_dropdown) { 
	global.modes.Converter.input_unit = options[| current_option_id];
}
#endregion

#region The code will display the output
output_unit_dropdown = dropdown_create(
	room_width / 2, _display_top_position + 3 * box_height, "Button", "output", 
	_box_width, box_height, false, dropdown_options, true,
	parse_equation_from_single_list_to_string(global.modes.Converter.converted)
);
with (output_unit_dropdown) {
	global.modes.Converter.output_unit = options[| current_option_id];
}
#endregion
#endregion