var ydiff = 0;
var xdiff = 0;

var movementDiff = 5;
if(keyboard_check(vk_shift)) {
    movementDiff = 7;
}

if(hspeed == 0 && vspeed == 0) {
    if(keyboard_check(ord('W')))
        ydiff -= movementDiff;
    if(keyboard_check(ord('S')))
        ydiff += movementDiff;
    if(keyboard_check(ord('A')))
        xdiff -= movementDiff;
    if(keyboard_check(ord('D')))
        xdiff += movementDiff;
}

if(xdiff != 0 && ydiff != 0) { //Only allow a maximum movement speed of 5, even when moving diagonally.
    var angle = arctan(ydiff/xdiff);
    
    var md = 1;
    if(ydiff < 0) md = -1;
    
    ydiff = cos(angle)*movementDiff*md;
    xdiff = sin(angle)*movementDiff*md;
}

var collider = instance_place(x+xdiff, y+ydiff, WallObject);

if(collider == noone) {
    y += ydiff;
    x += xdiff;
} else {

    collider = instance_place(x+xdiff, y, WallObject);
    if(collider == noone) {
        x += xdiff;
    } else {
        collider = instance_place(x, y+ydiff, WallObject);
        if(collider == noone)
            y += ydiff;
    }
}

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
if(hspeed == 0 && vspeed == 0) {
    for(var i = 0; i < instance_number(Hazard); i++) {
        with(instance_find(Hazard, i)) {
            solid = 1;
        }
    }
} else {
    for(var i = 0; i < instance_number(Hazard); i++) {
      with(instance_find(Hazard, i)) {
        solid = 0;
      }
    }
}
