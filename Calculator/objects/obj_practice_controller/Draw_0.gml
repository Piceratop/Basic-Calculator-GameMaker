for (var _i = 0; _i < flexpanel_node_get_num_children(glb_practice.flex_option); _i++) {
   var _question_set_metadata_pos = flexpanel_node_layout_get_position(flexpanel_node_get_child(glb_practice.flex_option, _i), false);
   
   var _t_color = draw_get_color();
   draw_set_color(c_aqua);
	draw_rectangle(
      _question_set_metadata_pos.left, _question_set_metadata_pos.top,
      _question_set_metadata_pos.left + 10, _question_set_metadata_pos.top + 10, false);
   draw_set_color(_t_color);
}