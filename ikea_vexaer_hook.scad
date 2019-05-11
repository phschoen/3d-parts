use <lib/cube.scad>;
use <lib/cylinder.scad>;
use <lib/triangle.scad>;
$fn=64;


w=10;
$eps=0.1;
translate([0,2*w,0]){
    //vexer_hook();
}
translate([0,0*w,0]){
    //vexer_side_hook();
}

translate([0,-2*w,0]){
    rope_hook();
}



module vexer_hook() {
//left
    d=3.5;
    hook_w=3.5;
    
aligned_rounded_cube([d,w, 15 + d], 1, [1,1,1], [0,0,0]);

// top
translate([0,0,15])
aligned_rounded_cube([2*d+hook_w,w,d], 1, [1,1,1], [0,0,0]);

// mid
translate([d+hook_w,0,0])
{
    aligned_rounded_cube([d,w, 15+d], 1, [1,1,1], [0,0,0]);

    aligned_rounded_cube([8,w, d], 1, [1,1,1], [0,0,0]);

    translate([d+2,0,0])
    aligned_rounded_cube([8,w, d+6], 1, [1,1,1], [0,0,0]);
}

}


module vexer_side_hook() {
//left
    d=4.5;
    hook_w=5.85;
    
aligned_rounded_cube([d,w, 15 + d], 1, [1,1,1], [0,0,0]);

// top
translate([0,0,15])
aligned_rounded_cube([2*d+hook_w,w,d], 1, [1,1,1], [0,0,0]);

// mid
translate([d+hook_w,0,0])
{
    aligned_rounded_cube([d,w, 15+d], 1, [1,1,1], [0,0,0]);

    aligned_rounded_cube([8,w, d], 1, [1,1,1], [0,0,0]);

    translate([d+2,0,0])
    aligned_rounded_cube([8,w, d+6], 1, [1,1,1], [0,0,0]);
}

}

module rope_hook() {

difference() {
    d = 3.5;
    // mid
    union()
    {
        aligned_rounded_cube([d,w, 15+d], 1, [1,1,1], [0,0,0]);

        aligned_rounded_cube([8,w, d], 1, [1,1,1], [0,0,0]);

        hull() {
            translate([d+2,0,0])
            aligned_rounded_cube([8,w, d+6], 1, [1,1,1], [0,0,0]);
            
            translate([d+2,0,0])
            aligned_rounded_cube([8+1.5,w, 2.5], 1, [1,1,1], [0,0,0]);
        }
    }

    translate([-$eps,w/2,15])
    rotate([0,90,0])
    cylinder(d=3.5, h=7);
}

}
