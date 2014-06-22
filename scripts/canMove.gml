/**
 * Me4502's Sane Collision Detection v0.1!
 * User Defined Event 0 is collision. 
 *
 * Arguments:
 * (0) - Mode (0 = All, 1 = Walls)
 * (1) - oldX
 * (2) - oldY
 * (3) - newX
 * (4) - newY
 */

oldX = argument1;
oldY = argument2;
newX = argument3;
newY = argument4;
  
//Pass the arguments to global event variables.
event0Cancelled = 0;
event0OldX = oldX;
event0OldY = oldY;
event0NewX = newX;
event0NewY = newY;
event0Collided = noone;

//Now, we check for collidables in the area.
collidables[0] = WallObject;
collidables[1] = Hazard;
collidables[2] = ConditionalWallObject;

//For every collidable, perform these checks
for(var i = 0; i < 3; i++) {
    
    //If wall mode, don't check hazards
    if(argument0 == 1 && i == 1) continue;
    
    //Perform many checks in different locations for collision
    var collider = instance_place(event0NewX, event0NewY, collidables[i]);
    event0Collided = collider;
    
    if(collider == noone) {
        continue;
    } else {
        collider = instance_place(event0NewX, event0OldY, collidables[i]);
        if(collider == noone && event0NewY != event0OldY) {
            event0NewY = event0OldY;
            continue;
        } else {
            collider = instance_place(event0OldX, event0NewY, collidables[i]);
            if(collider == noone && event0NewX != event0OldX) {
                event0NewX = event0OldX;
                continue;
            } else {
                event0Cancelled = 1;
                break;
            }
        }
    }
}

//Is the new position outside?
if(event0NewX+32 > room_width || event0NewX < 0) {
    event0NewX = event0OldX;
    event0Collided = 0;
} else if(event0NewY+32 > room_height || event0NewY < 0) {
    event0NewY = event0OldY;
    event0Collided = 0;
}

//A partial method of allowing smoother collision detection, only works sometimes
if(event0OldX == event0NewX && event0OldY == event0NewY)
    event0Cancelled = 1;
else if(event0Cancelled == 1) {
    if(event0NewX != event0OldX) {
        if(event0NewX > event0OldX)
            event0NewX -= min(1,event0NewX-event0OldX);
        if(event0NewX < event0OldX)
            event0NewX += min(1,event0OldX-event0NewX);
    } else if(event0NewY != event0OldY) {
        if(event0NewY > event0OldY)
            event0NewY -= min(1,event0NewY-event0OldY);
        if(event0NewY < event0OldY)
            event0NewY += min(1,event0OldY-event0NewY);
    } else {
        script_execute(canMove, argument1, event0OldX, event0OldY, event0NewX, event0NewY);
        return 1;
    }
}

//Send the event out to objects
event_user(0);

//Check if the event succeeded
if(event0Cancelled == 0) {
    event0Success = 1;
} else {
    event0Success = 0;
}
