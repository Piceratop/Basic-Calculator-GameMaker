/// @func   string_reverse(_str)
/// @desc   Returns a given string with the characters in reverse order.
/// @param  {string}    _str         string to be reversed
/// @return {string}    reversed string
 
function string_reverse(_str)
{
    var _out = "";
    for(var _i=string_length(_str); _i>0; _i--) {
        _out += string_char_at(_str, _i);
    }
    return _out;
}