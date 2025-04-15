margin = 32;
y_top_draw = 80;
options_practice_mode = ds_list_create();
dropdown_options_add(options_practice_mode, "Add", "+");
dropdown_options_add(options_practice_mode, "Add & Subtract", "+−");
dropdown_practice_mode = dropdown_create(
	room_width / 2, y_top_draw + 32,
	"Button", "practice mode", room_width - 64,
	40, options_practice_mode
);

rendered_mode_choice = false;