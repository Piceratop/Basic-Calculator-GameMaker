navigation_button_pos = [room_width / 2, 64]

function order_labels(_label1, _label2) {
	return global.modes[$ _label1].mode_id - global.modes[$ _label2].mode_id;
}

labels = variable_struct_get_names(global.modes);
for (var _i = 0; _i < array_length(labels); _i++) {
	if (global.modes[$ labels[_i]].mode_id == -1)
		array_delete(labels, _i, 1)
}

navigation_button_height = 48;
navigation_button_width = 288;
array_sort(labels, order_labels);
for (var _i = 0; _i < array_length(labels); _i++) {
	instance_create_layer(
		navigation_button_pos[0],
		navigation_button_pos[1] + _i * (navigation_button_height + 12),
		"Instances", obj_navigation_button,
		{
			button_height: navigation_button_height,
			button_width: navigation_button_width,
			label: labels[_i],
		}
	);
}





