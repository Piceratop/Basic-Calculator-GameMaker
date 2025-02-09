
if (
	mouse_check_button_pressed(mb_left)
	and mouse_y <= y
	and mouse_y >= y - y_padding
) {
	is_dropping = not is_dropping;
}