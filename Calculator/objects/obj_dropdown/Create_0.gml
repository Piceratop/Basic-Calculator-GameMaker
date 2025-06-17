image_blend = global.border_color;
image_speed = 0;
image_xscale = dropdown_width / sprite_get_width(spr_border);

base_depth = depth;
current_option_id = 0;
idpos_current_scroll = 0;
count_max_showing_options = 3;
count_showing_options = min(count_max_showing_options, ds_list_size(options));


y_padding = dropdown_height;
y_original = y;

// Create the scroll button

scroll_btn_w = sprite_get_width(spr_scroll_button);
scroll_btn_x = x + dropdown_width - scroll_btn_w;
instance_create_layer(
	scroll_btn_x, y + 2,
	"Button", obj_scroll_button,
	{
		depth: base_depth - 2,
		image_index: 0,
		name: name,
		type: "up",
	}
);

instance_create_layer(
	scroll_btn_x,
	y + 2 + count_showing_options * dropdown_height - sprite_get_height(spr_scroll_button),
	"Button",
	obj_scroll_button,
	{
		depth: base_depth - 2,
		image_index: 1,
		name: name,
		type: "down",
	}
)

