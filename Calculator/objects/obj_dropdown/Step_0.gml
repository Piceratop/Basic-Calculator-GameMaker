if (is_dropping) {
	if (mouse_wheel_down())
		current_scroll_pos = min(ds_list_size(options) - show_count, current_scroll_pos + 1);
	if (mouse_wheel_up())
        current_scroll_pos = max(0, current_scroll_pos - 1);
}