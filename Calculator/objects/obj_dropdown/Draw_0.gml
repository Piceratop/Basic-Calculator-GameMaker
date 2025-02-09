//var _color = draw_get_color();
//draw_set_color(c_red);
//draw_rectangle(0, y - y_padding, room_width, y, false);
//draw_set_color(_color);

draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

