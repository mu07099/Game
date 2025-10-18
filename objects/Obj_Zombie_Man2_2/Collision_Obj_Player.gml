if (!stopped && !waiting_to_resume) {
    stopped = true;
    
    // Save current path speed (could be negative if reversing)
    current_speed = path_speed;
    
    // Pause
    path_speed = 0;
    speed = 0;
}
