// Initialize the global compunents


global.allow_characters = "()+-.0123456789=CEaclortu|×÷⁁−⌫▲▶▼◀"
global.fnt_calculator = font_add_sprite_ext(
	spr_fnt_calculator,
	global.allow_characters,
	true, 4
);
global.back_color = c_white;
global.border_color = c_black;
global.fnt_color = c_black;

draw_set_color(global.fnt_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.fnt_calculator);

size_x = display_get_width();
size_y = display_get_height();
if (room == rm_main) {
	switch(os_type) {
		case os_android:
			application_surface_enable(false);
			room_set_height(rm_calculator, 360 * size_y / size_x);
			break;
		default:
			if (size_y > 960) {
				window_set_size(540, 960);
				window_center();
			}
	}
}
room_goto(rm_menu);