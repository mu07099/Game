//switch (door_state) {
//    case 0: // closed
//        // do nothing
//        break;

//    case 1: // opening
//        sprite_index = Deur_Gaat_Open; // your opening animation
//        image_speed = 0.2; // play animation
//        if (image_index >= image_number - 1) {
//            // once animation is done
//            door_state = 2;
//            sprite_index = Deur_Open;
//            image_speed = 0;
//        }
//        break;

//    case 2: // open
//        sprite_index = Deur_Open;
//        image_speed = 0;
//		mask_index = -1;

//        // optionally disable collision
//        break;
//}


switch (door_state) {
    case 0:  // closed
        // do nothing
        break;

    case 1:  // opening
        sprite_index = Deur_Gaat_Open;
        image_speed = 0.2;
        if (image_index >= image_number - 1) {
            door_state = 2;
            // swap object to the open-door object (no collision)
            instance_change(Obj_Open_Deur, true);
            // (the "true" means “keep the current image_index / sprite frame”)
        }
        break;

    case 2:
        // (you probably don’t need to do anything here if the object is already changed)
        break;
}
