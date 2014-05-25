var ydiff = 0;
var xdiff = 0;

var movementDiff = 5;
if(keyboard_check(vk_shift)) {
    movementDiff = 7;
}

if(abs(hspeed) < 1 && abs(vspeed) < 1) {
    if(keyboard_check(ord('W')))
        ydiff -= movementDiff;
    if(keyboard_check(ord('S')))
        ydiff += movementDiff;
    if(keyboard_check(ord('A')))
        xdiff -= movementDiff;
    if(keyboard_check(ord('D')))
        xdiff += movementDiff;
} else {
    script_execute(canMove, 1, x, y, x+hspeed, y+vspeed);
    
    hspeed = event0NewX-event0OldX;
    vspeed = event0NewY-event0OldY;
}

script_execute(canMove, 0, x, y, x+xdiff, y+ydiff);

if(event0Success == 1) {
    xdiff = event0NewX-event0OldX;
    ydiff = event0NewY-event0OldY;
} else {
    xdiff = 0;
    ydiff = 0;
}

if(xdiff != 0 && ydiff != 0) { //Only allow a maximum movement speed of 5, even when moving diagonally.
    var angle = arctan(ydiff/xdiff);
    
    var md = 1;
    if(ydiff < 0) md = -1;
    
    ydiff = cos(angle)*movementDiff*md;
    xdiff = sin(angle)*movementDiff*md;
}

x += xdiff;
y += ydiff;
    
if(xdiff != 0 || ydiff != 0) {

    if(collision_circle(x+16, y+16, 16, BluePortalObject, true, true) == noone && lastTouched != 0) {
        lastTouched = 0;
        hasMoved = true;
    }

     if(collision_circle(x+16, y+16, 16, OrangePortalObject, true, true) == noone && lastTouched != 1) {
        lastTouched = 1;
        hasMoved = true;
     }
}

if(xdiff > 0) image_index = 1;
else if(xdiff < 0) image_index = 0;

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
