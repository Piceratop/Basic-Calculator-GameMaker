if (is_dropping) {
	if (mouse_wheel_down()) {
		idpos_current_scroll = min(ds_list_size(options) - count_showing_options, idpos_current_scroll + 1);
	}
	if (mouse_wheel_up()) {
      idpos_current_scroll = max(0, idpos_current_scroll - 1);
	}
}