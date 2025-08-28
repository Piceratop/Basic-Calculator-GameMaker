depth = depth + 1;
image_speed = 0;
image_xscale = width / sprite_get_width(spr_box_top_left);
image_yscale = height / sprite_get_height(spr_box_top_left);

y_original = y;

show_debug_message(y_single_scroll);