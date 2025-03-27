draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_set_color(global.fnt_color);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

draw_enclosed_text(
	0, room_width, y - y_padding / 2, margin + 4,
	options[| current_option_id][? "label"], 0, 0, global.fnt_color, "left"
);

if (is_dropping) {
	// Draw the dropdown contents
	for (var _i = 0; _i < count_showing_options; _i++) {
		var _y_pad = y + 2 + y_padding * _i;
		draw_set_color(global.back_color);
		draw_rectangle(margin, _y_pad, room_width - margin, _y_pad + y_padding, false);
		draw_sprite_ext(
			spr_box_center, 0, x - scroll_btn_w / 2, _y_pad + y_padding / 2, 
			(room_width - margin * 2 - scroll_btn_w) / sprite_get_width(spr_box_center),
			y_padding / sprite_get_height(spr_box_center), 0, global.border_color, 1
		);
		
		draw_enclosed_text(
			0, room_width - scroll_btn_w, _y_pad + y_padding / 2, margin + 4,
			options[| _i + idpos_current_scroll][? "label"], 0, 0, global.fnt_color, "left"
		);
	}
	
	// Initialize constants for the scroll bar.
	var _w_ssb = sprite_get_width(spr_scroll_button);
	var _h_ssb = sprite_get_height(spr_scroll_button);
	var _xpos_scroll_bar = room_width - margin - _w_ssb;
	var _ypos_scroll_bar = y + _h_ssb;
	var _h_scroll_bar = count_showing_options * y_padding - 2 * _h_ssb + 4;
	
	// Draw the scroll bar's position indicator.
	var _count_scroll_division = ds_list_size(options) - count_showing_options + 1;
	draw_set_color(global.fnt_color);
	draw_rectangle(
		_xpos_scroll_bar + 2,
		_ypos_scroll_bar + _h_scroll_bar / _count_scroll_division * idpos_current_scroll,
		_xpos_scroll_bar + _w_ssb - 1,
		_ypos_scroll_bar + _h_scroll_bar / _count_scroll_division * (idpos_current_scroll + 1),
		false
	);
	
	// Draw the scroll bar's bounding box over the position indicator.
	draw_sprite_ext(
		spr_box_top_left, 0, _xpos_scroll_bar,
		_ypos_scroll_bar, _w_ssb / sprite_get_width(spr_box_top_left),
		_h_scroll_bar / sprite_get_height(spr_box_top_left),
		0, global.border_color, 1
	);
	
}
