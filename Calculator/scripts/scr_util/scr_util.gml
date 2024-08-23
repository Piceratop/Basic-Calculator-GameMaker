/// @func   string_reverse(_str)
/// @desc   Returns a given string with the characters in reverse order.
/// @param  {string}    _str         string to be reversed
/// @return {string}    reversed string
 
function string_reverse(_str) {
    var _out = "";
    for(var _i=string_length(_str); _i>0; _i--) {
        _out += string_char_at(_str, _i);
    }
    return _out;
}

function check_function(_func, _input, _repeat=10000) {
	var _time = get_timer();
	var _ans;
	for (var _i = 0; _i < _repeat; _i++)
		_ans = _func(_input);
	_time = get_timer() - _time;
	show_debug_message($"{script_get_name(_func)}({_input}) = {_ans} .");
	show_debug_message($"Repeated {_repeat} times {_time} in microseconds.");
}

function check_function_multi_cases(_func, _test_cases, _repeat=10000) {
	for (var _i = 0; _i < array_length(_test_cases); _i++)
		check_function(_func, _test_cases[_i], _repeat);
	show_debug_message("\n");
}