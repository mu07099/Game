var left = bbox_left;
var right = bbox_right;
var top = bbox_top;
var bottom = bbox_bottom;
// Draw hitbox when attacking
if (state == "attacking" && variable_instance_exists(id, "last_hitbox_left")) {
    draw_set_alpha(0.5);
    draw_set_color(c_lime);
    draw_rectangle(last_hitbox_left, last_hitbox_top, last_hitbox_right, last_hitbox_bottom, false);
    draw_set_color(c_white);
    draw_set_alpha(1);
}

draw_set_color(c_red);
draw_rectangle(left,top,right,bottom,false);
draw_set_alpha(0.3);
draw_self();

