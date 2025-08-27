display_height = 48;
text_height = string_height("Mp") + 4;
y_top_draw = 80;
y_single_scroll = 32;
y_max_scroll = y_single_scroll * 6;
alarm[0] = game_get_speed(gamespeed_fps);
is_playing = false;

// This code creates a flex layout for the practice options.

glb_practice = global.modes.Practice;

options_practice_mode = ds_list_create();
dropdown_options_add(options_practice_mode, "Add", "+");
dropdown_options_add(options_practice_mode, "Add & Subtract", "+−");

if (is_undefined(glb_practice.flex_option)) {
   glb_practice.flex_option = flexpanel_create_node({
      width: "100%",
      paddingLeft: 32,
      paddingRight: 32,
      paddingTop: 48,
   });
	var _no_boxes = ds_list_size(glb_practice.option_id_mapping) + 2;
   for (var _i = 0; _i < _no_boxes; _i++) {
      flexpanel_node_insert_child(glb_practice.flex_option, flexpanel_create_node({
         width: "100%",
         height: display_height,
         marginTop: text_height
      }), _i);
   }
}

flexpanel_calculate_layout(glb_practice.flex_option, room_width, undefined, flexpanel_direction.LTR);



var _question_type_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, 0), false);

dropdown_practice_mode = dropdown_create(
	_question_type_pos.left, _question_type_pos.top,
	"Button", "practice mode", room_width - 64,
	display_height, y_max_scroll, y_single_scroll,
	options_practice_mode, false, "", undefined, "Mode of practice:"
);

while (dropdown_get_value(dropdown_practice_mode) != glb_practice.practice_mode) {
	dropdown_practice_mode.current_option_id += 1;
}

rendered_mode_choice = false;



// This code creates the inputs
for (var _i = 0; _i < ds_list_size(_t_map); _i++) {
   var _question_set_metadata_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, _i + 1), false);
   
	var _input_instance = display_create_with_label(
		_question_set_metadata_pos.left, _question_set_metadata_pos.top, "Display", 
		_t_map[| _i], room_width - 64, display_height, y_max_scroll, y_single_scroll,
		parse_equation_from_single_list_to_string(glb_practice.values_of_options[? glb_practice.option_id_mapping[|_i]][| 0]),
		_t_map[| _i]
	);
}

// Button to navigate to the play room
var _navigation_to_play_btn_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, ds_list_size(_t_map) + 1), false);
var _navigation_to_play_btn_label = "Play";

instance_create_layer(_navigation_to_play_btn_pos.left, _navigation_to_play_btn_pos.top, "Display", obj_navigation_button, {
	button_height: _navigation_to_play_btn_pos.height,
	button_width: _navigation_to_play_btn_pos.width,
	label: _navigation_to_play_btn_label,
	name: "Practice_Play",
	y_max_scroll: y_max_scroll,
	y_single_scroll: y_single_scroll
})

#region This code creates the buttons for inputing equations
button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["0", "▼", "▲"],
];

if (is_undefined(global.modes.Practice.flex_numpad)) {
	global.modes.Practice.flex_numpad = create_flex_numpad(button_layout);
}
create_numpad_from_flex(global.modes.Practice.flex_numpad, room_width, room_height);
#endregion
