draw_self();
var _curr_color = draw_get_colour();
draw_set_colour(global.back_color);
draw_rectangle(0, y + sprite_get_height(spr_border) / 2, room_width, room_height, false);
draw_set_colour(_curr_color);