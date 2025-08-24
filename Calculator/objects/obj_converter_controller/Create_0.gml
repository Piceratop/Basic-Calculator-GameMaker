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
dropdown_height = 48;

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

// This code creates a flex layout.
if (is_undefined(global.modes.Converter.flex_option)) {
   global.modes.Converter.flex_option = flexpanel_create_node({
      width: "100%",
      paddingLeft: 32,
      paddingRight: 32,
      paddingTop: 64,
   });
   flexpanel_node_insert_child(global.modes.Converter.flex_option, flexpanel_create_node({
      width: "100%",
      height: dropdown_height,
      marginBottom: box_height + 4
   }), 0);
   flexpanel_node_insert_child(global.modes.Converter.flex_option, flexpanel_create_node({
      width: "100%",
      height: dropdown_height,
      marginTop: 24,
      marginBottom: box_height + 4,   
   }), 1);
}

// This code displays the input and output according to the flex layout.

flexpanel_calculate_layout(global.modes.Converter.flex_option, room_width, room_height, flexpanel_direction.LTR);

var _dropdown_input_position = flexpanel_node_layout_get_position(flexpanel_node_get_child(global.modes.Converter.flex_option, 0));

input_unit_dropdown = dropdown_create(
	_dropdown_input_position.left, _dropdown_input_position.top,
   "Option", "input",
	_dropdown_input_position.width, _dropdown_input_position.height, 
	0, 0, // Scroll
	dropdown_options, true,
	parse_equation_from_single_list_to_string(global.modes.Converter.current_equation)
);
with (input_unit_dropdown) { 
	global.modes.Converter.input_unit = options[| current_option_id];
}


#region The code will display the output

var _dropdown_output = flexpanel_node_get_child(global.modes.Converter.flex_option, 1);
var _dropdown_output_position = flexpanel_node_layout_get_position(_dropdown_output);

output_unit_dropdown = dropdown_create(
	_dropdown_output_position.left, _dropdown_output_position.top,
   "Option", "output", 
	_dropdown_output_position.width, _dropdown_output_position.height,
   0, 0 /*Scroll*/, dropdown_options, true,
	parse_equation_from_single_list_to_string(global.modes.Converter.converted)
);
with (output_unit_dropdown) {
	global.modes.Converter.output_unit = options[| current_option_id];
}
#endregion
#endregion