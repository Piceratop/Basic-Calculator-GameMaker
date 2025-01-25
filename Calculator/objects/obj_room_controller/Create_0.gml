// Initialize the global compunents

size_x = display_get_width();
size_y = display_get_height();
if (room == rm_main) {
	switch(os_type) {
		case os_android:
			application_surface_enable(false);
			room_set_height(rm_calculator, 360 * size_y / size_x);
			break;
		default:
			break;
	}
}
room_goto(rm_menu);