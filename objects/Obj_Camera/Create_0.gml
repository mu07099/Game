
//// --- Camera Setup ---
//cam = view_camera[0];           // Use the default view camera
//follow = Obj_Player;            // Object to follow
//internal_w = 854;               // Internal resolution width
//internal_h = 480;               // Internal resolution height
//view_w_half = internal_w / 2;
//view_h_half = internal_h / 2;
//// Initialize scale
//scale = 1;
//// Compute scaled half viewport
//var scaled_half_w = (internal_w * scale) / 2;
//var scaled_half_h = (internal_h * scale) / 2;
//// Camera position
//x = follow.x;
//y = follow.y;

//// Fullscreen state
//is_fullscreen = false;

//// Stair offset
//stair_cam_offset = 0;

///// --- Camera Setup ---
//cam = view_camera[0];           // Use default camera
//follow = Obj_Player;            // Object to follow

//// Internal resolution (fixed game view)
//internal_w = 854;
//internal_h = 480;

//// Half-sizes for clamping
//view_w_half = internal_w / 2;
//view_h_half = internal_h / 2;

//// Smooth follow speed
//follow_lerp = 0.04; // smaller = slower, larger = snappier

//// Scale
//scale = 1;
//is_fullscreen = false;

//// Stair vertical offset
//stair_cam_offset = 0;

//// Camera position
//x = follow.x;
//y = follow.y;
//cam = view_camera[0];           // default camera
//follow = Obj_Player;            // object to follow

//// Pokémon-style fixed viewport
//view_w = 854;                   
//view_h = 480;

//// Camera position
//x = follow.x;
//y = follow.y;

//// Smooth follow speed
//follow_lerp = 0.08; // higher = snappier

//// Stair offset
//stair_cam_offset = 0;
/// --- Camera Setup ---
//cam = view_camera[0];       // default camera
//follow = Obj_Player;        // object to follow

//// Set a smaller viewport for Pokémon-style camera
//view_w = 320;               // width of camera view
//view_h = 180;               // height of camera view

//// Smooth follow speed
//follow_lerp = 0.08;         // smaller = smoother, larger = snappier

//// Camera position
//x = follow.x;
//y = follow.y;

//// Stair vertical offset
//stair_cam_offset = 0;



// --- Camera Setup ---
cam = view_camera[0];
follow = Obj_Player;

// Pokémon-style viewport
view_w = 320;
view_h = 180;

// Half-sizes for clamping
var half_w = view_w / 2;
var half_h = view_h / 2;

// If player exists, center camera immediately
if (instance_exists(follow)) {
    x = clamp(follow.x, half_w, room_width - half_w);
    y = clamp(follow.y, half_h, room_height - half_h);
} else {
    x = view_w / 2;
    y = view_h / 2;
}

// Apply initial camera position
camera_set_view_size(cam, view_w, view_h);
camera_set_view_pos(cam, x - half_w, y - half_h);

// Smooth follow speed
follow_lerp = 0.08;

// Stair offset
stair_cam_offset = 0;
