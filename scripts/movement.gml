//Variables used for finding the difference in X and Y that should be applied.
var ydiff = 0;
var xdiff = 0;

//By default, they should move a total of 5 pixels.
var movementDiff = 5;

//If the player is sprinting, and are not exhausted, move by 7 pixels. If they're exhausted stop sprinting.
if(sprinting == 1 && exhaustion < 50) {
    movementDiff = 7;
} else {
    sprinting = 0;
}

//If the player is using the movement powerup, increase it by the time left.
if(powerupTimeout > 0) {
    movementDiff += powerupTimeout / 60;
}

//If the player isn't being moved by an aerial faith plate.
if(abs(hspeed) < 1 && abs(vspeed) < 1) {
    //Key handlings for different directions.
    if(keyboard_check(ord('W')))
        ydiff -= movementDiff;
    if(keyboard_check(ord('S')))
        ydiff += movementDiff;
    if(keyboard_check(ord('A')))
        xdiff -= movementDiff;
    if(keyboard_check(ord('D')))
        xdiff += movementDiff;
} else {

    //Will they collide? If so, stop.
    script_execute(canMove, 1, x, y, x+hspeed, y+vspeed);
    
    hspeed = event0NewX-event0OldX;
    vspeed = event0NewY-event0OldY;
}

//Standard collision detection
script_execute(canMove, 0, x, y, x+xdiff, y+ydiff);

if(event0Success == 1) {
    xdiff = event0NewX-event0OldX;
    ydiff = event0NewY-event0OldY;
} else {
    xdiff = 0;
    ydiff = 0;
}

if(xdiff != 0 && ydiff != 0) { //Only allow a maximum movement speed of movementDiff, even when moving diagonally.
    //Get the angle at which ydiff/xdiff points. (Radians)
    var angle = arctan(ydiff/xdiff);
    
    //Multiplier, to fix issues with vertical pixel aligment.
    var md = 1;
    if(ydiff < 0) md = -1;
    
    //Set X and Y diff to the correct lengths for this angle.
    ydiff = cos(angle)*movementDiff*md;
    xdiff = sin(angle)*movementDiff*md;
}

//Modify the players coordinates by the regulated x/y coords.
x += xdiff;
y += ydiff;
    
//If there was a movement, perform this step. (On Move Updates)
if(xdiff != 0 || ydiff != 0) {

    if(collision_circle(x+16, y+16, 16, BluePortalObject, true, true) == noone && lastTouched != 0) {
        lastTouched = 0;
        hasMoved = true;
    }

     if(collision_circle(x+16, y+16, 16, OrangePortalObject, true, true) == noone && lastTouched != 1) {
        lastTouched = 1;
        hasMoved = true;
     }
     
     if(powerupTimeout <= 0) {
        if(movementDiff > 5)
            exhaustion += 1;
        else
            exhaustion -= 0.5;
     } else {
        exhaustion -= 2;
     }
} else {

    //Standing still = Faster recovery
    exhaustion -= 1;
}

//Left/right facing images.
if(xdiff > 0) image_index = 1;
else if(xdiff < 0) image_index = 0;

//When being propelled by an aerial faith plate, don't slow down as fast over lava, so the player doesn't stop in it.
if(collision_circle(x+16, y+16, 16, Hazard, true, true) == noone) {
    if(hspeed != 0)
        hspeed *= 0.925;
    if(vspeed != 0)
        vspeed *= 0.925;
} else {
    if(hspeed != 0)
        hspeed *= 0.99;
    if(vspeed != 0)
        vspeed *= 0.99;
}

if(freecam == 0 && hspeed == 0 && vspeed == 0) {
    script_execute(canMove, 0, x, y, x, y);
    
    if(event0Collided != noone) {
        var i = 0;
        while(true) {
            i++;
            script_execute(canMove, 0, x, y, x+i, y);
            if(event0Collided == noone) {
                x = event0NewX;
                break;
            } else {
                script_execute(canMove, 0, x, y, x-i, y);
                if(event0Collided == noone) {
                    x = event0NewX;
                    break;
                } else {
                    script_execute(canMove, 0, x, y, x, y+i);
                    if(event0Collided == noone) {
                        y = event0NewY;
                        break;
                    } else {
                        script_execute(canMove, 0, x, y, x, y-i);
                        if(event0Collided == noone) {
                            y = event0NewY;
                            break;
                        } else {
                            //Onto the next iteration.
                        }
                    }
                }
            }
        }
    }
}

if(exhaustion < 0)
    exhaustion = 0;
else if(exhaustion > 50)
    exhaustion = 50;
