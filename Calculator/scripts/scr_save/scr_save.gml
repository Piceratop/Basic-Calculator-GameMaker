function save_equations() {
	var _file = file_text_open_write("saved_equation.txt");
	file_text_write_real(_file, global.equations);
}