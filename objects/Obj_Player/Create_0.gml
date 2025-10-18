
// --- Player health setup ---
max_health = 3;   // total number of hearts
health = 3;       // starting health (full)

// --- Facing and movement setup ---
facing = "down";
move_speed = 4;

cam = view_camera[0];
cam_x = x;
cam_y = y;
view_w_half = view_wport[0] / 2;
view_h_half = view_hport[0] / 2;

mask_index = Voren_Stil;

// --- Combo attack variables ---
combo_step = 0;        // 0 = no attack, 1,2 = combo steps
combo_timer = 0;       // countdown before combo resets
combo_timeout = 20;    // frames to allow next combo input
can_chain = false;     // if player can chain next punch
state = "idle";        // "idle", "walking", "attacking"

// --- Attack control variables ---
attack_buffer = 0;     // input buffer for smoother combos
punch_end_frame = 2;   // will update depending on combo
punch_chain_start = 1; // frame window for chaining
attack_has_hit = false; // to prevent multiple hits per punch
if (!instance_exists(obj_radar_controller)) instance_create_layer(x, y, "GUI", obj_radar_controller);
