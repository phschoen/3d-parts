
$e=0.1;
$fn=64;
use <lib/cube.scad>
use <lib/cylinder.scad>


d=47;
difference(){
    intersection() {
        cylinder(d=d,h=24);

        hull(){
            translate([d/2,0,0])
            aligned_cube([1,d,5]);

            translate([-d/2,0,0])
            aligned_cube([1,d,20]);
        }
    }
    translate([-d/2,0,-$e])
    aligned_cube([d,9.5,24]);
    translate([0,0,-$e])
    aligned_cube([16,16,23]);
}