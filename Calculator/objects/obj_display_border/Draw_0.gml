draw_self();
var _curr_color = draw_get_colour();
draw_set_colour(global.back_color);
draw_rectangle(0, y + image_yscale * sprite_get_height(spr_border), room_width, room_height, false);
draw_set_colour(_curr_color);