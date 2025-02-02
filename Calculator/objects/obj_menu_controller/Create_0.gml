navigation_button_pos = [room_width / 2, room_height / 4]
labels = ["Calculator", "Converter"];

for (var _i = 0; _i < array_length(labels); _i++) {
	instance_create_layer(
		navigation_button_pos[0],
		navigation_button_pos[1] + _i * (sprite_get_height(spr_navigation_button) + 12),
		"Instances", obj_navigation_button,
		{
			label: labels[_i]
		}
	);	
}



