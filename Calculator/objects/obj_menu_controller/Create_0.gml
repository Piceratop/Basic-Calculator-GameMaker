// This code gets the label for possible rooms that the user can go to.

labels = variable_struct_get_names(global.modes);
for (var _i = 0; _i < array_length(labels); _i++) {
	if (global.modes[$ labels[_i]].mode_id < 0) {
		array_delete(labels, _i, 1);
		_i--;
	} 
}

// This codes sorts the labels' order to display them in a logical order.

function order_labels(_label1, _label2) {
	return global.modes[$ _label1].mode_id - global.modes[$ _label2].mode_id;
}

array_sort(labels, order_labels);
array_push(labels, "Setting");

display_height = 48;

glb_menu = global.modes.Menu;
if (is_undefined(glb_menu.flex_option)) {
	glb_menu.flex_option = flexpanel_create_node({
      width: "100%",
      padding: 32
   });
	
   for (var _i = 0; _i < array_length(labels); _i++) {
      flexpanel_node_insert_child(glb_menu.flex_option, flexpanel_create_node({
         width: "100%",
         height: display_height,
         marginBottom: 16
      }), _i);
   }
}

flexpanel_calculate_layout(glb_menu.flex_option, room_width, undefined, flexpanel_direction.LTR);

// This code creates the button to navigate to a specific room.

for (var _i = 0; _i < array_length(labels); _i++) {
	var _menu_option_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_menu.flex_option, _i));
	var _inst = instance_create_layer(
		_menu_option_pos.left, _menu_option_pos.top,
		"Instances", obj_navigation_button,
		{
			button_height: _menu_option_pos.height,
			button_width: _menu_option_pos.width,
			label: labels[_i],
			name: labels[_i],
		}
	);
}





