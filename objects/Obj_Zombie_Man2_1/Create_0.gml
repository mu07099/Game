event_inherited();
// Store speed and state info
// Flags to control stopping/resuming
waiting_to_resume = false;
//normal_speed = 0.66666666666666;
normal_speed = 0.90;
stopped = false;
current_speed = normal_speed;
mask_index = Zombie_Man2_Voren_Stil;
path_start(Path4,normal_speed,path_action_reverse,true);
