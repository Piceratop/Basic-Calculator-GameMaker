display_height = 48;
text_height = string_height("Mp");
y_top_draw = 80;
y_max_scroll = 48;
alarm[0] = game_get_speed(gamespeed_fps);
is_playing = false;

// This code creates a flex layout for the practice options.

glb_practice = global.modes.Practice;
if (is_undefined(glb_practice.flex_option)) {
   glb_practice.flex_option = flexpanel_create_node({
      width: "100%",
      paddingLeft: 32,
      paddingRight: 32,
      paddingTop: 48,
   });
   for (var _i = 0; _i < 4; _i++) {
      flexpanel_node_insert_child(glb_practice.flex_option, flexpanel_create_node({
         width: "100%",
         height: display_height,
         marginTop: text_height
      }), _i);
   }
}

flexpanel_calculate_layout(glb_practice.flex_option, room_width, undefined, flexpanel_direction.LTR);

// This code creates the dropdown from the question type selection

options_practice_mode = ds_list_create();
dropdown_options_add(options_practice_mode, "Add", "+");
dropdown_options_add(options_practice_mode, "Add & Subtract", "+−");

var _question_type_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, 0), false);

dropdown_practice_mode = dropdown_create(
	_question_type_pos.left, _question_type_pos.top,
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
	var _l = ds_list_create();
	var _data = ds_list_create();
	ds_list_add(_l, _data);
	ds_list_mark_as_list(_l, 0);
	ds_list_add(_l, 0);
	ds_map_add_list(global.modes.Practice.values_of_options, _t_map[| _i], _l);
}
#endregion

#region This code creates the inputs
for (var _i = 0; _i < ds_list_size(_t_map); _i++) {
   var _question_set_metadata_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, _i + 1), false);
   
	var _input_instance = display_create_with_label(
		_question_set_metadata_pos.left, _question_set_metadata_pos.top, "Display", 
		_t_map[| _i], room_width - 64, display_height, 64, 
		parse_equation_from_single_list_to_string(glb_practice.values_of_options[? glb_practice.option_id_mapping[|_i]][| 0]),
		_t_map[| _i]
	);
}
#endregion

#region This code creates the buttons
button_layout = [
	["⌫", "◀", "▶", "▼", "▲"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["Enter", "0", "."],
];

if (is_undefined(global.modes.Practice.flex_numpad)) {
	global.modes.Practice.flex_numpad = create_flex_numpad(button_layout);
}
create_numpad_from_flex(global.modes.Practice.flex_numpad, room_width, room_height);
#endregion