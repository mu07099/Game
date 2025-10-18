 

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
        var leave_dist = 16; // distance at which zombie resumes
        if (point_distance(x, y, pl.x, pl.y) > leave_dist) {
            waiting_to_resume = true;
            alarm[0] = room_speed * 0.1; // 2 second delay
        }
    }
}


//// Handle attack cooldown
//if (attack_cooldown > 0) {
//    attack_cooldown--;
//}


// --- Player Detection ---
var player = instance_nearest(x, y, Obj_Player);
var can_see_player = false;
var dist_to_player = 0;

if (player != noone) {
    dist_to_player = point_distance(x, y, player.x, player.y);
    if (dist_to_player <= detection_range) {
        // Simple line of sight check
        can_see_player = !collision_line(x, y, player.x, player.y, Obj_Solid, false, true);
    }
}

//// --- AI State Machine ---
//switch (ai_state) {
//    case "patrol":
//        if (can_see_player) {
//            ai_state = "chase";
//            last_seen_x = player.x;
//            last_seen_y = player.y;
//            show_debug_message("Zombie: Player spotted! Switching to CHASE");
//        }
//        // Patrol is handled by the path system automatically
//        break;
        
//    case "chase":
//        if (!can_see_player) {
//            ai_state = "search";
//            ai_timer = search_time;
//            search_points = []; // Reset search points
//            show_debug_message("Zombie: Lost sight of player. Switching to SEARCH");
//        } else if (dist_to_player <= attack_range && attack_cooldown <= 0) {
//            ai_state = "attack";
//            show_debug_message("Zombie: Attacking player!");
//        } else {
//            execute_chase(player);
//        }
//        break;
        
    //case "attack":
    //    if (attack_cooldown <= 0) {
    //        execute_attack(player);
    //        // After attacking, continue chasing if player is still visible
    //        if (can_see_player && dist_to_player > attack_range) {
    //            ai_state = "chase";
    //        } else if (!can_see_player) {
    //            ai_state = "search";
    //            ai_timer = search_time;
    //            search_points = [];
    //        }
    //    }
    //    break;
        
    //case "search":
    //    if (can_see_player) {
    //        ai_state = "chase";
    //        last_seen_x = player.x;
    //        last_seen_y = player.y;
    //        show_debug_message("Zombie: Found player again! Switching to CHASE");
    //    } else {
    //        execute_search();
    //        ai_timer--;
    //        if (ai_timer <= 0) {
    //            ai_state = "return";
    //            show_debug_message("Zombie: Search time expired. Returning to patrol");
    //        }
    //    }
    //    break;
        
//    case "return":
//        execute_return_to_patrol();
//        // If we see player while returning, chase!
//        if (can_see_player) {
//            ai_state = "chase";
//            last_seen_x = player.x;
//            last_seen_y = player.y;
//        }
//        break;
//}