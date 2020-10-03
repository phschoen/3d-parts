use <lib/cube.scad>
use <lib/cylinder.scad>

$e=0.01;
$fn=64;
wall=2;
r=3;
plate_size=[105,20,wall];

minkowski() {
    translate([r, r,0])
        cube(plate_size-[r,r,0]);
    cylinder(r=r, h = $e);
}

dist=10;
hook_dist=(plate_size[0]- 2*dist)/7;
hook_length = 10;
hook_r =1;

for (i=[dist:hook_dist:(plate_size[0]-dist)])
translate([i, plate_size[1]/2, 0])
minkowski() {
    union() {
        cube([wall, wall, hook_length + wall]);

        translate([0, 0, hook_length ])
            cube([wall, wall*2, wall]);
    }
    cylinder(r=hook_r, h = $e);
}

