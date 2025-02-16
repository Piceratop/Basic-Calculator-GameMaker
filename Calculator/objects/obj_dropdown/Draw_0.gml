draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

draw_enclosed_text(
	0, room_width, y - y_padding / 2, margin + 4,
	global.unit_name[? options[| current_option_id]], 0, 0, global.fnt_color, "left"
);

if (is_dropping) {
	for (var _i = 0; _i < min(3, ds_list_size(options)); _i++) {
		var _y_pad = y + 2 + y_padding * _i
		draw_set_color(global.back_color);
		draw_rectangle(margin, _y_pad, room_width - margin, _y_pad + y_padding, false);
		draw_sprite_ext(
			spr_box, 0, x, _y_pad + y_padding / 2, 
			(room_width - margin * 2) / sprite_get_width(spr_box),
			y_padding / sprite_get_height(spr_box), 0, global.border_color, 1
		);
		
		draw_enclosed_text(
			0, room_width, _y_pad + y_padding / 2, margin + 4,
			global.unit_name[? options[| _i]], 0, 0, global.fnt_color, "left"
		);
	}
}
