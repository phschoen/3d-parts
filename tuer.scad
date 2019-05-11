use <lib/cube.scad>
use <lib/cylinder.scad>
use <lib/MCAD/gears.scad>

use <lib/gear_v1.1.scad>
number_of_teeth = 30;
mm_per_tooth= 5;

pi = 3.1415926;
tuer_d = 30;
tuer_h = 25;
eps=0.1;
$fn =32;

ratio=2;

module tuerknauf() {
    color("gray") difference()
    {

        cylinder(d=tuer_d,h=tuer_h);

        // cube cut
        translate([0,tuer_d/2 + 25,-eps])
        aligned_cube([tuer_d*2,tuer_d*2, tuer_h+2*eps]);
    }
}

module gear_tuer() {
    h=8;
    difference() {
        gear(
            mm_per_tooth    = mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
            number_of_teeth = number_of_teeth,   //total number of teeth around the entire perimeter
            thickness       = h,    //thickness of gear in mm
            hole_diameter   = 0,    //diameter of the hole in the center, in mm
            twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
            teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
            pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
            clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
            backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
            );

        translate([0,0,-h/2-eps])
        scale(1.02)
        tuerknauf();
    }
}
module gear_servo() {
    h=8;
    translate([0,number_of_teeth*pi/2+1,0])
    difference() {
        rotate([0,0,(360/number_of_teeth/2)+ 360/number_of_teeth*(-7+$t*number_of_teeth)])
        union() {
            gear(
                mm_per_tooth    = mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
                number_of_teeth = number_of_teeth,   //total number of teeth around the entire perimeter
                thickness       = h,    //thickness of gear in mm
                hole_diameter   = 4,    //diameter of the hole in the center, in mm
                twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
                teeth_to_hide   = number_of_teeth*0.25,    //number of teeth to delete to make this only a fraction of a circle
                pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
                clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
                backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
                );
            translate([0,0,-h/2])
            cylinder(d=number_of_teeth*1.4,h=h);
        }
        cylinder(d=4,h=h);
        translate([0,0,-h/2-eps])
        cylinder(d=2,h=h);
    }
}

gear_servo();
if ($t >=  0.75)
{
    rotate([0,0,360/number_of_teeth*(-0.75*number_of_teeth)]) {
        gear_tuer();
        tuerknauf();
    }
} else {
    rotate([0,0,360/number_of_teeth*(-1*$t*number_of_teeth)]) {
        gear_tuer();
        tuerknauf();
    }
}
