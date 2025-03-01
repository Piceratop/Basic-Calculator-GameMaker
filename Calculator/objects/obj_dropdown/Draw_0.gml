draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_set_color(global.fnt_color);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

draw_enclosed_text(
	0, room_width, y - y_padding / 2, margin + 4,
	global.unit_name[? options[| current_option_id]], 0, 0, global.fnt_color, "left"
);

if (is_dropping) {
	for (var _i = 0; _i < min(3, ds_list_size(options)); _i++) {
		var _y_pad = y + 2 + y_padding * _i;
		draw_set_color(global.back_color);
		draw_rectangle(margin, _y_pad, room_width - margin - scroll_btn_w - 2, _y_pad + y_padding, false);
		draw_sprite_ext(
			spr_box, 0, x - scroll_btn_w / 2, _y_pad + y_padding / 2, 
			(room_width - margin * 2 - scroll_btn_w) / sprite_get_width(spr_box),
			y_padding / sprite_get_height(spr_box), 0, global.border_color, 1
		);
		
		draw_enclosed_text(
			0, room_width - scroll_btn_w, _y_pad + y_padding / 2, margin + 4,
			global.unit_name[? options[| _i + current_scroll_pos]], 0, 0, global.fnt_color, "left"
		);
	}
}
