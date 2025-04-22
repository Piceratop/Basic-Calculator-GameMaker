margin = 32;
y_top_draw = 80;
options_practice_mode = ds_list_create();
dropdown_options_add(options_practice_mode, "Add", "+");
dropdown_options_add(options_practice_mode, "Add & Subtract", "+−");
dropdown_practice_mode = dropdown_create(
	room_width / 2, y_top_draw + 32,
	"Button", "practice mode", room_width - 64,
	40, options_practice_mode
);

while (dropdown_get_value(dropdown_practice_mode) != global.modes.Practice.practice_mode) {
	dropdown_practice_mode.current_option_id += 1;
}

rendered_mode_choice = false;

#region This code initializes the corresponding option's name to its id.
var _t_map = global.modes.Practice.option_id_mapping;
switch(global.modes.Practice.practice_mode) {
	case "+":
	case "+-":
		ds_list_add(_t_map, "Question length:");
		ds_list_add(_t_map, "Minimum: ");
		ds_list_add(_t_map, "Maximum: ");
		break;
}
#endregion

#region This code creates the inputs
for (var _i = 0; _i < ds_list_size(_t_map); _i++) {
	var _input_instance;
}
#endregion

#region This code creates a numpad

#endregion