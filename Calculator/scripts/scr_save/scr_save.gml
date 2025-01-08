/// @function				file_read_all_text(_filename)
/// @description			Reads entire content of a given file as a string, or 
///							returns undefined if the file doesn't exist.
/// @param {string}		_filename - The path of the file to read the content of.
function file_read_all_text(_filename) {
   if (!file_exists(_filename)) {
      return undefined;
   }
    
   var _buffer = buffer_load(_filename);
   var _result = buffer_read(_buffer, buffer_string);
   buffer_delete(_buffer);
   return _result;
}

/// @function              file_write_all_text(_filename, _content)
/// @description           Creates or overwrites a given file with the given string content.
/// @param {string}        _filename - The path of the file to create/overwrite.
/// @param {string}        _content - The content to create/overwrite the file with.
function file_write_all_text(_filename, _content) {
   var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
   buffer_write(_buffer, buffer_string, _content);
   buffer_save(_buffer, _filename);
   buffer_delete(_buffer);
}

/// @function              json_load(_filename)
/// @description           Loads a given JSON file into a GML value (struct/array/string/real).
/// @param {string}        _filename - The path of the JSON file to load.
function json_load(_filename) {
   var _json_content = file_read_all_text(_filename);
   if (is_undefined(_json_content))
      return undefined;
    
   try {
      return json_parse(_json_content);
   } catch (_) {
      // if the file content isn't a valid JSON, prevent crash and return undefined instead
      return undefined;
   }
}

/// @function			json_save(_filename, _value)
/// @description		Saves a given GML value (struct/array/string/real) into a JSON file.
/// @param {string}	_filename - The path of the JSON file to save.
/// @param {any}		_value - The value to save as a JSON file.
function json_save(_filename, _value) {
   var _json_content = json_stringify(_value);
   file_write_all_text(_filename, _json_content);
}