use <lib/cube.scad>;
use <lib/cylinder.scad>;
$fn=64;
$e=0.01;
h=13.5;
w=6.2+0.3;
l1=30;
l2=60;
t=3;

difference()
{
    translate([-t,-t,-2*t+$e])
    color("gray")
    union() {
        cube([l1+w+t-$e,w+2*t,h+2*t]);
        cube([w+2*t,l2+w+t-$e,h+2*t]);
    }
    color("gree")
    translate([0,0,2*$e])
    union() {
        cube([l1+w,w,h]);
        cube([w,l2+w,h]);
    }
}

translate([w+t,w+t,-2*t])
difference()
{
    cube([10,10,2*t]);  
    translate([5,5,-$e])
        cylinder(d=5,h=2*t+2*$e);  
}