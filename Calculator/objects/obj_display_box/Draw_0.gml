

// Draw the value
draw_enclosed_text(
	x, x + width, y + height / 2, 8, value,
	cursor_position, cursor_alpha, global.fnt_color, "left", "middle"
);

// Draw the label
draw_enclosed_text(
	x, x + width, y, -4, label,
	0, 0, global.fnt_color, "left"
);

draw_self();

//var _curr_color = draw_get_color();
//draw_set_color(c_aqua);
//draw_rectangle(x, y, x + 10, y + 10, false);
//draw_set_color(_curr_color);