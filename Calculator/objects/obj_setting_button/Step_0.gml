if (
	mouse_check_button(mb_left)
	and position_meeting(mouse_x, mouse_y, self)
	and is_allowed_mode(banned_mode)
) {
	room_clean_goto(rm_setting, "Menu");
}