draw_self();

var _curr_halign = draw_get_halign();
var _curr_color = draw_get_color();
draw_set_halign(fa_right);
draw_set_color(global.fnt_color);

if (ds_list_size(options) > 0) {
	draw_text(x + dropdown_width - 4, y + dropdown_height / 2, is_dropping ? "▼" : "◀");
	draw_enclosed_text(
		x, x + dropdown_width, y + dropdown_height / 2, 0,
		options[| current_option_id][? "label"], 0, 0, global.fnt_color, "left", "middle"
	);	
}

// Draw the label
draw_enclosed_text(
	x, x + dropdown_width,
	y - label_margin, -4, label,
	0, 0, global.fnt_color, "left", "middle"
);

if (is_dropping) {
	// Draw the dropdown contents
	for (var _i = 0; _i < count_showing_options; _i++) {
		var _y_pad = y + dropdown_height + dropdown_height * _i;
		draw_set_color(global.back_color);
		draw_rectangle(x, _y_pad, x + dropdown_width - 1, _y_pad + dropdown_height - 1, false);
		draw_sprite_ext(
			spr_box_top_left, 0, x, _y_pad, 
			(dropdown_width - scroll_btn_w) / sprite_get_width(spr_box_top_left),
			dropdown_height / sprite_get_height(spr_box_top_left), 0, global.border_color, 1
		);
		
		draw_enclosed_text(
			0, room_width - scroll_btn_w, _y_pad + dropdown_height / 2, x + 4,
			options[| _i + idpos_current_scroll][? "label"], 0, 0, global.fnt_color, "left", "middle"
		);
	}
	
	// Initialize constants for the scroll bar.
	var _w_ssb = sprite_get_width(spr_scroll_button);
	var _h_ssb = sprite_get_height(spr_scroll_button);
	var _ypos_scroll_bar = y + dropdown_height + _h_ssb;
	var _h_scroll_bar = count_showing_options * dropdown_height - 2 * _h_ssb + 4;
	
	
	/* This code will check whether there is only 1 option. In that case, it will black out the scroll bar.
	 * Else, it will draw the scroll bar like normal
	 */ 
	if (ds_list_size(options) == 1) {
      draw_set_color(global.border_color);
		draw_rectangle(
			scroll_btn_x, y + dropdown_height,
			scroll_btn_x + _w_ssb - 1, y + dropdown_height * 2 - 1,
			false
		);
	} else {
		// Draw the scroll bar's position indicator.
		var _count_scroll_division = ds_list_size(options) - count_showing_options + 1;
      draw_set_color(global.border_color);
		draw_rectangle(
			scroll_btn_x,
			_ypos_scroll_bar + _h_scroll_bar / _count_scroll_division * idpos_current_scroll,
			scroll_btn_x + _w_ssb - 1,
			_ypos_scroll_bar + _h_scroll_bar / _count_scroll_division * (idpos_current_scroll + 1),
			false
		);
	}
	
	// Draw the scroll bar's bounding box over the position indicator.
	draw_sprite_ext(
		spr_box_top_left, 0, scroll_btn_x,
		_ypos_scroll_bar, _w_ssb / sprite_get_width(spr_box_top_left),
		_h_scroll_bar / sprite_get_height(spr_box_top_left),
		0, global.border_color, 1
	);
}
