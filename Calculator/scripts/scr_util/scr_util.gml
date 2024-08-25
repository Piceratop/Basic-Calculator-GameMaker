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

/// @func   print_ds_list(_str)
/// @desc   Print a ds_list to the console
/// @param  {Id.DsList}	_list - The ds_list to be printed
/// @return {undefined}

function print_ds_list(_list) {
	var _ans = "[ "
	for (var _i = 0; _i < ds_list_size(_list); _i++)
		_ans += string(_list[| _i]) + ", ";
	_ans += "]";
	show_debug_message(_ans);
}