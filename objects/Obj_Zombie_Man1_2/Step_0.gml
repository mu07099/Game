event_inherited();
if (direction > 45 && direction <= 135) {
    sprite_index = Zombie_Man1_Achteren_Bewegen;
	image_xscale = 1;
} else if (direction > 135 && direction <= 225) {
    sprite_index = Zombie_Man1_Rechts_Bewegen;
	image_xscale = -1;
} else if (direction > 225 && direction <= 315) {
    sprite_index = Zombie_Man1_Voren_Bewegen;
	image_xscale = 1;
} else {
    sprite_index = Zombie_Man1_Rechts_Bewegen;
	//image_xscale = -1;
}


// --- Pause/Resume Logic ---
if (stopped && !waiting_to_resume) {
    // Find nearest player
    var pl = instance_nearest(x, y, Obj_Player);
    if (pl != noone) {
        var leave_dist = 32; // distance at which zombie resumes
        if (point_distance(x, y, pl.x, pl.y) > leave_dist) {
            waiting_to_resume = true;
            alarm[0] = room_speed * 0.2; // 2 second delay
        }
    }
}



