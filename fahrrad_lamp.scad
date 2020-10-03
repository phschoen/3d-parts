lamp_screw = 5;
lamp_screw_offset=20;

use <lib/cube.scad>
wall=2.5;
$fn=64;
$e=0.01;
bike_screw_d=15;
difference() {
    union() {
        cylinder(d=bike_screw_d+2*wall, h=20);
        aligned_rounded_cube(size=[wall*3, bike_screw_d*2 + 2*wall ,20], r=1, rounding=[1,1,1], aligned=[1,1,0]);

        translate([wall*2,-5,0])
        aligned_rounded_cube(size=[wall*3, bike_screw_d+lamp_screw_offset, 20], r=1, rounding=[1,1,1], aligned=[1,0,0]);

        translate([2,lamp_screw_offset,5/2])
        aligned_rounded_cube(size=[20, wall*4, 15], r=1, rounding=[1,1,1], aligned=[0,0,0]);

    }
    translate([0,0,-$e])
        cylinder(d=bike_screw_d,    h=20+2*$e);
    translate([-wall/2,-20,-$e])
        cube([wall,40,20+2*$e]);

    for(x=[-1,1])
    for(y=[0,10]) {
        translate([0,x*12, 5+y])
            rotate([0,90,0])
                cylinder(d=3, h=20, center=true);
    }

    translate([15,30, 10])
    rotate([90,0,0])
    cylinder(d=lamp_screw, h=20, center=true);

}
