// This code initializes the variables needed to layout settings
height_dropdown = 48;
width_dropdown = room_width - 64;
y_gap = 48;

had_layout = false;

// This code creates a flex layout for setting

if (is_undefined(global.modes.Setting.flex_option)){
   global.modes.Setting.flex_option = flexpanel_create_node({ 
      width: "100%",
      padding: 32
   });
   flexpanel_node_insert_child(global.modes.Setting.flex_option, flexpanel_create_node({
      width: "100%",
      height: height_dropdown
   }), 0);
}
flexpanel_calculate_layout(global.modes.Setting.flex_option, room_width, room_height, flexpanel_direction.LTR);

// This code creates a dropdown menu to store the current mode's setting to be changed.
options_setting_dropdown = ds_list_create();
dropdown_options_add(options_setting_dropdown, "Converter");

var _dropdown_room_option = flexpanel_node_get_child(global.modes.Setting.flex_option, 0);
var _dropdown_room_option_position = flexpanel_node_layout_get_position(_dropdown_room_option); 

setting_dropdown = dropdown_create(
	_dropdown_room_option_position.left, _dropdown_room_option_position.top,
   "Option", "Mode Selection",
	_dropdown_room_option_position.width, _dropdown_room_option_position.height, 0, 
	options_setting_dropdown
)
y_top_label = setting_dropdown.y + 32;