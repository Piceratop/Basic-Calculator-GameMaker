draw_set_valign(fa_bottom);
draw_set_halign(fa_right);

var _display_equation = "|";
if (global.cursor_position < 1)
	global.cursor_position = 1;
if (global.cursor_position <= string_length(global.current_equation)) {
	_display_equation += string_char_at(
		global.current_equation,
		global.cursor_position
	);
}
var _tpd = string_width("◀▶");
var _i;
for (
	_i = global.cursor_position - 1;
	_i > 0 and string_width(_display_equation) + _tpd < global.equation_max_width;
	_i--
) {
		_display_equation = string_insert(
			string_char_at(global.current_equation, _i),
			_display_equation, 1
		);
}
if (_i == 1)
	_display_equation = string_insert(
		string_char_at(global.current_equation, 1),
		_display_equation, 1
	);
else if (_i > 1) {
	if (global.cursor_position >= string_length(global.current_equation))
		_display_equation = string_insert(
			string_char_at(global.current_equation, _i),
			_display_equation, 1
		);
	_display_equation = string_insert("◀",_display_equation, 1);
}
var _td = string_width("▶");
for (
	_i = global.cursor_position + 1;
	_i <= string_length(global.current_equation) and
	string_width(_display_equation) + _td < global.equation_max_width;
	_i++
) {
	_display_equation += string_char_at(global.current_equation, _i);
}
if (_i == string_length(global.current_equation))
	_display_equation += string_char_at(global.current_equation, _i);
else if (_i < string_length(global.current_equation))
	_display_equation += "▶";
draw_text(equations_pos[0], equations_pos[1], _display_equation);
