use <lib/cube.scad>;
use <lib/cylinder.scad>;
use <lib/triangle.scad>;

d=2;
h=d*3;
wall=1;
cut=0.3;
$e =0.01;
grip=3;
$fn=32;

difference()
{
    cylinder(d=d+2*wall,h=h);
    // top
    translate([0,0,h-d+$e])
    cylinder_flange_sphere(r1=d/2, r2=(d+2*wall)/2, h=d);
    // mid
    translate([0,0,d-2*$e])
    cylinder(d=d,h=h);
    // bot
    translate([0,0,-$e])
    cylinder_flange_sphere(r2=d/2, r1=(d+2*wall)/2, h=d);
    // sidecut
    translate([0,0,-$e])
    aligned_cube([d+wall*3,cut,h+2*$e],[0,1,0]);
}

for (i=[-1,1]) {
    rotate([0,0,i*75])
    translate([d/2+wall*2,0,d/2])
    aligned_rounded_cube([grip,wall,h-d],wall/3);
}