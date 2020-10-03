q=4;

module rcube(siz, rad) {
    xi = max(0,siz[0]/2-rad);
    yi = max(0,siz[1]/2-rad);
    hi =  siz[2];

    hull() {
        translate([ xi, yi,0]) cylinder(r=rad,h=hi, center=true, $fn=10*q);
        translate([-xi, yi,0]) cylinder(r=rad,h=hi, center=true, $fn=10*q);
        translate([ xi,-yi,0]) cylinder(r=rad,h=hi, center=true, $fn=10*q);
        translate([-xi,-yi,0]) cylinder(r=rad,h=hi, center=true, $fn=10*q);
  }
}

module DHT22() {
    difference() {
        color([0.99,0.99,0.99]) union(){
            rcube([15.4,20.2,8],0.5);
            hull() {
                translate([ 7.2, -9.6,-4]) cylinder(d=1,h=1.5,$fn=5*q);
                translate([-7.2, -9.6,-4]) cylinder(d=1,h=1.5,$fn=5*q);
                translate([ 4.5,-14.5,-4]) cylinder(d=2,h=1.5,$fn=5*q);
                translate([-4.5,-14.5,-4]) cylinder(d=2,h=1.5,$fn=5*q);
            }
        }
        translate([ 0.0,-13,-4]) cylinder(d=2.5,h=10,center=true, $fn=5*q);
        for(i = [1:5]) {
            translate([ 0  , -9+2.5*i,4]) cube([1.25,1.25,6], center=true);
            translate([ 2.5, -9+2.5*i,4]) cube([1.25,1.25,6], center=true);
            translate([-2.5, -9+2.5*i,4]) cube([1.25,1.25,6], center=true);
            translate([ 6  , -9+2.5*i,4]) cube([3.1,1.25,6], center=true);
            translate([-6  , -9+2.5*i,4]) cube([3.1,1.25,6], center=true);
        }
            translate([ 0  , -10,4]) cube([1.25,3,6], center=true);
            translate([ 2.5, -10,4]) cube([1.25,3,6], center=true);
            translate([-2.5, -10,4]) cube([1.25,3,6], center=true);           
    }
    color("Grey"     ) for(i = [1:4]) {
        translate([ 6-2.5*i  , 10,-1.5]) cube([0.5,7.5,0.3]);
    }
}
DHT22();
