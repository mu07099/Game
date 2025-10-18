// Store speed and state info
// Flags to control stopping/resuming
event_inherited();
// AI States: "patrol", "chase", "attack", "search", "return"
ai_state = "patrol";
ai_timer = 0;

// Chase behavior variables
current_chase_dir = 0;                    // Current chasing direction
chase_recalculate_timer = 0;              // Timer for recalculating direction
previous_x = x;                           // Previous position for movement tracking
previous_y = y;

// Detection
player_in_sight = false;
//last_seen_x = -1;
//last_seen_y = -1;
detection_range = 64;                    // Increased from 64
//search_timer = 0;

target_x = Obj_Player.x;
target_y = Obj_Player.y;

alarm[0] = 1;
//// Search behavior
//search_points = [];
//current_search_point = 0;
//search_time = room_speed * 8;             // 8 seconds searching
//search_radius = 96;                      // Increased from 96
//search_stuck_timer = 0;                   // Timer for stuck detection

//// Patrol
//patrol_route = [];
//current_patrol_point = 0;
//patrol_speed = 0.8;

// Path variables
path_Zombie = path_add();
//path_refresh_timer = 0;                   // Refresh every 8-12 steps while chasing

//// Combat
//is_attacking = false;
//attack_cooldown = 0;
//attack_damage = 1;
//attack_cooldown_time = 60;                // frames
//attack_range = 24;                        // Increased from 16

// Movement speeds
normal_speed = 0.80;
//chase_speed = 0.8;                        // Increased from 0.8 - much faster when chasing!
//search_speed = 0.8;                       // Increased from 0.8
current_speed = normal_speed;
waiting_to_resume = false;
//normal_speed = 0.66666666666666;
//normal_speed = 0.90;
stopped = false;
current_speed = normal_speed;
mask_index = Zombie_Man1_Voren_Stil;
path_start(Path1,normal_speed,path_action_reverse,true);


