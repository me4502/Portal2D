//Move the variables to instance variables to allow for reference inside with(...){}
var fdirection = direction;
var fpower = movepower;
var ox = x-16, oy = y-16;

with(other) {

    //Find the horizontal and vertical amounts for this angle at this power
    var hor = cos(fdirection * pi / 180)*fpower;
    var ver = sin(fdirection * pi / 180)*fpower;
    
    //Set them to the centre of the plate
    if(abs(hor - hspeed) > 2 || abs(ver - vspeed) > 2) {
        x = ox;
        y = oy;
    }
    
    //Set speeds
    hspeed = hor;
    vspeed = ver;
}
