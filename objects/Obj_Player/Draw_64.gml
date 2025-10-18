/// Draw GUI: Health hearts that scale with resolution

// --- Base resolution (reference) ---
var base_w = 854;
var base_h = 480;

// --- Compute GUI scaling ---
var gui_scale_x = display_get_gui_width() / base_w;
var gui_scale_y = display_get_gui_height() / base_h;
var gui_scale = min(gui_scale_x, gui_scale_y) * 3; // uniform scale, can adjust multiplier

// --- Heart sprite info ---
var heart_sprite = Health; // your 3-heart sprite
var total_hearts = max_health;
var heart_width = sprite_get_width(heart_sprite) / total_hearts;
var heart_height = sprite_get_height(heart_sprite);

// --- Position: bottom-left corner ---
var x_pos = 16 * gui_scale; // some margin from left
var y_pos = display_get_gui_height() - (heart_height * gui_scale) - (16 * gui_scale); // margin from bottom

// --- How much of the sprite to draw based on health ---
var draw_width = heart_width * health;

// --- Draw the hearts ---
draw_sprite_part_ext(
    heart_sprite,    // sprite
    0,               // subimg
    0,               // left
    0,               // top
    draw_width,      // width
    heart_height,    // height
    x_pos,           // x
    y_pos,           // y
    gui_scale,       // xscale
    gui_scale,       // yscale
    c_white,         // color
    1                // alpha
);
