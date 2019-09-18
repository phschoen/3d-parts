use <lib/cube.scad>;
use <lib/cylinder.scad>;
use <lib/triangle.scad>;

w=5;
h_transformer=30+8;
l=25;
$e=0.1;


translate([-80,0,0])
    mount();
translate([  0,0,0])
    mount_2();
translate([+80,0,0])
    mount_3();

module mount()
{
    cube(size=[l,w,h_transformer+w]);
    cube(size=[w,l,h_transformer+w]);

    cube(size=[l,w,h_transformer]);



    difference() {
        w2=10;
        union() {
            translate([-w,-w2,0])
            aligned_rounded_cube([l+w,w+w2,3], 3, [1,1,0], [0,0,0]);
            translate([-w2,-w2,0])
            aligned_rounded_cube([w+w2,l+w2,3], 3, [1,1,0], [0,0,0]);
        }

        d=4;

        translate([-w2/2,l/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
        translate([l/2,-w2/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
    }

    translate([w,w,h_transformer])
    triangle(l-w,l-w,w);

    translate([w,w,0])
    %cube(size=[l*2,l*2,h_transformer]);
}
module mount_2()
{
    translate([-l-w/2,0])
    cube(size=[l+l+w,w,h_transformer+w]);
    translate([-w/2,0])
    cube(size=[w,l,h_transformer+w]);

    cube(size=[l,w,h_transformer]);

    difference() {
        w2=10;
        union() {
            translate([-l-w/2,-w2,0])
            aligned_rounded_cube([l+l+w,w+w2,3], 3, [1,1,0], [0,0,0]);
        }

        d=4;

        translate([l/2,-w2/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
        translate([-l/2,-w2/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
    }

    translate([w/2,w,h_transformer])
    triangle(l-w,l-w,w);

    rotate([0,0,90])
    translate([w,w/2,h_transformer])
    triangle(l-w,l-w,w);

    translate([w,w,0])
    %cube(size=[l*2,l*2,h_transformer]);
}

module mount_3()
{
    l=l*0.7;
    translate([-l,0])
    cube(size=[l+l,w,h_transformer+w]);

    difference() {
        w2=10;
        union() {
            translate([-l,-w2,0])
            aligned_rounded_cube([l+l,w+w2,3], 3, [1,1,0], [0,0,0]);
        }

        d=4;

        translate([l/2,-w2/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
        translate([-l/2,-w2/2,-$e])
        cylinder_flange_sphere($fn=32, r1=d/2, r2=5, h=3.5);
    }

    translate([-l,w,h_transformer])
    cube([2*l,7,w]);

    translate([-l,w,0])
    %cube(size=[l*2,l*2,h_transformer]);
}

module plate() {
    difference() {
        cylinder($fn=128,d=86,h=1);

        translate([0,0,-$e])
        cylinder(d=4,h=1+2*$e);

        translate([30,0,-$e])
        cylinder(d=8,h=1+2*$e);
    }
}
