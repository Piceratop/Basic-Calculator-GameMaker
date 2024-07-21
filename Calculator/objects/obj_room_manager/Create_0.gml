size_x = display_get_width();
size_y = display_get_height();
if (room == rm_main) {
	switch(os_type) {
		case os_android:
			room_set_width(rm_calculator, 360);
			room_set_height(rm_calculator, 360 * size_y / size_x);
			surface_resize(application_surface, size_x, size_y);		
			break;
	}
	room_goto(rm_calculator);
}