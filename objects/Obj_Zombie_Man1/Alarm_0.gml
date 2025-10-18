//path_speed = normal_speed; // resume moving
// Resume path movement
path_speed = normal_speed;
stopped = false;
waiting_to_resume = false;
path_delete(path_Zombie);
path_Zombie = path_add();
target_x = Obj_Player.x;
target_y = Obj_Player.y;
mp_grid_path(Obj_Setup_Pathway.grid,path_Zombie,x,y,target_x,target_y,1);
path_start(path_Zombie,0.8,path_action_stop,true);
alarm_set(0,60);
