event_inherited(); // runs parent zombie Create code
// --- Movement & Path setup ---
waiting_to_resume = false;
//normal_speed = 0.66666666666666;
normal_speed = 0.90;
stopped = false;
current_speed = normal_speed;
mask_index = Zombie_Man1_Voren_Stil;
path_start(Path3, normal_speed, path_action_reverse, true);


