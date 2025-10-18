/// @function take_damage(amount, source)
/// Called when the zombie is punched
function take_damage(amount, source) {
    if (is_dead) return; // already dead

    hp -= amount;
    hit_flash_timer = 10; // flash for 10 frames
}
