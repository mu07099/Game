

// --- Movement input ---
var vx = 0;
var vy = 0;
var move_speed_local = 1;

if (keyboard_check(vk_right)) vx = move_speed_local;
if (keyboard_check(vk_left))  vx = -move_speed_local;
if (keyboard_check(vk_up))    vy = -move_speed_local;
if (keyboard_check(vk_down))  vy = move_speed_local;

// --- Update facing if moving ---
if (vx != 0 || vy != 0) {
    if (vx > 0) facing = "right";
    else if (vx < 0) facing = "left";
    else if (vy < 0) facing = "up";
    else if (vy > 0) facing = "down";
}

// --- Stairs detection ---
var on_stairs = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom + 2, Obj_StairTrigger, false, true);


// --- Apply movement ---
if (vx != 0) {
    if (
        !place_meeting(x + vx, y, Obj_Solid)
        && !place_meeting(x + vx, y, Obj_Zombie)
        || on_stairs
    ) {
        x += vx;
    }
}

if (vy != 0) {
    if (
        !place_meeting(x, y + vy, Obj_Solid)
        && !place_meeting(x, y + vy, Obj_Zombie)
        || on_stairs
    ) {
        y += vy;
    }
}


// --- Input buffering for smoother attack chains ---
if (keyboard_check_pressed(ord("S"))) attack_buffer = 20;
if (attack_buffer > 0) attack_buffer--;

// --- Start combo or chain if input buffered ---
if (attack_buffer > 0) {
    if (state != "attacking") {
        combo_step = 1;
        do_attack(combo_step);
        attack_buffer = 0;
    } else if (can_chain && combo_step < 2) {
        combo_step += 1;
        do_attack(combo_step);
        attack_buffer = 0;
    }
}

// --- Allow chaining during certain frames ---
if (state == "attacking") {
    if (image_index >= punch_chain_start && image_index < punch_end_frame)
        can_chain = true;
    else
        can_chain = false;
}

// --- Decrement combo timer ---
if (combo_timer > 0) {
    combo_timer--;
    if (combo_timer <= 0) combo_step = 0;
}

// --- Handle punch collision (robust area-based check) ---
if (state == "attacking") {
    // choose the frame(s) that should register a hit (use integer frames)
    var active_frame = (combo_step == 1) ? 1 : 4;            // adjust if needed
    var active_frame_end = (combo_step == 1) ? 2 : 5;        // optional multi-frame active window

    // Only run once when the attack reaches the active frame(s)
    var cur_frame = floor(image_index);
    if (cur_frame >= active_frame && cur_frame <= active_frame_end && !attack_has_hit) {

        // Hit area parameters (tweak reach/size to taste)
        var reach = 5;      // distance in front of the player
        var hit_w = 24;      // hitbox width
        var hit_h = 24;      // hitbox height

        // Calculate offset in the direction the player is facing
        var offx = 0;
        var offy = 0;
        switch (facing) {
            case "right": offx = reach; break;
            case "left":  offx = -reach; break;
            case "up":    offy = -reach; break;
            case "down":  offy = reach; break;
        }

        // Rectangle coordinates centered on the offset point
        var left   = x + offx - hit_w * 0.5;
        var top    = y + offy - hit_h * 0.5;
        var right  = x + offx + hit_w * 0.5;
        var bottom = y + offy + hit_h * 0.5;

        // store for optional debug drawing
        last_hitbox_left   = left;
        last_hitbox_top    = top;
        last_hitbox_right  = right;
        last_hitbox_bottom = bottom;

        // Check for any zombie inside that rectangle (uses zombie mask)
        var inst = collision_rectangle(left, top, right, bottom, Obj_Zombie, false, true);
        if (inst != noone) {
            show_debug_message("Zombie hit!");
            with (inst) {
                // if you implemented take_damage(amount, source), pass the player as source
                // otherwise just reduce hp or set hit flash variables here
                if (is_undefined(take_damage)) {
                    // fallback: try fields directly (if you didn't create the function)
                    if (variable_instance_exists(id, "hp")) hp -= 1;
                    if (variable_instance_exists(id, "hit_flash_timer")) hit_flash_timer = 10;
                } else {
                    take_damage(1, other);
                }
            }
        }

        attack_has_hit = true;
    }

    // reset attack_has_hit when leaving the active window, so next punch can hit again
    if (cur_frame < active_frame || cur_frame > active_frame_end) {
        attack_has_hit = false;
    }
}



// --- Walking / idle sprite logic ---
if (state == "attacking") {
    // handled in attack function
} else if (vx != 0 || vy != 0) {
    state = "walking";
    if (facing == "right") { sprite_index = Rechts_Bewegen; image_xscale = 1; }
    else if (facing == "left") { sprite_index = Rechts_Bewegen; image_xscale = -1; }
    else if (facing == "up") { sprite_index = Achteren_Bewegen; image_xscale = 1; }
    else if (facing == "down") { sprite_index = Voren_Bewegen; image_xscale = 1; }
} else {
    state = "idle";
    if (facing == "right") { sprite_index = Rechts_Stil; image_xscale = 1; }
    else if (facing == "left") { sprite_index = Rechts_Stil; image_xscale = -1; }
    else if (facing == "up") { sprite_index = Achteren_Stil; image_xscale = 1; }
    else if (facing == "down") { sprite_index = Voren_Stil; image_xscale = 1; }
}

// --- Reset attack after animation ends ---
if (state == "attacking" && image_index >= punch_end_frame) {
    state = "idle";
    can_chain = false;
    combo_timer = combo_timeout;
}

// --- Door interaction ---
if (keyboard_check_pressed(vk_up)) {
    var checkDist = 8;
    var offx = 0;
    var offy = 0;
    if (facing == "up") offy = -checkDist;
    else if (facing == "down") offy = checkDist;
    else if (facing == "left") offx = -checkDist;
    else if (facing == "right") offx = checkDist;

    var door_inst = instance_place(x + offx, y + offy, Obj_LevelDeur);
    if (door_inst != noone) {
        with (door_inst) {
            if (door_state == 0) door_state = 1;
        }
    }
}

// --- Attack function ---
function do_attack(step) {
    switch (facing) {
        case "right": sprite_index = Rechts_Slaan; image_xscale = 1; break;
        case "left":  sprite_index = Rechts_Slaan; image_xscale = -1; break;
        case "up":    sprite_index = Achteren_Slaan; image_xscale = 1; break;
        case "down":  sprite_index = Voren_Slaan; image_xscale = 1; break;
    }

    if (step == 1) {
        image_index = 0; // first punch frames 0–2
        punch_chain_start = 1;
        punch_end_frame = 3;
    } else if (step == 2) {
        image_index = 3; // second punch frames 3–5
        punch_chain_start = 4;
        punch_end_frame = 6;
    }

    image_speed = 1;
    state = "attacking";
    combo_timer = combo_timeout;
    can_chain = false;
    attack_has_hit = false;
}

