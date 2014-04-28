var ydiff = 0;
var xdiff = 0;

if(keyboard_check(ord('W')))
    ydiff -= 5;
if(keyboard_check(ord('S')))
    ydiff += 5;
if(keyboard_check(ord('A')))
    xdiff -= 5;
if(keyboard_check(ord('D')))
    xdiff += 5;

if(xdiff != 0 && ydiff != 0) { //Only allow a maximum movement speed of 5, even when moving diagonally.
    var angle = arctan(ydiff/xdiff);
    
    var md = 1;
    if(ydiff < 0) md = -1;
    
    y += cos(angle)*5*md;
    x += sin(angle)*5*md;
} else {
    y += ydiff;
    x += xdiff;
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
