//////// --- Exit if no follow target ---
//////if (!instance_exists(follow)) exit;

//////// --- Camera target (player position) ---
//////var xTo = follow.x;
//////var yTo = follow.y;

//////// --- Detect stairs ---
//////var on_stairs = place_meeting(follow.x, follow.y + 1, Obj_Trap);

//////// --- Stair vertical offset ---
//////var target_offset = 0;
//////if (on_stairs) {
//////    if (keyboard_check(vk_up)) target_offset = -16;
//////    else if (keyboard_check(vk_down)) target_offset = 16;
//////}
//////stair_cam_offset = lerp(stair_cam_offset, target_offset, 0.1);
//////yTo += stair_cam_offset;

//////// --- Smooth camera follow ---
//////x += (xTo - x) / 25;
//////y += (yTo - y) / 25;

//////// --- Toggle fullscreen ---
//////if (keyboard_check_pressed(vk_f11)) {
//////    is_fullscreen = !is_fullscreen;
//////    window_set_fullscreen(is_fullscreen);
//////}

//////// --- Compute dynamic scale ---
//////if (is_fullscreen) {
//////    var disp_w = display_get_width();
//////    var disp_h = display_get_height();
//////    var scale_x = floor(disp_w / internal_w);
//////    var scale_y = floor(disp_h / internal_h);
//////    scale = max(1, min(scale_x, scale_y));
//////} else {
//////    scale = 1;
//////}

//////// --- Apply camera internal view size ---
//////camera_set_view_size(cam, internal_w, internal_h);

//////// --- Apply integer scaling via viewport ---
//////view_wport[0] = internal_w * scale;
//////view_hport[0] = internal_h * scale;

//////// --- Half sizes for clamping ---
//////var scaled_half_w = (internal_w * scale) / 2;
//////var scaled_half_h = (internal_h * scale) / 2;

//////// --- Clamp camera so scaled viewport stays inside room ---
//////x = clamp(x, scaled_half_w / scale, room_width - scaled_half_w / scale);
//////y = clamp(y, scaled_half_h / scale, room_height - scaled_half_h / scale);

//////// --- Apply camera position ---
////////camera_set_view_pos(cam, x - view_w_half, y - view_h_half);
//////camera_set_view_pos(cam, x - scaled_half_w, y - scaled_half_h);

////// --- Exit if no follow target ---
////if (!instance_exists(follow)) exit;

////// --- Target position ---
////var xTo = follow.x;
////var yTo = follow.y;

////// --- Stair offset ---
////var on_stairs = place_meeting(follow.x, follow.y + 1, Obj_Trap);
////var target_offset = 0;
////if (on_stairs) {
////    if (keyboard_check(vk_up)) target_offset = -16;
////    else if (keyboard_check(vk_down)) target_offset = 16;
////}
////stair_cam_offset = lerp(stair_cam_offset, target_offset, 0.1);
////yTo += stair_cam_offset;

////// --- Smooth camera follow ---
////x += (xTo - x) * follow_lerp;
////y += (yTo - y) * follow_lerp;

////// --- Fullscreen toggle ---
////if (keyboard_check_pressed(vk_f11)) {
////    is_fullscreen = !is_fullscreen;
////    window_set_fullscreen(is_fullscreen);
////}

////// --- Compute dynamic scale ---
////if (is_fullscreen) {
////    var disp_w = display_get_width();
////    var disp_h = display_get_height();
////    var scale_x = floor(disp_w / internal_w);
////    var scale_y = floor(disp_h / internal_h);
////    scale = max(1, min(scale_x, scale_y));
////} else {
////    scale = 1;
////}

////// --- Apply camera view size (internal resolution) ---
////camera_set_view_size(cam, internal_w, internal_h);

////// --- Apply viewport size based on scale ---
////view_wport[0] = internal_w * scale;
////view_hport[0] = internal_h * scale;

////// --- Clamp camera to room boundaries ---
////x = clamp(x, view_w_half, room_width - view_w_half);
////y = clamp(y, view_h_half, room_height - view_h_half);

////// --- Apply camera position (top-left corner) ---
////camera_set_view_pos(cam, x - view_w_half, y - view_h_half);

//if (!instance_exists(follow)) exit;

//// --- Target position ---
//var xTo = follow.x;
//var yTo = follow.y;

//// --- Stair offset ---
//var on_stairs = place_meeting(follow.x, follow.y + 1, Obj_Trap);
//var target_offset = 0;
//if (on_stairs) {
//    if (keyboard_check(vk_up)) target_offset = -16;
//    else if (keyboard_check(vk_down)) target_offset = 16;
//}
//stair_cam_offset = lerp(stair_cam_offset, target_offset, 0.1);
//yTo += stair_cam_offset;

//// --- Smooth follow ---
//x += (xTo - x) * follow_lerp;
//y += (yTo - y) * follow_lerp;

//// --- Clamp camera to room boundaries ---
//var half_w = view_w / 2;
//var half_h = view_h / 2;
//x = clamp(x, half_w, room_width - half_w);
//y = clamp(y, half_h, room_height - half_h);

//// --- Apply camera view ---
//camera_set_view_size(cam, view_w, view_h);
//camera_set_view_pos(cam, x - half_w, y - half_h);
// --- Exit if no player ---
if (!instance_exists(follow)) exit;

// --- Target position ---
var xTo = follow.x;
var yTo = follow.y;

// --- Stair offset ---
var on_stairs = place_meeting(follow.x, follow.y + 1, Obj_Trap);
var target_offset = 0;
if (on_stairs) {
    if (keyboard_check(vk_up)) target_offset = -16;
    else if (keyboard_check(vk_down)) target_offset = 16;
}
stair_cam_offset = lerp(stair_cam_offset, target_offset, 0.1);
yTo += stair_cam_offset;

// --- Smooth follow ---
x += (xTo - x) * follow_lerp;
y += (yTo - y) * follow_lerp;

// --- Clamp camera to room edges ---
var half_w = view_w / 2;
var half_h = view_h / 2;

x = clamp(x, half_w, room_width - half_w);
y = clamp(y, half_h, room_height - half_h);

// --- Apply camera view ---
camera_set_view_size(cam, view_w, view_h);
camera_set_view_pos(cam, x - half_w, y - half_h);
