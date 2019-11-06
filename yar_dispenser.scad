use <lib/cube.scad>;
use <lib/cylinder.scad>;
$fn=128;
$e=0.01;

d=28.75;
d_e=d+0.5;
d2=34;

difference()
{
    color("gray")
    union() {
        translate([0,0,-1])
            cylinder(d=d2,h=0.5);
        // inner
        r=2;
        translate([0,0,-1])
        cylinder(d1=d_e,d2=d,h=4);
        translate([0,0,r/2])
        minkowski() {
            cylinder(d=d-2*r,h=2);
            sphere(r);
        }
    }
    for(r=[0:359/10:359])
    for(o=[0,5,10])
    {
        rotate([0,0,r]){
            translate([0,o,-5])
            cylinder(d=2,h=10);
        }
    }

}