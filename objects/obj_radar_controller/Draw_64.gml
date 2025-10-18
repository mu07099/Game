/// Draw GUI: MGS1-style radar with full map walls and vision cones

// --- Radar setup ---
var radar_w = 420;
var radar_h = 320;
var radar_x = display_get_gui_width() - radar_w - 16;
var radar_y = 16;

// --- Player reference ---
var pl = instance_find(Obj_Player, 0);
if (pl == noone) exit;

// --- Radar background ---

draw_set_color(make_color_rgb(10, 10, 40)); // deep navy


draw_rectangle(radar_x, radar_y, radar_x + radar_w, radar_y + radar_h, false);

// --- Draw thick black outline ---
draw_set_color(c_black);
var outline_thickness = 3;
for (var i = 0; i < outline_thickness; i++) {
    draw_rectangle(
        radar_x - i, radar_y - i, 
        radar_x + radar_w + i, radar_y + radar_h + i, 
        true
    );
}

//// --- Compute map bounds from solids ---


var min_x = 1000000000;
var min_y = 1000000000;
var max_x = -1000000000;
var max_y = -1000000000;

with (Obj_Solid) {
    if (bbox_left < min_x) min_x = bbox_left;
    if (bbox_top < min_y) min_y = bbox_top;
    if (bbox_right > max_x) max_x = bbox_right;
    if (bbox_bottom > max_y) max_y = bbox_bottom;
}

// --- Scale factors to fit map into radar ---
var map_w = max_x - min_x;
var map_h = max_y - min_y;
var scale_x = radar_w / map_w;
var scale_y = radar_h / map_h;
var radar_scale = min(scale_x, scale_y); // keep proportions

// --- Draw solids (walls) scaled to radar ---
with (Obj_Solid) {
    var rx1 = radar_x + (bbox_left - min_x) * radar_scale;
    var ry1 = radar_y + (bbox_top - min_y) * radar_scale;
    var rx2 = radar_x + (bbox_right - min_x) * radar_scale;
    var ry2 = radar_y + (bbox_bottom - min_y) * radar_scale;

    draw_set_color(make_color_rgb(150, 150, 150));
    draw_rectangle(rx1, ry1, rx2, ry2, false); // outline
}

// --- Draw player dot ---
var player_rx = radar_x + (pl.x - min_x) * radar_scale;
var player_ry = radar_y + (pl.y - min_y) * radar_scale;
draw_set_color(make_color_rgb(0, 255, 0));
draw_circle(player_rx, player_ry, 6, false);

// --- Draw zombies with vision cones ---
with (Obj_Zombie) {
    var rx = radar_x + (x - min_x) * radar_scale;
    var ry = radar_y + (y - min_y) * radar_scale;

    // Determine zombie facing
    var zombie_angle;
    if (variable_instance_exists(id, "facing")) {
        switch(facing) {
            case "right": zombie_angle = 0; break;
            case "down":  zombie_angle = 90; break;
            case "left":  zombie_angle = 180; break;
            case "up":    zombie_angle = 270; break;
            default:     zombie_angle = 0; break;
        }
    } else zombie_angle = direction;

    // LOS check
    var player_clear = !collision_line(x, y, pl.bbox_left, pl.bbox_top, Obj_Solid, true, true) &&
                       !collision_line(x, y, pl.bbox_right, pl.bbox_top, Obj_Solid, true, true) &&
                       !collision_line(x, y, pl.bbox_left, pl.bbox_bottom, Obj_Solid, true, true) &&
                       !collision_line(x, y, pl.bbox_right, pl.bbox_bottom, Obj_Solid, true, true);

    var angle_to_player = point_direction(x, y, pl.x, pl.y);
    var vision_angle_half = 25;
    var vision_range_world = 64;
    var dist_to_player = point_distance(x, y, pl.x, pl.y);
    var player_in_cone = (abs(angle_difference(zombie_angle, angle_to_player)) <= vision_angle_half &&
                          dist_to_player <= vision_range_world &&
                          player_clear);

    // Draw zombie dot
    draw_set_color(player_in_cone ? c_yellow : c_red);
    draw_circle(rx, ry, 6, false);

    // Draw vision cone starting slightly in front of the zombie
    var cone_len = vision_range_world * radar_scale;
    var offset = 0.1 * radar_scale; // offset in front of dot
    var base_x = rx + lengthdir_x(offset, zombie_angle);
    var base_y = ry + lengthdir_y(offset, zombie_angle);

    var left_ang  = zombie_angle - vision_angle_half;
    var right_ang = zombie_angle + vision_angle_half;

    var x1 = base_x;
    var y1 = base_y;
    var x2 = base_x + lengthdir_x(cone_len, left_ang);
    var y2 = base_y + lengthdir_y(cone_len, left_ang);
    var x3 = base_x + lengthdir_x(cone_len, right_ang);
    var y3 = base_y + lengthdir_y(cone_len, right_ang);
    // Change cone color based on player visibility
    if (player_in_cone) draw_set_color(c_red);      // player detected → red
    else draw_set_color(make_color_rgb(0,180,255)); // normal cone → blue

    //draw_set_color(make_color_rgb(0,180,255));
    draw_set_alpha(0.5);
    draw_triangle(x1, y1, x2, y2, x3, y3, false);
    draw_set_alpha(1);
}










