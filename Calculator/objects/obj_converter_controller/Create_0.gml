// Button creation

full_button_height = sprite_get_height(spr_button_lengthen) + 4;

button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "2"],
	["Ans", "0", "."],
];

create_numpad(room_width / 2, room_height - 3 * full_button_height, button_layout, spr_button_lengthen);