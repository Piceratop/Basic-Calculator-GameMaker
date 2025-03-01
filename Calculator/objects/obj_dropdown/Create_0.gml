image_blend = global.border_color;
image_speed = 0;

current_option_id = 0;
current_scroll_pos = 0;
options = global.modes.Converter.dropdown_options;
show_count = 3;

y_padding = 48;
y = y + y_padding / 2;

// Create the scroll button
scroll_btn_w = sprite_get_width(spr_scroll_button);
instance_create_layer(
	room_width - margin - scroll_btn_w, y + 2,"Button", obj_scroll_button,
	{
		name: name,
	}
);