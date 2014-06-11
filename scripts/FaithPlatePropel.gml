var fdirection = direction;
var fpower = movepower;
var ox = x-16, oy = y-16;
with(other) {

    var hor = cos(fdirection * pi / 180)*fpower;
    var ver = sin(fdirection * pi / 180)*fpower;
    
    if(abs(hor - hspeed) > 2 || abs(ver - vspeed) > 2) {
        x = ox;
        y = oy;
    }
    
    hspeed = hor;
    vspeed = ver;
}
