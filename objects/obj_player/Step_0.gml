/// @description Insert description here
// You can write your code in this editor

//sprite_index = spr_player

if(keyboard_check(ord("W")) && place_free(x, y-spd)){
	y-=spd;
}else if(keyboard_check(ord("S")) && place_free(x, y+spd)){
	y+=spd;
}
if(keyboard_check(ord("A")) && place_free(x-spd, y)){
	x-=spd;
	image_xscale = -1;
}else if(keyboard_check(ord("D")) && place_free(x+spd, y)){
	x+=spd;
	image_xscale = 1;
}

cx = x - view_wport[0]/2;
cy = y - view_hport[0]/2;
min_view_x = 0;
min_view_y = 0;
max_view_x = room_width - view_wport[0];
max_view_y = room_height - view_hport[0];
cx = clamp(cx, min_view_x, max_view_x);
cy = clamp(cy, min_view_y, max_view_y);

camera_set_view_pos(view_camera[0], cx, cy);
depth = -y;

if(place_meeting(x,y,obj_enemy) || place_meeting(x,y,obj_enemy2) ){
	if(random(100) < 30){
		global.life--;
		audio_play_sound(snd_hurt, 1, false);
	}
}

if(global.life <= 0){
	show_message("RIP");
	room_restart();
	global.life = 100;
}

if(mouse_check_button_pressed(mb_left)){
	var arrow = instance_create_depth(x,y,1, obj_arrow);
	arrow.image_angle = point_direction(x,y,mouse_x,mouse_y);
	arrow.direction = point_direction(x,y,mouse_x,mouse_y);
	arrow.speed = 7;
}

if(instance_number(obj_enemy) == 0){
	if(room == room_last){
		room_goto_previous();
	}else{
		room_goto_next();
	}	
}