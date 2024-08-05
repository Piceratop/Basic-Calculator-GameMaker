draw_set_valign(fa_bottom);
draw_set_halign(fa_right);

var _display_equation = global.current_equation;
var _tco = string_length(_display_equation) - global.equation_max_length;
if (string_length(_display_equation) > global.equation_max_length) {
	
	if (global.display_text_start_pos <= 1) {
		global.display_text_start_pos = 1;
		_display_equation = string_copy(_display_equation, 1, global.equation_max_length - 1) + "▶";
	} else if (global.display_text_start_pos > _tco + 1) {
		global.display_text_start_pos = _tco + 2;
		_display_equation = "◀" + string_copy(
			_display_equation,
			global.display_text_start_pos,
			global.equation_max_length - 1
		);
	} else
		_display_equation = "◀" + string_copy(
			_display_equation,
			global.display_text_start_pos,
			global.equation_max_length - 2
		) + "▶";
} else {
	global.display_text_start_pos = 1;
}

draw_text(equations_pos[0], equations_pos[1], _display_equation);
