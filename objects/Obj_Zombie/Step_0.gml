// --- Handle red flash when hit ---
if (hit_flash_timer > 0) {
    hit_flash_timer -= 1;
    image_blend = c_red;
} else {
    image_blend = c_white;
}

// --- Death check ---
if (!is_dead && hp <= 0) {
    is_dead = true;
    instance_destroy(); // remove zombie (you can replace this with a death anim)
}