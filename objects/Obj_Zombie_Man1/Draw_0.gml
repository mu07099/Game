var left = bbox_left;
var right = bbox_right;
var top = bbox_top;
var bottom = bbox_bottom;
draw_path(path_Zombie,x,y,1);
draw_set_color(c_red);
draw_rectangle(left,top,right,bottom,false);
draw_set_alpha(0.3);
draw_self();