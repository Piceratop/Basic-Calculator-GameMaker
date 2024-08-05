if (ord(label) < ord("▲"))
	global.current_equation = input_equation(global.current_equation, label);
else if (label == "▶") {
	global.display_text_start_pos += 1;
	if (global.display_text_start_pos == 2)
		global.display_text_start_pos += 1;
} else if (label == "◀") {
	global.display_text_start_pos -= 1;
	if (global.display_text_start_pos == 2)
		global.display_text_start_pos -= 1;
}