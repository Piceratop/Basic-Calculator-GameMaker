image_blend = global.border_color;
image_speed = 0;

current_option_id = 0;
idpos_current_scroll = 0;
count_max_showing_options = 3;
count_showing_options = min(count_max_showing_options, ds_list_size(options));

y_padding = 48;
y = y + y_padding / 2;

// Create the scroll button
scroll_btn_w = sprite_get_width(spr_scroll_button);
instance_create_layer(
	room_width - margin - scroll_btn_w, y + 2,
	"Button", obj_scroll_button,
	{
		depth: -1,
		image_index: 0,
		name: name,
		type: "up",
	}
);

instance_create_layer(
	room_width - margin - scroll_btn_w,
	y + 2 + count_showing_options * dropdown_height - sprite_get_height(spr_scroll_button),
	"Button",
	obj_scroll_button,
	{
		depth: -1,
		image_index: 1,
		name: name,
		type: "down",
	}
)