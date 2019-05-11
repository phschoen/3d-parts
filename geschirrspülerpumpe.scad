d1=96;
d2=d1+2*4.5;
add=1;
d3=d2+2*2;
h=25;
h2=5;
$fn=128;
$e=0.01;

use <MCAD/2Dshapes.scad>;

w=11;

intersection() {
    union() {
        // shell
        difference() {
        cylinder(d1=d2,d2=d2+add,h=h);
            translate([0,0,-$e])
        cylinder(d1=d1,d2=d1,h=h+2*$e);
        }
        // grabber
        translate([0,0,h])
        difference() {
            cylinder(d=d3,h=h2);
                translate([0,0,-$e])
            cylinder(d=d1,h=h2+2*$e);
        }
    }

    // only angle part
    translate([0,0,-$e])
    linear_extrude(2*h+2*$e)
    pieSlice(size=d2/2+2, start_angle=0, end_angle=2*w);
}