display_height = 48;
y_top_draw = 80;
y_max_scroll = 48;
options_practice_mode = ds_list_create();
dropdown_options_add(options_practice_mode, "Add", "+");
dropdown_options_add(options_practice_mode, "Add & Subtract", "+−");
dropdown_practice_mode = dropdown_create(
	room_width / 2, y_top_draw + 32,
	"Button", "practice mode", room_width - 64,
	display_height, y_max_scroll, options_practice_mode, false, "", undefined, "Mode of practice:"
);

while (dropdown_get_value(dropdown_practice_mode) != global.modes.Practice.practice_mode) {
	dropdown_practice_mode.current_option_id += 1;
}

rendered_mode_choice = false;

#region This code initializes the corresponding option's name to its id.
var _t_map = global.modes.Practice.option_id_mapping;
switch(global.modes.Practice.practice_mode) {
	case "+":
	case "+−":
		ds_list_add(_t_map, "Question's length:");
		ds_list_add(_t_map, "Minimum:");
		ds_list_add(_t_map, "Maximum:");
		break;
}
for (var _i = 0; _i < ds_list_size(_t_map); _i++) {
	var _t_option_l = ds_list_create();
	ds_list_add(global.modes.Practice.options, _t_option_l);
	
}
#endregion

#region This code creates the inputs
for (var _i = 0; _i < ds_list_size(_t_map); _i++) {
	var _input_instance = display_create_with_label(
		room_width / 2, y_top_draw + 128 + (display_height + string_height("hj") + 8) * _i, "Button", 
		_t_map[| _i], room_width - 64, display_height, 48, "", _t_map[| _i]
	);
}
#endregion

#region This code creates the buttons
button_layout = [
	["⌫", "◀", "▶", "▼", "▲"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["=", "0", "."],
];

create_numpad(
	room_width / 2, room_height - 3 * global.numpad_button_full_height,
	button_layout, room_width - 64, global.numpad_button_height, global.numpad_gap,
	"Button", true
);
#endregion