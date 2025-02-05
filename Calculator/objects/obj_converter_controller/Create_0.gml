// Button creation

full_button_height = 44;

button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["Ans", "0", "."],
];
alarm[0] = game_get_speed(gamespeed_fps);

create_numpad(room_width / 2, room_height - 3 * full_button_height, button_layout, 100, 40, 4);